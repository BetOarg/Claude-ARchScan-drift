part of 'floor_plan_viewer_screen.dart';

// Dialogs to inspect, edit, add and place doors and windows, and to
// continue scanning from an opening.
mixin _OpeningDialogs on State<FloorPlanViewerScreen>, _PlanWallEditing {
  GlobalKey<ScaffoldState> get _scaffoldKey;
  PersistentBottomSheetController? get _featureSheetController;
  set _featureSheetController(PersistentBottomSheetController? value);
  set _selectedFeatureId(String? value);
  String _formatLength(double meters, MeasurementSystem measurementSystem);
  String _directionLabel(Offset direction, AppLocalizations localizations);
  IconData _directionIcon(Offset direction);
  double _featureWidth(WallFeature feature);
  String _formatDecimal(double value);

  Future<void> _showFeatureMenu(_FeatureSelection selection) async {
    if (widget.selectContinuationOpening) {
      await _continueFromOpening(selection, chooseSide: false);
      return;
    }

    setState(() {
      _selectedRoomId = selection.roomId;
      _selectedFeatureId = selection.feature.id;
    });

    final feature = selection.feature;
    final measurementSystem = context
        .read<MeasurementSettingsProvider>()
        .system;
    final localizations = AppLocalizations.of(context)!;
    final label = feature.type == FeatureType.door
        ? localizations.selectedDoor
        : localizations.selectedWindow;

    final previousController = _featureSheetController;
    if (previousController != null) {
      previousController.close();
      await previousController.closed;
      if (!mounted) return;
    }
    _FeatureMenuAction? action;
    late PersistentBottomSheetController controller;
    void selectAction(_FeatureMenuAction selected) {
      action = selected;
      controller.close();
    }

    controller = _scaffoldKey.currentState!.showBottomSheet(
      (bottomSheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      feature.type == FeatureType.door
                          ? Icons.door_front_door
                          : Icons.window,
                      color: feature.type == FeatureType.door
                          ? const Color(0xFFFF8A00)
                          : const Color(0xFFD500F9),
                    ),
                    title: Text(label),
                    subtitle: Text(
                      '${feature.isConnected ? localizations.openingConnectedStatus : localizations.openingAvailableStatus} · '
                      '${_formatLength(_featureWidth(feature), measurementSystem)}'
                      '${feature.isConnected ? '' : ' · ${localizations.openingStartAtMarkedPoint}'}',
                    ),
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 52,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () =>
                            selectAction(_FeatureMenuAction.editGeometry),
                        icon: const Icon(Icons.straighten),
                        label: Text(
                          localizations.editOpeningDimensions,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.touch_app),
                        label: Text(
                          localizations.moveOpeningOnWall,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => selectAction(_FeatureMenuAction.move),
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.delete_outline),
                        label: Text(
                          localizations.deleteOpening,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () =>
                            selectAction(_FeatureMenuAction.delete),
                      ),
                      if (feature.type == FeatureType.door)
                        OutlinedButton.icon(
                          onPressed: () =>
                              selectAction(_FeatureMenuAction.toggleHinge),
                          icon: const Icon(Icons.flip),
                          label: Text(
                            localizations.changeDoorHingeSide,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (feature.type == FeatureType.door) ...[
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => selectAction(
                          _FeatureMenuAction.chooseOpeningDirection,
                        ),
                        icon: const Icon(Icons.rotate_left),
                        label: Text(
                          feature.doorOpeningDirection ==
                                  DoorOpeningDirection.interior
                              ? localizations.doorOpensInterior
                              : localizations.doorOpensExterior,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: feature.isConnected
                          ? null
                          : () => selectAction(
                              _FeatureMenuAction.continueScanning,
                            ),
                      icon: const Icon(Icons.add_road_rounded),
                      label: Text(
                        feature.isConnected
                            ? localizations.openingAlreadyConnected
                            : localizations.continueScanFromHere,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      enableDrag: true,
      showDragHandle: true,
    );
    _featureSheetController = controller;
    await controller.closed;
    if (identical(_featureSheetController, controller)) {
      _featureSheetController = null;
    }

    if (!mounted) return;

    if (action == _FeatureMenuAction.move) {
      await _placeOpeningOnWall(
        selection.roomId,
        feature.type,
        feature: feature,
      );
      return;
    }

    if (action == _FeatureMenuAction.editGeometry) {
      await _showOpeningGeometryEditor(selection);
      return;
    }

    if (action == _FeatureMenuAction.delete) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(localizations.deleteOpening),
          content: Text(localizations.deleteOpeningConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(localizations.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(localizations.deleteOpening),
            ),
          ],
        ),
      );
      if (!mounted || confirmed != true) return;
      if (!await context.read<FloorPlanProvider>().removeOpening(
        selection.roomId,
        feature.id,
      )) {
        if (mounted) _planError(PlanEditError.invalid);
        return;
      }
      if (mounted) {
        setState(() {
          _selectedFeatureId = null;
        });
      }
      return;
    }

    if (action == _FeatureMenuAction.toggleHinge) {
      final updated = await context
          .read<FloorPlanProvider>()
          .updateDoorOrientation(
            featureId: feature.id,
            hingeSide: feature.doorHingeSide == DoorHingeSide.start
                ? DoorHingeSide.end
                : DoorHingeSide.start,
          );

      if (mounted && !updated) {
        _showMessage(
          AppLocalizations.of(context)!.selectedDoorUnavailable,
          error: true,
        );
      }
      return;
    }

    if (action == _FeatureMenuAction.chooseOpeningDirection) {
      final direction = await _chooseDoorOpeningDirection(feature);

      if (!mounted || direction == null) {
        return;
      }

      final updated = await context
          .read<FloorPlanProvider>()
          .updateDoorOrientation(
            featureId: feature.id,
            openingDirection: direction,
          );

      if (mounted && !updated) {
        _showMessage(
          AppLocalizations.of(context)!.selectedDoorUnavailable,
          error: true,
        );
      }
      return;
    }

    if (action != _FeatureMenuAction.continueScanning) {
      return;
    }

    await _continueFromOpening(selection, chooseSide: true);
  }

  Future<void> _continueFromOpening(
    _FeatureSelection selection, {
    required bool chooseSide,
  }) async {
    final feature = selection.feature;
    if (feature.isConnected) {
      if (widget.selectContinuationOpening) {
        _showMessage(
          AppLocalizations.of(context)!.openingAlreadyConnected,
          error: true,
        );
      }
      return;
    }

    final side = chooseSide
        ? await _chooseConnectionSide(feature)
        : _availableSideFor(selection);

    if (!mounted || side == null) return;

    final provider = context.read<FloorPlanProvider>();
    final reference = provider.createContinuationReference(
      roomId: selection.roomId,
      featureId: feature.id,
      side: side,
      startEndpoint: ContinuationStartEndpoint.start,
    );

    final projectUuid = provider.projectUuid;

    if (reference == null || projectUuid == null) {
      _showMessage(
        AppLocalizations.of(context)!.selectedOpeningUnavailable,
        error: true,
      );
      return;
    }

    await ArCheckService.abrirEscanerConValidacion(
      context,
      projectUuid: projectUuid,
      projectName: provider.projectName,
      continuationReference: reference,
    );
  }

  OpeningConnectionSide _availableSideFor(_FeatureSelection selection) {
    final provider = context.read<FloorPlanProvider>();
    final room = provider.completedRooms.firstWhere(
      (candidate) => candidate.id == selection.roomId,
    );
    final feature = selection.feature;
    final dx = feature.end.x - feature.start.x;
    final dz = feature.end.z - feature.start.z;
    final length = math.sqrt(dx * dx + dz * dz);

    if (length <= 0.000001) {
      return OpeningConnectionSide.left;
    }

    final midpoint = ARPoint(
      x: (feature.start.x + feature.end.x) / 2,
      y: (feature.start.y + feature.end.y) / 2,
      z: (feature.start.z + feature.end.z) / 2,
    );
    final leftProbe = ARPoint(
      x: midpoint.x - dz / length * 0.10,
      y: midpoint.y,
      z: midpoint.z + dx / length * 0.10,
    );

    return GeometryService.isPointInPolygon(leftProbe, room.points)
        ? OpeningConnectionSide.right
        : OpeningConnectionSide.left;
  }

  Future<void> _showOpeningGeometryEditor(_FeatureSelection selection) async {
    final provider = context.read<FloorPlanProvider>();
    final placement = provider.getOpeningPlacement(
      roomId: selection.roomId,
      featureId: selection.feature.id,
    );
    final localizations = AppLocalizations.of(context)!;
    final measurementSystem = context
        .read<MeasurementSettingsProvider>()
        .system;

    if (placement == null) {
      _showMessage(
        AppLocalizations.of(context)!.openingWallNotFound,
        error: true,
      );
      return;
    }

    final widthMetricController = TextEditingController(
      text: _formatDecimal(placement.widthMeters),
    );
    final positionMetricController = TextEditingController(
      text: _formatDecimal(placement.distanceFromWallStartMeters),
    );
    final heightMetricController = TextEditingController(
      text: _formatDecimal(placement.openingHeightMeters),
    );
    final sillMetricController = TextEditingController(
      text: _formatDecimal(placement.sillHeightMeters),
    );
    final widthImperial = MeasurementUnits.metersToFeetAndInches(
      placement.widthMeters,
    );
    final positionImperial = MeasurementUnits.metersToFeetAndInches(
      placement.distanceFromWallStartMeters,
    );
    final heightImperial = MeasurementUnits.metersToFeetAndInches(
      placement.openingHeightMeters,
    );
    final sillImperial = MeasurementUnits.metersToFeetAndInches(
      placement.sillHeightMeters,
    );
    final widthFeetController = TextEditingController(
      text: widthImperial.feet.toString(),
    );
    final widthInchesController = TextEditingController(
      text: _formatDecimal(widthImperial.inches),
    );
    final positionFeetController = TextEditingController(
      text: positionImperial.feet.toString(),
    );
    final positionInchesController = TextEditingController(
      text: _formatDecimal(positionImperial.inches),
    );
    final heightFeetController = TextEditingController(
      text: heightImperial.feet.toString(),
    );
    final heightInchesController = TextEditingController(
      text: _formatDecimal(heightImperial.inches),
    );
    final sillFeetController = TextEditingController(
      text: sillImperial.feet.toString(),
    );
    final sillInchesController = TextEditingController(
      text: _formatDecimal(sillImperial.inches),
    );

    double? readLength({
      required TextEditingController metric,
      required TextEditingController feet,
      required TextEditingController inches,
    }) {
      if (measurementSystem == MeasurementSystem.metric) {
        return MeasurementUnits.metricInputToMeters(metric.text);
      }
      return MeasurementUnits.imperialInputToMeters(
        feetInput: feet.text,
        inchesInput: inches.text,
      );
    }

    final route = DialogRoute<_OpeningGeometryInput>(
      context: context,
      builder: (dialogContext) {
        String? validationMessage;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            Widget lengthFields({
              required String label,
              required TextEditingController metric,
              required TextEditingController feet,
              required TextEditingController inches,
            }) {
              if (measurementSystem == MeasurementSystem.metric) {
                return TextField(
                  controller: metric,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: label,
                    suffixText: localizations.meters,
                    border: const OutlineInputBorder(),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: feet,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: localizations.feet,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: inches,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: localizations.inches,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            return AlertDialog(
              title: Text(localizations.editOpeningDimensions),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${localizations.wallLength}: '
                      '${_formatLength(placement.wallLengthMeters, measurementSystem)}',
                    ),
                    const SizedBox(height: 16),
                    lengthFields(
                      label: localizations.openingWidth,
                      metric: widthMetricController,
                      feet: widthFeetController,
                      inches: widthInchesController,
                    ),
                    const SizedBox(height: 16),
                    lengthFields(
                      label: localizations.distanceFromWallStart,
                      metric: positionMetricController,
                      feet: positionFeetController,
                      inches: positionInchesController,
                    ),
                    const SizedBox(height: 16),
                    lengthFields(
                      label: localizations.openingHeight,
                      metric: heightMetricController,
                      feet: heightFeetController,
                      inches: heightInchesController,
                    ),
                    if (selection.feature.type == FeatureType.window) ...[
                      const SizedBox(height: 16),
                      lengthFields(
                        label: localizations.sillHeight,
                        metric: sillMetricController,
                        feet: sillFeetController,
                        inches: sillInchesController,
                      ),
                    ],
                    if (validationMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        validationMessage!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(localizations.cancel),
                ),
                FilledButton(
                  onPressed: () {
                    final width = readLength(
                      metric: widthMetricController,
                      feet: widthFeetController,
                      inches: widthInchesController,
                    );
                    final position = readLength(
                      metric: positionMetricController,
                      feet: positionFeetController,
                      inches: positionInchesController,
                    );
                    final height = readLength(
                      metric: heightMetricController,
                      feet: heightFeetController,
                      inches: heightInchesController,
                    );
                    final sill = selection.feature.type == FeatureType.window
                        ? readLength(
                            metric: sillMetricController,
                            feet: sillFeetController,
                            inches: sillInchesController,
                          )
                        : 0.0;

                    if (width == null ||
                        position == null ||
                        height == null ||
                        sill == null ||
                        !width.isFinite ||
                        width < 0.20 ||
                        !position.isFinite ||
                        position < 0 ||
                        width + position >
                            placement.wallLengthMeters + 0.000001 ||
                        !height.isFinite ||
                        height < 0.20 ||
                        !sill.isFinite ||
                        sill < 0) {
                      setDialogState(() {
                        validationMessage =
                            localizations.invalidOpeningMeasurement;
                      });
                      return;
                    }

                    Navigator.pop(
                      dialogContext,
                      _OpeningGeometryInput(
                        widthMeters: width,
                        distanceFromWallStartMeters: position,
                        openingHeightMeters: height,
                        sillHeightMeters: sill,
                      ),
                    );
                  },
                  child: Text(localizations.save),
                ),
              ],
            );
          },
        );
      },
    );
    final input = await Navigator.of(context, rootNavigator: true).push(route);
    await route.completed;

    widthMetricController.dispose();
    positionMetricController.dispose();
    widthFeetController.dispose();
    widthInchesController.dispose();
    positionFeetController.dispose();
    positionInchesController.dispose();
    heightMetricController.dispose();
    sillMetricController.dispose();
    heightFeetController.dispose();
    heightInchesController.dispose();
    sillFeetController.dispose();
    sillInchesController.dispose();

    if (!mounted || input == null) return;

    final result = await provider.updateOpeningGeometry(
      roomId: selection.roomId,
      featureId: selection.feature.id,
      widthMeters: input.widthMeters,
      distanceFromWallStartMeters: input.distanceFromWallStartMeters,
      openingHeightMeters: input.openingHeightMeters,
      sillHeightMeters: input.sillHeightMeters,
    );

    if (!mounted) return;
    _showMessage(
      result.isSuccess
          ? localizations.openingUpdated
          : openingGeometryErrorMessage(
              result.errorCode,
              result.errorData,
              localizations,
              fallback: result.errorMessage ??
                  localizations.invalidOpeningMeasurement,
            ),
      error: !result.isSuccess,
    );
  }

  Future<DoorOpeningDirection?> _chooseDoorOpeningDirection(
    WallFeature feature,
  ) {
    final localizations = AppLocalizations.of(context)!;

    String planDirectionLabel(DoorOpeningDirection openingDirection) {
      final start = _transformPoint(feature.start);
      final end = _transformPoint(feature.end);
      final opening = end - start;
      if (opening.distance <= 0.000001) {
        return openingDirection == DoorOpeningDirection.interior
            ? localizations.doorOpensInterior
            : localizations.doorOpensExterior;
      }
      final tangent = opening / opening.distance;
      var direction = feature.doorSwingSide == DoorSwingSide.left
          ? Offset(-tangent.dy, tangent.dx)
          : Offset(tangent.dy, -tangent.dx);
      if (openingDirection == DoorOpeningDirection.exterior) {
        direction = -direction;
      }
      if (direction.dx.abs() > direction.dy.abs()) {
        return direction.dx >= 0
            ? '→ ${localizations.right}'
            : '← ${localizations.left}';
      }
      return direction.dy >= 0
          ? '↓ ${localizations.directionDown}'
          : '↑ ${localizations.directionUp}';
    }

    return showDialog<DoorOpeningDirection>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: Text(localizations.chooseDoorOpeningDirection),
          children: [
            SimpleDialogOption(
              onPressed: () =>
                  Navigator.pop(dialogContext, DoorOpeningDirection.interior),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.home_outlined),
                title: Text(planDirectionLabel(DoorOpeningDirection.interior)),
                subtitle: Text(localizations.doorOpensInterior),
                trailing:
                    feature.doorOpeningDirection ==
                        DoorOpeningDirection.interior
                    ? const Icon(Icons.check_circle)
                    : null,
              ),
            ),
            SimpleDialogOption(
              onPressed: () =>
                  Navigator.pop(dialogContext, DoorOpeningDirection.exterior),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.exit_to_app),
                title: Text(planDirectionLabel(DoorOpeningDirection.exterior)),
                subtitle: Text(localizations.doorOpensExterior),
                trailing:
                    feature.doorOpeningDirection ==
                        DoorOpeningDirection.exterior
                    ? const Icon(Icons.check_circle)
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<OpeningConnectionSide?> _chooseConnectionSide(WallFeature feature) {
    final localizations = AppLocalizations.of(context)!;
    final start = _transformPoint(feature.start);
    final end = _transformPoint(feature.end);
    final openingDirection = end - start;
    final leftDirection = Offset(-openingDirection.dy, openingDirection.dx);
    final rightDirection = -leftDirection;
    final directionsAreVertical =
        leftDirection.dy.abs() > leftDirection.dx.abs();
    final leftChoiceComesFirst = directionsAreVertical
        ? leftDirection.dy <= rightDirection.dy
        : leftDirection.dx <= rightDirection.dx;
    final firstSide = leftChoiceComesFirst
        ? OpeningConnectionSide.left
        : OpeningConnectionSide.right;
    final firstDirection = leftChoiceComesFirst
        ? leftDirection
        : rightDirection;
    final secondSide = leftChoiceComesFirst
        ? OpeningConnectionSide.right
        : OpeningConnectionSide.left;
    final secondDirection = leftChoiceComesFirst
        ? rightDirection
        : leftDirection;

    return showDialog<OpeningConnectionSide>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(localizations.continuationDirectionTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(localizations.continuationDirectionExplanation),
              const SizedBox(height: 16),
              SizedBox(
                width: 240,
                height: 120,
                child: CustomPaint(
                  painter: _OpeningDirectionPainter(
                    openingDirection: openingDirection,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(dialogContext, firstSide),
                  icon: Icon(_directionIcon(firstDirection)),
                  label: Text(
                    localizations.continueToward(
                      _directionLabel(firstDirection, localizations),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.pop(dialogContext, secondSide),
                  icon: Icon(_directionIcon(secondDirection)),
                  label: Text(
                    localizations.continueToward(
                      _directionLabel(secondDirection, localizations),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(localizations.cancel),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddFeatureMenu({
    required String roomId,
    required ARPoint location,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    final selected = await showModalBottomSheet<FeatureType>(
      context: context,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.add_location_alt),
                title: Text(localizations.addElement),
                subtitle: Text(localizations.selectElementToAdd),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.door_front_door, color: Colors.red),
                title: Text(localizations.door),
                onTap: () {
                  Navigator.pop(bottomSheetContext, FeatureType.door);
                },
              ),
              ListTile(
                leading: const Icon(Icons.window, color: Colors.blue),
                title: Text(localizations.window),
                onTap: () {
                  Navigator.pop(bottomSheetContext, FeatureType.window);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (selected == null || !mounted) {
      return;
    }

    await _placeOpeningOnWall(roomId, selected);
  }

  @override
  Future<void> _placeOpeningOnWall(
    String roomId,
    FeatureType type, {
    WallFeature? feature,
    int? initialWallIndex,
    ARPoint? initialLocation,
  }) async {
    final provider = context.read<FloorPlanProvider>();
    final room = provider.completedRooms
        .where((r) => r.id == roomId)
        .firstOrNull;
    if (room == null || room.points.length < 2) return;
    final placement = await showOpeningPlacementDialog(
      context: context,
      room: room,
      type: type,
      system: context.read<MeasurementSettingsProvider>().system,
      initialFeature: feature,
      initialWallIndex: initialWallIndex,
      initialLocation: initialLocation,
      includeClosingWall: room.isClosed,
    );
    if (!mounted || placement == null) return;
    final current = provider.completedRooms
        .where((r) => r.id == roomId)
        .firstOrNull;
    if (!identical(current, room)) return;
    final result = await provider.placeOpeningOnWall(
      roomId: roomId,
      type: type,
      featureId: feature?.id,
      wallIndex: placement.wallIndex,
      location: placement.location,
      widthMeters: placement.width,
      openingHeightMeters: placement.openingHeightMeters,
      sillHeightMeters: placement.sillHeightMeters,
    );
    if (!mounted) return;
    _showMessage(
      result.isSuccess
          ? AppLocalizations.of(context)!.openingUpdated
          : openingGeometryErrorMessage(
              result.errorCode,
              result.errorData,
              AppLocalizations.of(context)!,
              fallback: result.errorMessage ??
                  AppLocalizations.of(context)!.invalidOpeningMeasurement,
            ),
      error: !result.isSuccess,
    );
  }
}

enum _FeatureMenuAction {
  move,
  delete,
  continueScanning,
  editGeometry,
  toggleHinge,
  chooseOpeningDirection,
}

class _OpeningGeometryInput {
  final double widthMeters;
  final double distanceFromWallStartMeters;
  final double openingHeightMeters;
  final double sillHeightMeters;

  const _OpeningGeometryInput({
    required this.widthMeters,
    required this.distanceFromWallStartMeters,
    required this.openingHeightMeters,
    required this.sillHeightMeters,
  });
}
