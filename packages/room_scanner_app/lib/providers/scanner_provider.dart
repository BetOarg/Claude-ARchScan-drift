import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:room_scanner_core/room_scanner_core.dart';

/// Estado de la sesión de escaneo activa.
///
/// Mantiene la habitación en curso y las habitaciones cerradas durante
/// la sesión. Cada punto nuevo se valida antes de incorporarse.
class ScannerProvider extends ChangeNotifier {
  MeasurementSystem measurementSystem =
      MeasurementSystem.metric;

  final List<RoomModel> _rooms = [];

  RoomModel? _currentRoom;
  RoomType _selectedType = RoomType.living;
  bool _hasCustomRoomName = false;
  bool _isTrackingOk = false;
  final List<RoomModel> _undoHistory = [];
  final List<RoomModel> _redoHistory = [];
  final Set<String> _referenceFeatureIds = {};
  bool get canUndo => _currentRoom != null && _undoHistory.isNotEmpty;
  bool get canRedo => _currentRoom != null && _redoHistory.isNotEmpty;

  void _recordEdit() {
    if (_currentRoom == null) return;
    _undoHistory.add(_currentRoom!);
    if (_undoHistory.length > 100) _undoHistory.removeAt(0);
    _redoHistory.clear();
  }

  bool undoEdit() {
    if (!canUndo) return false;
    _redoHistory.add(_currentRoom!);
    _currentRoom = _undoHistory.removeLast().copyWith(
      name: _currentRoom!.name, type: _currentRoom!.type,
    );
    notifyListeners();
    return true;
  }

  bool redoEdit() {
    if (!canRedo) return false;
    _undoHistory.add(_currentRoom!);
    _currentRoom = _redoHistory.removeLast().copyWith(
      name: _currentRoom!.name, type: _currentRoom!.type,
    );
    notifyListeners();
    return true;
  }

  bool removeCurrentFeature(String featureId) {
    final room = _currentRoom;
    if (room == null || !room.features.any((f) => f.id == featureId)) return false;
    _recordEdit();
    _currentRoom = room.copyWith(
      features: room.features.where((f) => f.id != featureId).toList(),
    );
    notifyListeners();
    return true;
  }

  /// Último identificador generado.
  ///
  /// Permite garantizar IDs monotónicos incluso si se crean dos entidades
  /// dentro del mismo microsegundo.
  static int _lastGeneratedId = 0;

  List<RoomModel> get rooms => List.unmodifiable(_rooms);

  RoomModel? get currentRoom => _currentRoom;

  RoomType get selectedType => _selectedType;

  bool get isTrackingOk => _isTrackingOk;

  int get currentPointsCount =>
      _currentRoom?.points.length ?? 0;

  /// Genera un identificador único dentro del proceso.
  ///
  /// Se utilizan microsegundos y, si el reloj entrega el mismo valor,
  /// se incrementa manualmente.
  static String _nextUniqueId() {
    final now =
        DateTime.now().microsecondsSinceEpoch;

    if (now > _lastGeneratedId) {
      _lastGeneratedId = now;
    } else {
      _lastGeneratedId++;
    }

    return _lastGeneratedId.toString();
  }

  void updateTrackingStatus(
    bool status,
  ) {
    if (_isTrackingOk == status) {
      return;
    }

    _isTrackingOk = status;

    notifyListeners();
  }

  void setRoomType(
    RoomType type,
  ) {
    _selectedType = type;

    if (_currentRoom != null) {
      _currentRoom =
          _currentRoom!.copyWith(
        type: type,
        name: _hasCustomRoomName
            ? _currentRoom!.name
            : _getRoomTypeName(type),
      );
    }

    notifyListeners();
  }

