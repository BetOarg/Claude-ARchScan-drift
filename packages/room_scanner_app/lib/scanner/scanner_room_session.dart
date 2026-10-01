import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:room_scanner_core/room_scanner_core.dart';

import '../l10n/generated/app_localizations.dart';
import '../l10n/room_type_localization.dart';
import '../l10n/validation_error_localization.dart';
import '../providers/floor_plan_provider.dart';
import '../providers/scanner_provider.dart';
import '../screens/floor_plan_viewer_screen.dart';
import '../services/scan_draft_service.dart';
import '../widgets/room_completion_dialog.dart';
import '../widgets/room_name_dialog.dart';

/// Ciclo de vida del ambiente en curso, común a los escáneres AR y Basic.
///
/// Reúne lo que ambas pantallas deben resolver igual: restaurar o descartar
/// borradores, guardarlos mientras se escanea, cerrar y persistir el ambiente
/// y navegar al plano. Cada pantalla aporta solo lo propio de su motor
/// mediante [startScanRoom], [onScanRoomRestored], [scanDraftHistory] y
/// [showScanError].
mixin ScannerRoomSession<T extends StatefulWidget> on State<T> {
  static const ScanDraftService _scanDraftService = ScanDraftService();

  ScanContinuationReference? activeContinuationReference;
  RoomModel? activeResumeRoom;

  ScannerProvider? _draftProvider;
  Timer? _draftSaveTimer;
  String? _lastDraftFingerprint;
  bool _closingRoom = false;

  /// UUID del proyecto al que pertenece el borrador.
  String get scanProjectUuid;

  /// Inicia un ambiente nuevo (con o sin continuación) en el motor.
  void startScanRoom(ScannerProvider provider);

  /// Se invoca después de restaurar un ambiente abierto o un borrador.
  ///
  /// [history] es el recorrido Basic guardado en el borrador; puede estar
  /// vacío cuando solo se conocen los puntos del ambiente.
  void onScanRoomRestored(RoomModel room, List<ARPoint> history) {}

  /// Recorrido adicional que debe persistirse junto al borrador.
  List<ARPoint> scanDraftHistory() => const <ARPoint>[];

  /// Muestra un error de escaneo con el estilo propio de la pantalla.
  void showScanError(String message);

  /// Maps a [ValidationResult] error to the localized message, falling back to
  /// the embedded Spanish string when no error code is available.
  String localizedValidationError(
    ValidationResult result,
    AppLocalizations l10n,
  ) =>
      validationErrorMessage(
        result,
        l10n,
        fallback: result.errorMessage ?? l10n.unknownError,
      );

  /// Localized warning text for a successful [ValidationResult].
  String? localizedValidationWarning(
    ValidationResult result,
    AppLocalizations l10n,
  ) =>
      validationWarningMessage(result, l10n);

  Future<void> restoreOrStartScanRoom(ScannerProvider provider) async {
    final resumeRoom = activeResumeRoom;
    if (resumeRoom != null) {
      provider.restoreCurrentRoom(resumeRoom);
      onScanRoomRestored(resumeRoom, const <ARPoint>[]);
      return;
    }

    final draft = await _scanDraftService.load(scanProjectUuid);
    if (!mounted) return;

    if (draft == null) {
      startScanRoom(provider);
      return;
    }

    final draftRoomWasClosed = context
        .read<FloorPlanProvider>()
        .completedRooms
        .any((room) => room.id == draft.room.id && room.isClosed);
    if (draftRoomWasClosed) {
      await _scanDraftService.clear(scanProjectUuid);
      if (!mounted) return;
      _lastDraftFingerprint = null;
      startScanRoom(provider);
      return;
    }

    final continueDraft = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final l10n = AppLocalizations.of(dialogContext)!;
        return AlertDialog(
          title: Text(l10n.unfinishedScan),
          content: Text(l10n.unfinishedScanFound),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.discardScan),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(l10n.continueScan),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (continueDraft == true) {
      activeContinuationReference = draft.continuationReference;
      activeResumeRoom = draft.resumeRoom;
      provider.restoreCurrentRoom(draft.room);
      onScanRoomRestored(draft.room, draft.basicHistory);
      return;
    }

    await _scanDraftService.clear(scanProjectUuid);
    _lastDraftFingerprint = null;
    startScanRoom(provider);
  }

  void attachScanDraftListener(ScannerProvider provider) {
    _draftProvider?.removeListener(_onScannerDraftChanged);
    _draftProvider = provider;
    provider.addListener(_onScannerDraftChanged);
    _onScannerDraftChanged();
  }

  void _onScannerDraftChanged() {
    final room = _draftProvider?.currentRoom;
    if (room == null || (room.points.isEmpty && room.features.isEmpty)) {
      return;
    }

    _draftSaveTimer?.cancel();
    _draftSaveTimer = Timer(const Duration(milliseconds: 250), () {
      final history = scanDraftHistory();
      final fingerprint = jsonEncode(<String, dynamic>{
        'room': room.toJson(),
        'history': history.map((point) => point.toJson()).toList(),
        'continuation': activeContinuationReference?.featureId,
      });
      if (fingerprint == _lastDraftFingerprint) return;

      _scanDraftService
          .save(
        projectUuid: scanProjectUuid,
        room: room,
        resumeRoom: activeResumeRoom,
        continuationReference: activeContinuationReference,
        basicHistory: history,
      )
          .then((_) {
        _lastDraftFingerprint = fingerprint;
      }).catchError((Object error) {
        _lastDraftFingerprint = null;
        debugPrint('Could not save scan draft: $error');
      });
    });
  }

  Future<void> flushScanDraft() async {
    _draftSaveTimer?.cancel();
    final room = _draftProvider?.currentRoom;
    if (room == null || (room.points.isEmpty && room.features.isEmpty)) return;

    await _scanDraftService.save(
      projectUuid: scanProjectUuid,
      room: room,
      resumeRoom: activeResumeRoom,
      continuationReference: activeContinuationReference,
      basicHistory: scanDraftHistory(),
    );
  }

  /// Guarda el borrador pendiente y deja de escuchar al proveedor.
  ///
  /// Debe llamarse desde `dispose` de la pantalla.
  void disposeScanRoomSession() {
    flushScanDraft();
    _draftSaveTimer?.cancel();
    _draftProvider?.removeListener(_onScannerDraftChanged);
  }

  String localizedScanRoomName(
    ScannerProvider provider,
    AppLocalizations l10n,
  ) {
    final room = provider.currentRoom;

    if (room == null) {
      return l10n.newRoom;
    }

    final defaultName = room.type.displayName;

    return room.name == defaultName ? room.type.localizedName(l10n) : room.name;
  }

  String scanRecommendation(int cornerCount, AppLocalizations l10n) {
    if (cornerCount == 0) return l10n.markStartRecommendation;
    if (cornerCount < 3) return l10n.addNextCornerRecommendation;
    return l10n.closeSpaceRecommendation;
  }

  Future<void> showCustomRoomNameDialog(ScannerProvider provider) async {
    final l10n = AppLocalizations.of(context)!;
    final name = await showRoomNameDialog(
      context: context,
      initialName: provider.currentRoom?.name ??
          provider.selectedType.localizedName(l10n),
    );

    if (!mounted || name == null || name.trim().isEmpty) {
      return;
    }
    provider.setCurrentRoomName(name);
  }

  /// Cierra y guarda el ambiente en curso; ignora pulsaciones repetidas.
  Future<void> closeScanRoom(ScannerProvider provider) async {
    if (_closingRoom) return;
    _closingRoom = true;
    try {
      await _closeScanRoomOnce(provider);
    } finally {
      _closingRoom = false;
    }
  }

  Future<void> _closeScanRoomOnce(ScannerProvider provider) async {
    final l10n = AppLocalizations.of(context)!;

    if (provider.currentPointsCount < 3) {
      showScanError(l10n.needThreeCornersToCloseMessage);
      return;
    }

    unawaited(HapticFeedback.mediumImpact());

    final roomName = await showRoomNameDialog(
      context: context,
      initialName: provider.currentRoom?.name ??
          provider.selectedType.localizedName(l10n),
    );
    if (!mounted || roomName == null || roomName.trim().isEmpty) {
      return;
    }
    provider.setCurrentRoomName(roomName);

    final continuation = activeContinuationReference;
    if (continuation != null) {
      final suggestion = ScanValidator.suggestOrthogonalClosurePoint(
        provider.currentRoom?.points ?? const <ARPoint>[],
      );
      if (suggestion != null) {
        final confirmed = await confirmOrthogonalContinuationClosure(context);
        if (!mounted || !confirmed) {
          return;
        }
        final addition = provider.tryAddPoint(
          suggestion.x,
          suggestion.y,
          suggestion.z,
        );
        if (!addition.isValid) {
          showScanError(localizedValidationError(addition, l10n));
          return;
        }
      }
    }

    final floorPlanProvider = context.read<FloorPlanProvider>();

    if (continuation != null) {
      final sourceFeature = floorPlanProvider.findFeature(
        roomId: continuation.sourceRoomId,
        featureId: continuation.featureId,
      );

      if (sourceFeature == null || sourceFeature.isConnected) {
        showScanError(
          sourceFeature == null
              ? l10n.referenceOpeningMissing
              : l10n.referenceOpeningConnected,
        );
        return;
      }
    }

    final room = provider.closeCurrentRoom();
    if (!mounted) return;

    if (room == null) {
      showScanError(provider.lastCloseError ?? l10n.closeRoomFailed);
      return;
    }

    final resumeRoom = activeResumeRoom;
    final resumesExistingRoom = resumeRoom != null &&
        floorPlanProvider.completedRooms.any(
          (existing) => existing.id == resumeRoom.id,
        );
    final saved = resumesExistingRoom
        ? await floorPlanProvider.replaceCompletedRoom(
            room,
            expectedOpenRoom: resumeRoom,
          )
        : continuation == null
            ? await floorPlanProvider.addCompletedRoom(
                room,
                preservePlacement: resumeRoom != null,
              )
            : await floorPlanProvider.addCompletedRoomFromContinuation(
                room: room,
                reference: continuation,
              );

    if (!saved) {
      provider.restoreCurrentRoom(room.copyWith(isClosed: false));
      if (!mounted) return;
      showScanError(l10n.saveRoomFailed);
      return;
    }

    _draftSaveTimer?.cancel();
    await _scanDraftService.clear(scanProjectUuid);
    _lastDraftFingerprint = null;

    if (!mounted) return;

    final action = await showRoomCompletionDialog(context);
    if (!mounted || action == null) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) => FloorPlanViewerScreen(
          selectContinuationOpening:
              action != RoomCompletionAction.viewFullPlan,
        ),
      ),
    );
  }

  void closeScanProject() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void openScanFloorPlan() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const FloorPlanViewerScreen()),
    );
  }
}
