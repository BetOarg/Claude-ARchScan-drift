import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, listEquals;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:room_scanner_core/room_scanner_core.dart';

import '../l10n/generated/app_localizations.dart';
import '../providers/floor_plan_provider.dart';
import '../providers/measurement_settings_provider.dart';
import '../services/import_export_service.dart';
import '../services/ar_check_service.dart';
import '../services/room_plan_capture_coordinator.dart';
import '../services/room_plan_service.dart';
import '../services/scan_draft_service.dart';
import '../widgets/plan_wall_length_dialog.dart';
import '../widgets/opening_placement_dialog.dart'
    show showOpeningPlacementDialog;
import '../widgets/room_name_dialog.dart';

part 'floor_plan_wall_editor.dart';
part 'floor_plan_opening_dialogs.dart';
part 'floor_plan_painter.dart';
part 'floor_plan_room_dialogs.dart';

class FloorPlanViewerScreen extends StatefulWidget {
  final bool selectContinuationOpening;

  const FloorPlanViewerScreen({
    super.key,
    this.selectContinuationOpening = false,
  });

  @override
  State<FloorPlanViewerScreen> createState() => _FloorPlanViewerScreenState();
}

class _FloorPlanViewerScreenState extends State<FloorPlanViewerScreen>
    with _PlanWallEditing, _OpeningDialogs, _RoomDialogs {
  @override
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  PersistentBottomSheetController? _featureSheetController;
  double _minX = 0.0;
  double _minZ = 0.0;
  double _scale = 1.0;
  double _padding = 20.0;

  @override
  String? _selectedRoomId;
  @override
  String? _selectedFeatureId;
  @override
  bool _touchTransformMode = false;
  Offset _touchStartFocalPoint = Offset.zero;
  Offset _touchNavigationFocalPoint = Offset.zero;
  double _touchNavigationScale = 1;
  bool _touchNavigating = false;
  String? _touchTransformRoomId;
  int _touchSnapCount = 0;
  bool _roomPlanSupported = false;
  bool _roomPlanScanning = false;

  @override
  void initState() {
    super.initState();
    _loadRoomPlanSupport();
  }

  Future<void> _loadRoomPlanSupport() async {
    if (defaultTargetPlatform != TargetPlatform.iOS) return;
    final supported = await RoomPlanService.isSupported();
    if (!mounted || supported == _roomPlanSupported) return;
    setState(() => _roomPlanSupported = supported);
  }

  Future<void> _captureWithRoomPlan() async {
    if (_roomPlanScanning) return;
    final l10n = AppLocalizations.of(context)!;
    final roomName = await showRoomNameDialog(
      context: context,
      initialName: l10n.roomTypeOther,
    );
    if (!mounted || roomName == null) return;

    setState(() => _roomPlanScanning = true);
    try {
      final room = await const RoomPlanCaptureCoordinator().captureAndPersist(
        floorPlanProvider: context.read<FloorPlanProvider>(),
        roomName: roomName,
      );
      if (!mounted || room == null) return;
      _showMessage(l10n.roomPlanSpaceSaved);
    } on PlatformException catch (error) {
      if (mounted) {
        _showMessage(
          l10n.roomPlanCaptureFailed(error.message ?? error.code),
          error: true,
        );
      }
    } on FormatException catch (error) {
      if (mounted) {
        _showMessage(
          l10n.roomPlanCaptureFailed(error.message),
          error: true,
        );
      }
    } finally {
      if (mounted) setState(() => _roomPlanScanning = false);
    }
  }

  void _toggleTouchTransformMode() {
    _clearPlanSelection();
    _wallEditMode = false;
    final provider = context.read<FloorPlanProvider>();
    if (_touchTransformRoomId != null) {
      provider.cancelTouchRoomTransform();
      _touchTransformRoomId = null;
      _touchSnapCount = 0;
    }
    setState(() {
      _touchTransformMode = !_touchTransformMode;
      _selectedFeatureId = null;
    });
  }

  void _zoomPlan(double factor) {
    final current = _planViewport.value;
    final currentScale = current.getMaxScaleOnAxis();
    final targetScale = (currentScale * factor).clamp(0.2, 6.0).toDouble();
    if ((targetScale - currentScale).abs() <= 0.000001) return;
    final ratio = targetScale / currentScale;
    final viewportCenter = MediaQuery.sizeOf(context).center(Offset.zero);
    final translationX = current.storage[12];
    final translationY = current.storage[13];
    final next = Matrix4.identity()
      ..setEntry(0, 0, targetScale)
      ..setEntry(1, 1, targetScale)
      ..setEntry(2, 2, targetScale)
      ..setTranslationRaw(
        viewportCenter.dx - (viewportCenter.dx - translationX) * ratio,
        viewportCenter.dy - (viewportCenter.dy - translationY) * ratio,
        0,
      );
    _planViewport.value = next;
  }

  void _resetPlanZoom() {
    _planViewport.value = Matrix4.identity();
  }

  void _startTouchTransform(ScaleStartDetails details, List<RoomModel> rooms) {
    _touchNavigationFocalPoint = details.focalPoint;
    _touchNavigationScale = 1;
    _touchNavigating = false;
    final planePoint = _inverseTransform(details.localFocalPoint);
    final roomId = _getRoomAtPosition(planePoint, rooms) ?? _selectedRoomId;
    if (roomId == null ||
        !context.read<FloorPlanProvider>().beginTouchRoomTransform(roomId)) {
      return;
    }
    _touchStartFocalPoint = details.localFocalPoint;
    _touchTransformRoomId = roomId;
    _touchSnapCount = 0;
    setState(() {
      _selectedRoomId = roomId;
      _selectedFeatureId = null;
    });
  }

  void _updateTouchTransform(ScaleUpdateDetails details) {
    if (details.pointerCount > 1) {
      final provider = context.read<FloorPlanProvider>();
      if (!_touchNavigating) {
        provider.cancelTouchRoomTransform();
        _touchTransformRoomId = null;
        _touchSnapCount = 0;
        _touchNavigating = true;
        _touchNavigationFocalPoint = details.focalPoint;
        _touchNavigationScale = details.scale;
        return;
      }
      final delta = details.focalPoint - _touchNavigationFocalPoint;
      final next = _planViewport.value.clone();
      next.storage[12] += delta.dx;
      next.storage[13] += delta.dy;
      _planViewport.value = next;
      final scaleFactor = details.scale / _touchNavigationScale;
      if (scaleFactor.isFinite && scaleFactor > 0) {
        _zoomPlan(scaleFactor);
      }
      _touchNavigationFocalPoint = details.focalPoint;
      _touchNavigationScale = details.scale;
      return;
    }
    if (_touchNavigating) return;
    final roomId = _touchTransformRoomId;
    if (roomId == null) return;
    final delta = details.localFocalPoint - _touchStartFocalPoint;
    final provider = context.read<FloorPlanProvider>();
    final updated = provider.updateTouchRoomTransform(
      roomId: roomId,
      offsetX: delta.dx / _scale,
      offsetZ: delta.dy / _scale,
      angleDegrees: details.rotation * 180 / math.pi,
    );
    if (!updated) return;
    final snapCount = provider.touchTransformSnapCount;
    if (snapCount > _touchSnapCount) {
      HapticFeedback.selectionClick();
    }
    _touchSnapCount = snapCount;
  }

  Future<void> _endTouchTransform() async {
    if (_touchNavigating) {
      _touchNavigating = false;
      return;
    }
    final roomId = _touchTransformRoomId;
    if (roomId == null) return;
    _touchTransformRoomId = null;
    _touchSnapCount = 0;
    final accepted = await context
        .read<FloorPlanProvider>()
        .endTouchRoomTransform(roomId: roomId);
    if (!mounted) return;
    if (!accepted) {
      _showMessage(
        AppLocalizations.of(context)!.unsafeMovementRejected,
        error: true,
      );
    }
    setState(() {});
  }

  // ===========================================================================
  // TRANSFORMACIÓN PLANO ↔ PANTALLA
  // ===========================================================================

  @override
  Offset _transformPoint(ARPoint point) {
    final x = _padding + (point.x - _minX) * _scale;

    final z = _padding + (point.z - _minZ) * _scale;

    return Offset(x, z);
  }

  @override
  ARPoint _inverseTransform(Offset screenPosition) {
    final x = (screenPosition.dx - _padding) / _scale + _minX;

    final z = (screenPosition.dy - _padding) / _scale + _minZ;

    return ARPoint(x: x, y: 0.0, z: z);
  }

  void _calculateTransform(Size screenSize, List<RoomModel> rooms) {
    if (rooms.isEmpty) {
      return;
    }

    double minX = double.infinity;
    double maxX = double.negativeInfinity;

    double minZ = double.infinity;
    double maxZ = double.negativeInfinity;

    bool hasPoints = false;

    for (final room in rooms) {
      for (final point in room.points) {
        hasPoints = true;

        if (point.x < minX) {
          minX = point.x;
        }

        if (point.x > maxX) {
          maxX = point.x;
        }

        if (point.z < minZ) {
          minZ = point.z;
        }

        if (point.z > maxZ) {
          maxZ = point.z;
        }
      }
    }

    if (!hasPoints) {
      _minX = 0.0;
      _minZ = 0.0;
      _scale = 1.0;
      _padding = 20.0;
      return;
    }

    _minX = minX;
    _minZ = minZ;

    _padding = screenSize.width * 0.08;

    final contentWidth = (maxX - minX).abs();

    final contentHeight = (maxZ - minZ).abs();

    final safeWidth = contentWidth <= 0.0001 ? 1.0 : contentWidth;

    final safeHeight = contentHeight <= 0.0001 ? 1.0 : contentHeight;

    final availableWidth = screenSize.width - (_padding * 2);

    final availableHeight = screenSize.height - (_padding * 2);

    final widthScale = availableWidth / safeWidth;

    final heightScale = availableHeight / safeHeight;

    _scale = widthScale < heightScale ? widthScale : heightScale;

    if (!_scale.isFinite || _scale <= 0) {
      _scale = 1.0;
    }
  }

  String? _getRoomAtPosition(ARPoint point, List<RoomModel> rooms) {
    for (final room in rooms.reversed) {
      if (GeometryService.isPointInPolygon(point, room.points)) {
        return room.id;
      }
    }

    return null;
  }

  _FeatureSelection? _getFeatureAtPosition(
    Offset screenPosition,
    List<RoomModel> rooms,
  ) {
    const touchTolerance = 18.0;

    _FeatureSelection? nearest;
    double nearestDistance = double.infinity;

    for (final room in rooms.reversed) {
      for (final feature in room.features) {
        final distance = _distanceToSegment(
          screenPosition,
          _transformPoint(feature.start),
          _transformPoint(feature.end),
        );

        if (distance <= touchTolerance && distance < nearestDistance) {
          nearestDistance = distance;
          nearest = _FeatureSelection(roomId: room.id, feature: feature);
        }
      }
    }

    return nearest;
  }

  double _distanceToSegment(Offset point, Offset start, Offset end) {
    final segment = end - start;
    final lengthSquared = segment.dx * segment.dx + segment.dy * segment.dy;

    if (lengthSquared <= 0.000001) {
      return (point - start).distance;
    }

    final fromStart = point - start;
    final rawT =
        (fromStart.dx * segment.dx + fromStart.dy * segment.dy) / lengthSquared;
    final t = rawT.clamp(0.0, 1.0).toDouble();
    final projection = Offset(
      start.dx + segment.dx * t,
      start.dy + segment.dy * t,
    );

    return (point - projection).distance;
  }

  @override
  String _directionLabel(Offset direction, AppLocalizations localizations) {
    if (direction.dx.abs() >= direction.dy.abs()) {
      return direction.dx >= 0
          ? localizations.directionRight
          : localizations.directionLeft;
    }

    return direction.dy >= 0
        ? localizations.directionDown
        : localizations.directionUp;
  }

  @override
  IconData _directionIcon(Offset direction) {
    if (direction.dx.abs() >= direction.dy.abs()) {
      return direction.dx >= 0 ? Icons.arrow_forward : Icons.arrow_back;
    }

    return direction.dy >= 0 ? Icons.arrow_downward : Icons.arrow_upward;
  }

  @override
  double _featureWidth(WallFeature feature) {
    return GeometryService.calculateDistance(feature.start, feature.end);
  }

  @override
  String _formatLength(double meters, MeasurementSystem measurementSystem) {
    if (measurementSystem == MeasurementSystem.metric) {
      return '${_formatDecimal(meters)} m';
    }

    final imperial = MeasurementUnits.metersToFeetAndInches(meters);

    return '${imperial.feet}′ '
        '${_formatDecimal(imperial.inches)}″';
  }

  String _formatOpeningPlanDimensions(
    WallFeature feature,
    MeasurementSystem measurementSystem,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final width = _formatLength(_featureWidth(feature), measurementSystem);
    final height = _formatLength(
      feature.openingHeightMeters,
      measurementSystem,
    );

    if (feature.type == FeatureType.door) {
      return localizations.doorPlanDimensions(width, height);
    }

    final sill = _formatLength(feature.sillHeightMeters, measurementSystem);
    final orientation = _featureWidth(feature) >= feature.openingHeightMeters
        ? localizations.horizontalOrientation
        : localizations.verticalOrientation;
    return localizations.windowPlanDimensions(width, height, sill, orientation);
  }

  @override
  String _formatArea(double squareMeters, MeasurementSystem measurementSystem) {
    final localizations = AppLocalizations.of(context)!;

    if (measurementSystem == MeasurementSystem.metric) {
      return '${_formatDecimal(squareMeters)} '
          '${localizations.squareMeters}';
    }

    final squareFeet = MeasurementUnits.squareMetersToSquareFeet(squareMeters);

    return '${_formatDecimal(squareFeet)} '
        '${localizations.squareFeet}';
  }

  @override
  String _formatDecimal(double value) {
    var formatted = value.toStringAsFixed(2);

    if (Localizations.localeOf(context).languageCode == 'es') {
      formatted = formatted.replaceAll('.', ',');
    }

    return formatted;
  }

  // ===========================================================================  // EDITOR DE MEDIDAS
  // ===========================================================================

  @override
  Future<void> _openMeasurementEditor({String? roomId}) async {
    if (!mounted) {
      return;
    }

    setState(() {
      _clearPlanSelection();
      _touchTransformMode = false;
      _wallEditMode = true;
      _selectedRoomId = roomId;
    });
  }

  // ===========================================================================
  // ORGANIZACIÓN AUTOMÁTICA
  // ===========================================================================
  @override
  Future<void> _organizeRooms() async {
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<FloorPlanProvider>();

    if (provider.completedRooms.length <= 1) {
      _showMessage(localizations.notEnoughRoomsToOrganize);
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.grid_view_rounded),
              const SizedBox(width: 10),
              Expanded(child: Text(localizations.organizeRooms)),
            ],
          ),
          content: Text(localizations.organizeRoomsExplanation),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(localizations.cancel),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              icon: const Icon(Icons.auto_awesome),
              label: Text(localizations.organizeRooms),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final changed = await provider.autoArrangeRooms();

    if (!mounted) {
      return;
    }
    _showMessage(
      changed
          ? localizations.roomsOrganizedSuccessfully
          : localizations.roomsArrangementUnchanged,
    );
  }
  // ===========================================================================
  // BUILD
  // ===========================================================================

  Future<void> _showAreaSummary() async {
    final provider = context.read<FloorPlanProvider>();
    final measurementSystem = context
        .read<MeasurementSettingsProvider>()
        .system;
    final localizations = AppLocalizations.of(context)!;
    final rooms = provider.completedRooms;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(localizations.areaSummaryTitle),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final room in rooms)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(room.name),
                    trailing: Text(
                      room.isClosed
                          ? _formatArea(
                              GeometryService.calculateArea(room.points),
                              measurementSystem,
                            )
                          : localizations.planOpenContour,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    localizations.totalAreaLabel,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    _formatArea(provider.totalProjectArea, measurementSystem),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(localizations.close),
          ),
        ],
      ),
    );
  }

  void _closeProject() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final measurementSystem = context
        .watch<MeasurementSettingsProvider>()
        .system;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.selectContinuationOpening
              ? localizations.chooseOpeningToContinue
              : localizations.floorPlan2D,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: localizations.closeProject,
            icon: const Icon(Icons.close),
            onPressed: _closeProject,
          ),
          if (!widget.selectContinuationOpening) ...[
                if (_roomPlanSupported)
                  IconButton(
                    icon: _roomPlanScanning
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.view_in_ar_outlined),
                    tooltip: localizations.scanWithRoomPlan,
                    onPressed: _roomPlanScanning ? null : _captureWithRoomPlan,
                  ),
                PopupMenuButton<_FloorPlanAction>(
                  tooltip: localizations.moreOptions,
                  onSelected: (action) {
                    switch (action) {
                      case _FloorPlanAction.transformRooms:
                        _toggleTouchTransformMode();
                        break;
                      case _FloorPlanAction.organizeRooms:
                        _organizeRooms();
                        break;
                      case _FloorPlanAction.areaSummary:
                        _showAreaSummary();
                        break;
                      case _FloorPlanAction.importProject:
                        _importProject();
                        break;
                      case _FloorPlanAction.exportProject:
                        _showExportFlow();
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: _FloorPlanAction.transformRooms,
                        child: ListTile(
                          dense: true,
                          leading: Icon(
                            _touchTransformMode
                                ? Icons.check
                                : Icons.open_with_rounded,
                          ),
                          title: Text(
                            _touchTransformMode
                                ? localizations.finishEditing
                                : localizations.touchTransformRooms,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: _FloorPlanAction.organizeRooms,
                        child: ListTile(
                          dense: true,
                          leading: const Icon(Icons.grid_view_rounded),
                          title: Text(localizations.organizeRooms),
                        ),
                      ),
                      PopupMenuItem(
                        value: _FloorPlanAction.areaSummary,
                        child: ListTile(
                          dense: true,
                          leading: const Icon(Icons.straighten_outlined),
                          title: Text(localizations.areaSummaryTitle),
                        ),
                      ),
                      PopupMenuItem(
                        value: _FloorPlanAction.exportProject,
                        enabled: context
                            .read<FloorPlanProvider>()
                            .completedRooms
                            .any((room) => room.points.length >= 2),
                        child: ListTile(
                          dense: true,
                          leading: const Icon(Icons.file_download_outlined),
                          title: Text(localizations.exportProject),
                        ),
                      ),
                      PopupMenuItem(
                        value: _FloorPlanAction.importProject,
                        child: ListTile(
                          dense: true,
                          leading: const Icon(Icons.file_upload),
                          title: Text(localizations.importProject),
                        ),
                      ),
                    ];
                  },
                ),
          ],
        ],
      ),
      bottomNavigationBar: widget.selectContinuationOpening
          ? null
          : _buildPlanToolbar(),
      body: Consumer<FloorPlanProvider>(
        builder: (context, provider, child) {
          final rooms = _roomsForDisplay(provider.completedRooms);
          final hasAvailableOpenings = rooms.any(
            (room) => room.features.any((feature) => !feature.isConnected),
          );

          if (rooms.isEmpty) {
            return const _EmptyPlanView();
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;

              if (!_touchTransformMode && !_freezePlanTransform) {
                _calculateTransform(size, rooms);
              }

              return Stack(
                children: [
                  InteractiveViewer(
                    transformationController: _planViewport,
                    panEnabled: !_touchTransformMode && !_wallGestureActive,
                    scaleEnabled: !_touchTransformMode && !_wallGestureActive,
                    constrained: true,
                    boundaryMargin: const EdgeInsets.all(200),
                    minScale: 0.2,
                    maxScale: 6.0,
                    child: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      behavior: HitTestBehavior.opaque,
                      onTapUp: (details) async {
                        if (_choosingContinuationClosing ||
                            _addOpeningType != null ||
                            _wallEditMode ||
                            _pendingPlanEdit != null) {
                          await _selectPlanElement(
                            details.localPosition,
                            provider.completedRooms,
                          );
                          return;
                        }
                        if (_touchTransformMode) {
                          final roomId = _getRoomAtPosition(
                            _inverseTransform(details.localPosition),
                            rooms,
                          );
                          if (roomId != null) {
                            setState(() {
                              _selectedRoomId = roomId;
                              _selectedFeatureId = null;
                            });
                          }
                          return;
                        }
                        final featureSelection = _getFeatureAtPosition(
                          details.localPosition,
                          rooms,
                        );

                        if (featureSelection != null) {
                          if (widget.selectContinuationOpening &&
                              featureSelection.feature.isConnected) {
                            return;
                          }
                          await _showFeatureMenu(featureSelection);
                          return;
                        }

                        if (widget.selectContinuationOpening) {
                          return;
                        }

                        if (await _selectPlanElement(
                          details.localPosition,
                          provider.completedRooms,
                        )) {
                          return;
                        }
                        if (!mounted) return;

                        final planePoint = _inverseTransform(
                          details.localPosition,
                        );
                        final roomId = _getRoomAtPosition(planePoint, rooms);

                        if (roomId == null) {
                          _showMessage(localizations.tapRoomToAddOpening);
                          return;
                        }

                        await _showAddFeatureMenu(
                          roomId: roomId,
                          location: planePoint,
                        );
                      },
                      onScaleStart: _wallGestureActive
                          ? (details) =>
                                _startWallDrag(details, provider.completedRooms)
                          : _touchTransformMode
                          ? (details) => _startTouchTransform(details, rooms)
                          : null,
                      onScaleUpdate: _wallGestureActive
                          ? _updateWallDrag
                          : _touchTransformMode
                          ? _updateTouchTransform
                          : null,
                      onScaleEnd: _wallGestureActive
                          ? (_) => _endWallDrag()
                          : _touchTransformMode
                          ? (_) => _endTouchTransform()
                          : null,
                      child: _trackPlanPointer(
                        SizedBox.expand(
                          child: CustomPaint(
                            foregroundPainter: _planSelectionPainter(rooms),
                            painter: FloorPlanPainter(
                              rooms: rooms,
                              transform: _transformPoint,
                              selectedRoomId: _selectedRoomId,
                              selectedFeatureId: _selectedFeatureId,
                              formatLength: (length) =>
                                  _formatLength(length, measurementSystem),
                              formatOpeningDimensions: (feature) =>
                                  _formatOpeningPlanDimensions(
                                    feature,
                                    measurementSystem,
                                  ),
                              sharedWallLabel: localizations.sharedWall,
                              partialSharedWallLabel:
                                  localizations.partialSharedWall,
                              openRoomLabel: localizations.planOpenContour,
                              continuationSelectionMode:
                                  widget.selectContinuationOpening,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_touchTransformMode)
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 18,
                      child: SafeArea(
                        child: Material(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHigh,
                          elevation: 6,
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.touch_app_rounded),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        localizations.touchTransformExplanation,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      tooltip: localizations.zoomOut,
                                      onPressed: () => _zoomPlan(0.8),
                                      icon: const Icon(Icons.zoom_out),
                                    ),
                                    IconButton(
                                      tooltip: localizations.resetView,
                                      onPressed: _resetPlanZoom,
                                      icon: const Icon(
                                        Icons.center_focus_strong,
                                      ),
                                    ),
                                    IconButton(
                                      tooltip: localizations.zoomIn,
                                      onPressed: () => _zoomPlan(1.25),
                                      icon: const Icon(Icons.zoom_in),
                                    ),
                                    IconButton(
                                      tooltip:
                                          localizations.transformRoomsTitle,
                                      onPressed: _showRoomTransformEditor,
                                      icon: const Icon(Icons.tune_rounded),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: IgnorePointer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${localizations.roomCount(rooms.length)} · '
                          '${_formatArea(provider.totalProjectArea, measurementSystem)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.selectContinuationOpening)
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      child: SafeArea(
                        child: Card(
                          color: hasAvailableOpenings
                              ? const Color(0xFF0D5C3D)
                              : Theme.of(context).colorScheme.errorContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              hasAvailableOpenings
                                  ? localizations.chooseOpeningToContinue
                                  : localizations.noAvailableOpenings,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: hasAvailableOpenings
                                    ? Colors.white
                                    : Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // ===========================================================================
  // IMPORTAR / EXPORTAR
  // ===========================================================================

  Future<void> _importProject() async {
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<FloorPlanProvider>();
    final result = await ImportExportService.importProject(
      provider,
      confirmReplacement: () async {
        if (provider.completedRooms.isEmpty) return true;
        return await showDialog<bool>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: Text(localizations.replaceProjectTitle),
                content: Text(localizations.replaceProjectMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: Text(localizations.cancel),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: Text(localizations.importProject),
                  ),
                ],
              ),
            ) ??
            false;
      },
    );
    if (!mounted) {
      return;
    }

    switch (result) {
      case JsonImportResult.imported:
        _showMessage(localizations.planImportedSuccessfully);
        break;
      case JsonImportResult.cancelled:
        return;
      case JsonImportResult.invalid:
        _showMessage(localizations.planImportInvalid, error: true);
        break;
    }
  }

  Future<void> _showExportFlow() async {
    final localizations = AppLocalizations.of(context)!;
    final format = await showDialog<_ExportFormat>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(localizations.exportProject),
        children: [
          for (final format in _ExportFormat.values)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(dialogContext, format),
              child: Text(format.label(localizations)),
            ),
        ],
      ),
    );
    if (format == null || !mounted) return;
    final destination = await showDialog<ExportDestination>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(localizations.exportDestination),
        children: [
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(dialogContext, ExportDestination.saveToFiles),
            child: Text(localizations.saveToFiles),
          ),
          SimpleDialogOption(
            onPressed: () =>
                Navigator.pop(dialogContext, ExportDestination.share),
            child: Text(localizations.shareFile),
          ),
        ],
      ),
    );
    if (destination == null || !mounted) return;
    switch (format) {
      case _ExportFormat.json:
        await _saveJson(destination);
        break;
      case _ExportFormat.svg:
        await _exportSvg(destination);
        break;
      case _ExportFormat.png:
        await _exportRaster(destination, jpeg: false);
        break;
      case _ExportFormat.jpg:
        await _exportRaster(destination, jpeg: true);
        break;
      case _ExportFormat.pdf:
        await _exportPdf(destination);
        break;
      case _ExportFormat.dxf:
        await _exportDxf(destination);
        break;
    }
  }

  Rect _shareOrigin() {
    final box = context.findRenderObject();
    if (box is RenderBox && box.hasSize) {
      return box.localToGlobal(Offset.zero) & box.size;
    }
    final size = MediaQuery.sizeOf(context);
    return Rect.fromLTWH(size.width / 2, size.height / 2, 1, 1);
  }

  Future<void> _saveJson(ExportDestination destination) async {
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<FloorPlanProvider>();

    try {
      await ImportExportService.exportToJson(
        provider.completedRooms,
        provider.projectName,
        destination: destination,
        sharePositionOrigin: _shareOrigin(),
      );
    } catch (_) {
      if (mounted) {
        _showMessage(localizations.fileSaveFailed, error: true);
      }
    }
  }

  bool _exportingDxf = false;

  Future<void> _exportDxf(ExportDestination destination) async {
    if (_exportingDxf) return;
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<FloorPlanProvider>();
    _exportingDxf = true;
    try {
      await ImportExportService.exportToDxf(
        provider.completedRooms,
        provider.projectName,
        languageCode: Localizations.localeOf(context).languageCode,
        destination: destination,
        sharePositionOrigin: _shareOrigin(),
      );
    } catch (_) {
      if (mounted) _showMessage(localizations.fileSaveFailed, error: true);
    } finally {
      _exportingDxf = false;
    }
  }

  Future<void> _exportPdf(ExportDestination destination) async {
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<FloorPlanProvider>();

    try {
      await ImportExportService.exportToPdf(
        provider.completedRooms,
        provider.projectName,
        context.read<MeasurementSettingsProvider>().system,
        languageCode: Localizations.localeOf(context).languageCode,
        destination: destination,
        sharePositionOrigin: _shareOrigin(),
      );
    } catch (_) {
      if (mounted) {
        _showMessage(localizations.fileSaveFailed, error: true);
      }
    }
  }

  Future<void> _exportSvg(ExportDestination destination) async {
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<FloorPlanProvider>();
    try {
      await ImportExportService.exportToSvg(
        provider.completedRooms,
        provider.projectName,
        context.read<MeasurementSettingsProvider>().system,
        languageCode: Localizations.localeOf(context).languageCode,
        destination: destination,
        sharePositionOrigin: _shareOrigin(),
      );
    } catch (_) {
      if (mounted) _showMessage(localizations.fileSaveFailed, error: true);
    }
  }

  Future<void> _exportRaster(
    ExportDestination destination, {
    required bool jpeg,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<FloorPlanProvider>();
    try {
      await ImportExportService.exportToRasterImage(
        provider.completedRooms,
        provider.projectName,
        context.read<MeasurementSettingsProvider>().system,
        languageCode: Localizations.localeOf(context).languageCode,
        jpeg: jpeg,
        destination: destination,
        sharePositionOrigin: _shareOrigin(),
      );
    } catch (_) {
      if (mounted) _showMessage(localizations.fileSaveFailed, error: true);
    }
  }

  // ===========================================================================
  // PUERTAS / VENTANAS
  // ===========================================================================  Future<void>
  @override
  RoomModel? _findRoom(String? roomId) {
    if (roomId == null) {
      return null;
    }

    final rooms = context.read<FloorPlanProvider>().completedRooms;

    for (final room in rooms) {
      if (room.id == roomId) {
        return room;
      }
    }
    return null;
  }

  // ===========================================================================
  // RENOMBRAR AMBIENTE
  // ===========================================================================

  // ===========================================================================
  // MENSAJES
  // ===========================================================================

  @override
  void _showMessage(String message, {bool error = false}) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: error ? Colors.red.shade700 : null,
          content: Text(message),
        ),
      );
  }
}

// =============================================================================
// ACCIONES
// =============================================================================
enum _FloorPlanAction {
  transformRooms,
  organizeRooms,
  areaSummary,
  importProject,
  exportProject,
}

enum _ExportFormat { json, svg, png, jpg, pdf, dxf }

extension on _ExportFormat {
  String label(AppLocalizations localizations) => switch (this) {
    _ExportFormat.json => localizations.exportJson,
    _ExportFormat.svg => localizations.exportSvg,
    _ExportFormat.png => localizations.exportPng,
    _ExportFormat.jpg => localizations.exportJpg,
    _ExportFormat.pdf => localizations.exportPdf,
    _ExportFormat.dxf => localizations.exportDxf,
  };
}

class _FeatureSelection {
  final String roomId;
  final WallFeature feature;

  const _FeatureSelection({required this.roomId, required this.feature});
}

class _EmptyPlanView extends StatelessWidget {
  const _EmptyPlanView();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.architecture_outlined,
              size: 72,
              color: Colors.black38,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.noScannedRooms,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              localizations.completeScanToViewPlan,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// PAINTER// =============================================================================