  /// Cambia el nombre visible del ambiente sin alterar su tipo técnico.
  ///
  /// El nombre personalizado se conserva aunque después se cambie el tipo.
  void setCurrentRoomName(
    String name,
  ) {
    final normalized =
        name.trim();

    if (_currentRoom == null ||
        normalized.isEmpty ||
        _currentRoom!.name == normalized) {
      return;
    }

    _hasCustomRoomName = true;

    _currentRoom =
        _currentRoom!.copyWith(
      name: normalized,
      type: RoomType.other,
    );

    notifyListeners();
  }

  /// Inicia un ambiente nuevo con un ID resistente a colisiones.
  void startNewRoom({
    List<ARPoint> initialPoints = const <ARPoint>[],
    List<WallFeature> initialFeatures = const <WallFeature>[],
  }) {
    _hasCustomRoomName = false;

    _undoHistory.clear();
    _redoHistory.clear();

    _referenceFeatureIds
      ..clear()
      ..addAll(initialFeatures.map((feature) => feature.id));

    _currentRoom = RoomModel(
      id: _nextUniqueId(),
      name:
          _getRoomTypeName(
        _selectedType,
      ),
      type: _selectedType,
      points: List<ARPoint>.from(initialPoints),
      features: List<WallFeature>.from(initialFeatures),
    );

    notifyListeners();
  }

  /// Carga las habitaciones guardadas del proyecto.
  void loadRooms(
    List<RoomModel> rooms,
  ) {
    _rooms
      ..clear()
      ..addAll(rooms);

    _currentRoom = null;

    notifyListeners();
  }

  /// Restaura exclusivamente el ambiente temporal del proyecto activo.
  ///
  /// No agrega el borrador a la lista de ambientes terminados ni modifica
  /// el formato persistente utilizado por los proyectos históricos.
  void restoreCurrentRoom(RoomModel room) {
    _undoHistory.clear();
    _redoHistory.clear();
    _referenceFeatureIds.clear();
    _currentRoom = room.copyWith(isClosed: false);
    _selectedType = room.type;
    _hasCustomRoomName = room.name != _getRoomTypeName(room.type);
    lastCloseError = null;
    notifyListeners();
  }

  /// Intenta agregar un vértice.
  ValidationResult tryAddPoint(
    double x,
    double y,
    double z,
  ) {
    if (_currentRoom == null) {
      startNewRoom();
    }

    final candidate =
        ARPoint(
      x: x,
      y: y,
      z: z,
    );

    final result =
        ScanValidator
            .validateNewPoint(
      candidate,
      _currentRoom!.points,
    );

    if (!result.isValid) {
      return result;
    }

    final updatedPoints =
        List<ARPoint>.from(
      _currentRoom!.points,
    )..add(candidate);

    _recordEdit();

    _currentRoom =
        _currentRoom!.copyWith(
      points: updatedPoints,
      features: _featuresOnContour(_currentRoom!.features, updatedPoints),
    );

    notifyListeners();

    return result;
  }

  /// Agrega una puerta o ventana sobre la pared medida más cercana.
  ///
  /// Basic Scanner utiliza [widthMeters] y una ubicación central aproximada.
  /// ARCore/ARKit utilizan [endLocation] para medir los dos extremos mediante
  /// la cámara. Ambos caminos producen el mismo WallFeature persistente.
  ValidationResult addFeatureToCurrentRoom(
    FeatureType type,
    ARPoint location, {
    double? widthMeters,
    ARPoint? endLocation,
    int? preferredWallIndex,
    double? openingHeightMeters,
    double? sillHeightMeters,
  }) {
    final room =
        _currentRoom;

    if (room == null) {
      return ValidationResult.invalid(
        'No hay un ambiente en curso.',
        code: ValidationErrorCode.noActiveRoom,
      );
    }

    final points =
        room.points;

    if (points.length < 2) {
      return ValidationResult.invalid(
        'Medí al menos una pared antes de agregar una abertura.',
        code: ValidationErrorCode.needWallBeforeOpening,
      );
    }

    if ((openingHeightMeters != null &&
            (!openingHeightMeters.isFinite || openingHeightMeters <= 0)) ||
        (sillHeightMeters != null &&
            (!sillHeightMeters.isFinite || sillHeightMeters < 0))) {
      return ValidationResult.invalid(
        'La altura debe ser positiva y el antepecho no puede ser negativo.',
        code: ValidationErrorCode.invalidOpeningHeights,
      );
    }

    final isCameraMeasurement =
        endLocation != null;

    if (!isCameraMeasurement &&
        (widthMeters == null ||
            !widthMeters.isFinite ||
            widthMeters < 0.20)) {
      return ValidationResult.invalid(
        'Ingresá un ancho mínimo de '
        '${_formatLength(0.20)}.',
        code: ValidationErrorCode.openingTooNarrow,
        data: {'minWidth': _formatLength(0.20)},
      );
    }

    final referencePoint = isCameraMeasurement
        ? ARPoint(
            x: (location.x + endLocation.x) / 2.0,
            y: (location.y + endLocation.y) / 2.0,
            z: (location.z + endLocation.z) / 2.0,
          )
        : location;

    // Con tres o más esquinas también existe el tramo de cierre entre la
    // última esquina y la primera. Debe participar antes de cerrar el ambiente
    // para poder colocar puertas o ventanas sobre esa pared.
    final wallCount = points.length >= 3 ? points.length : points.length - 1;

    if (preferredWallIndex != null &&
        (preferredWallIndex < 0 || preferredWallIndex >= wallCount)) {
      return ValidationResult.invalid(
        'La pared seleccionada no es válida.',
        code: ValidationErrorCode.invalidWallIndex,
      );
    }

    WallSegment? wallAt(int index) =>
        WallSegment.between(points[index], points[(index + 1) % points.length]);

    final wallIndex = preferredWallIndex != null
        ? (wallAt(preferredWallIndex) == null ? -1 : preferredWallIndex)
        : WallSegment.nearestWallIndex(points, wallCount, referencePoint);

    if (wallIndex < 0) {
      return ValidationResult.invalid(
        'No se encontró una pared válida.',
        code: ValidationErrorCode.noValidWall,
      );
    }

    final wall = wallAt(wallIndex)!;

    late double startT;
    late double endT;
    late double measuredWidth;

    if (isCameraMeasurement) {
      final firstT = wall.fraction(location);
      final secondT = wall.fraction(endLocation);

      startT = math.min(firstT, secondT);
      endT = math.max(firstT, secondT);
      measuredWidth = (endT - startT) * wall.length;

      if (measuredWidth < 0.20) {
        return ValidationResult.invalid(
          'Los dos puntos de la abertura están demasiado cerca. '
          'Medida detectada: '
          '${_formatLength(measuredWidth)}.',
          code: ValidationErrorCode.endpointsTooClose,
          data: {'measuredWidth': _formatLength(measuredWidth)},
        );
      }
    } else {
      measuredWidth = widthMeters!;

      final startMeters = wall.centredOpeningStart(location, measuredWidth);
      if (startMeters == null) {
        return ValidationResult.invalid(
          'La abertura mide '
          '${_formatLength(measuredWidth)}, '
          'pero la pared mide '
          '${_formatLength(wall.length)}.',
          code: ValidationErrorCode.openingExceedsWall,
          data: {
            'openingWidth': _formatLength(measuredWidth),
            'wallLength': _formatLength(wall.length),
          },
        );
      }

      startT = startMeters / wall.length;
      endT = startT + measuredWidth / wall.length;
    }

    final featureStart = wall.pointAt(startT);
    final featureEnd = wall.pointAt(endT);

    // Impide que dos aberturas ocupen el mismo tramo de pared. La separación
    // mínima está en metros, igual que al editar la abertura en el plano.
    if (wall.overlapsOpening(
      startT * wall.length,
      endT * wall.length,
      room.features,
      separationMeters: 0.02,
    )) {
      return ValidationResult.invalid(
        'La abertura se superpone con otra puerta o ventana. '
        'Elegí otra posición sobre la pared.',
        code: ValidationErrorCode.openingOverlaps,
      );
    }

    final feature =
        WallFeature(
      id: _nextUniqueId(),
      type: type,
      start: featureStart,
      end: featureEnd,
      openingHeightMeters: openingHeightMeters,
      sillHeightMeters: sillHeightMeters,
    );

    final updatedFeatures =
        List<WallFeature>.from(
      room.features,
    )..add(feature);

    _recordEdit();

    _currentRoom =
        room.copyWith(
      features: updatedFeatures,
    );

    notifyListeners();
    return ValidationResult.warning(
      'Abertura medida: '
      '${_formatLength(measuredWidth)}.',
      data: {'measuredWidth': _formatLength(measuredWidth)},
    );
  }

  String _formatLength(
    double meters,
  ) {
    return MeasurementUnits.formatLength(
      meters,
      measurementSystem,
      metersLabel: 'm',
      feetLabel: 'ft',
      inchesLabel: 'in',
    );
  }
  void removeLastPoint() {
    if (_currentRoom == null ||
        _currentRoom!.points.isEmpty) {
      return;
    }

    final updatedPoints =
        List<ARPoint>.from(
      _currentRoom!.points,
    )..removeLast();

    _recordEdit();

    _currentRoom =
        _currentRoom!.copyWith(
      points: updatedPoints,
      features: _featuresOnContour(_currentRoom!.features, updatedPoints),
    );

    notifyListeners();
  }

  String? lastCloseError;
  ValidationErrorCode? lastCloseErrorCode;

  List<WallFeature> _featuresOnContour(List<WallFeature> features, List<ARPoint> points) {
    bool onSegment(ARPoint p, ARPoint a, ARPoint b) {
      final dx = b.x-a.x;
      final dz = b.z-a.z;
      final lengthSquared = dx*dx+dz*dz;
      if (lengthSquared < 0.00000001) return false;
      final t = ((p.x-a.x)*dx+(p.z-a.z)*dz)/lengthSquared;
      if (t < -0.0001 || t > 1.0001) return false;
      final x = p.x-a.x-t*dx;
      final z = p.z-a.z-t*dz;
      return x*x+z*z < 0.00000001;
    }
    final count = points.length >= 3 ? points.length : math.max(0, points.length-1);
    return features.where((f) {
      if (_referenceFeatureIds.contains(f.id)) return true;
      for (var i=0; i<count; i++) {
        final a=points[i], b=points[(i+1)%points.length];
        if (onSegment(f.start,a,b) && onSegment(f.end,a,b)) return true;
      }
      return false;
    }).toList();
  }

  /// Valida y cierra el ambiente actual.
  RoomModel? closeCurrentRoom() {
    lastCloseError = null;
    lastCloseErrorCode = null;

    final room =
        _currentRoom;

    if (room == null) {
      lastCloseError =
          'No hay una habitación en curso.';
      lastCloseErrorCode =
          ValidationErrorCode.noActiveRoom;

      return null;
    }

    final closure =
        ScanValidator
            .validateClosure(
      room.points,
    );

    if (!closure.isValid) {
      lastCloseError =
          closure.errorMessage;
      lastCloseErrorCode =
          closure.errorCode;

      return null;
    }

    if (ScanValidator
        .hasSelfIntersections(
      room.points,
    )) {
      lastCloseError =
          'El contorno se autointersecta. '
          'Revisa las paredes trazadas.';
      lastCloseErrorCode =
          ValidationErrorCode.closeSelfIntersection;

      return null;
    }

    final closedRoom =
        room.copyWith(
      isClosed: true,
    );

    _rooms.add(closedRoom);

    _currentRoom = null;

    notifyListeners();

    return closedRoom;
  }

  String _getRoomTypeName(
    RoomType type,
  ) {
    return type.displayName;
  }
}
