part of 'floor_plan_viewer_screen.dart';

// Dialogs to move, rotate and align a room, list rooms and rename them.
mixin _RoomDialogs on State<FloorPlanViewerScreen>, _PlanWallEditing {
  String? get _selectedRoomId;
  set _selectedFeatureId(String? value);
  String _formatLength(double meters, MeasurementSystem measurementSystem);
  RoomModel? _findRoom(String? roomId);
  String _formatArea(double squareMeters, MeasurementSystem measurementSystem);
  Future<void> _openMeasurementEditor({String? roomId});
  Future<void> _organizeRooms();

  Future<void> _showRoomTransformEditor() async {
    final provider = context.read<FloorPlanProvider>();
    final localizations = AppLocalizations.of(context)!;
    final measurementSystem = context
        .read<MeasurementSettingsProvider>()
        .system;
    final rooms = provider.completedRooms;

    if (rooms.isEmpty) {
      _showMessage(localizations.noRoomsToEdit);
      return;
    }

    var selectedRoomId = rooms.any((room) => room.id == _selectedRoomId)
        ? _selectedRoomId!
        : rooms.first.id;
    String? targetRoomId = rooms
        .where(
          (room) => provider.canJoinRoomPair(
            sourceRoomId: selectedRoomId,
            targetRoomId: room.id,
          ),
        )
        .map((room) => room.id)
        .firstOrNull;
    var movementStep = measurementSystem == MeasurementSystem.metric
        ? 0.10
        : MeasurementUnits.inchesToMeters(3);

    setState(() {
      _selectedRoomId = selectedRoomId;
      _selectedFeatureId = null;
    });

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            Future<void> moveRoom({
              required double offsetX,
              required double offsetZ,
            }) async {
              final result = await provider.translateRoomAutomatically(
                roomId: selectedRoomId,
                offsetX: offsetX,
                offsetZ: offsetZ,
              );
              if (context.mounted) {
                setModalState(() {});
              }
              if (result.wasAdjusted && mounted) {
                _showMessage(localizations.roomAdjustedAutomatically);
              } else if (result.wasRejected && mounted) {
                _showMessage(localizations.unsafeMovementRejected, error: true);
              }
            }

            Future<void> rotateRoom(double angleDegrees) async {
              final rotated = await provider.rotateRoom(
                roomId: selectedRoomId,
                angleDegrees: angleDegrees,
              );
              if (context.mounted) {
                setModalState(() {});
              }
              if (!rotated && mounted) {
                _showMessage(localizations.unsafeRotationRejected, error: true);
              }
            }

            Future<void> undoTransform() async {
              await provider.undoTransform();
              if (context.mounted) {
                setModalState(() {});
              }
            }

            Future<void> redoTransform() async {
              await provider.redoTransform();
              if (context.mounted) {
                setModalState(() {});
              }
            }

            Future<void> applyPreciseAdjustment() async {
              final horizontalController = TextEditingController(text: '0');
              final verticalController = TextEditingController(text: '0');
              final rotationController = TextEditingController(text: '0');

              double? parseNumber(String value) {
                return double.tryParse(value.trim().replaceAll(',', '.'));
              }

              final input = await showDialog<_PreciseTransformInput>(
                context: context,
                builder: (dialogContext) {
                  String? validationMessage;
                  return StatefulBuilder(
                    builder: (context, setDialogState) => AlertDialog(
                      title: Text(localizations.preciseAdjustment),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(localizations.preciseAdjustmentExplanation),
                            const SizedBox(height: 16),
                            TextField(
                              controller: horizontalController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: true,
                                  ),
                              decoration: InputDecoration(
                                labelText: localizations.horizontalAdjustment,
                                suffixText:
                                    measurementSystem ==
                                        MeasurementSystem.metric
                                    ? localizations.meters
                                    : localizations.inches,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: verticalController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: true,
                                  ),
                              decoration: InputDecoration(
                                labelText: localizations.verticalAdjustment,
                                suffixText:
                                    measurementSystem ==
                                        MeasurementSystem.metric
                                    ? localizations.meters
                                    : localizations.inches,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: rotationController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: true,
                                  ),
                              decoration: InputDecoration(
                                labelText: localizations.rotationDegrees,
                                suffixText: localizations.degrees,
                                border: const OutlineInputBorder(),
                                errorText: validationMessage,
                              ),
                            ),
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
                            final horizontal = parseNumber(
                              horizontalController.text,
                            );
                            final vertical = parseNumber(
                              verticalController.text,
                            );
                            final rotation = parseNumber(
                              rotationController.text,
                            );
                            if (horizontal == null ||
                                vertical == null ||
                                rotation == null ||
                                (horizontal.abs() <= 0.000001 &&
                                    vertical.abs() <= 0.000001 &&
                                    rotation.abs() <= 0.000001)) {
                              setDialogState(() {
                                validationMessage =
                                    localizations.invalidPreciseAdjustment;
                              });
                              return;
                            }
                            final offsetX =
                                measurementSystem == MeasurementSystem.metric
                                ? horizontal
                                : MeasurementUnits.inchesToMeters(horizontal);
                            final offsetZ =
                                measurementSystem == MeasurementSystem.metric
                                ? vertical
                                : MeasurementUnits.inchesToMeters(vertical);
                            Navigator.pop(
                              dialogContext,
                              _PreciseTransformInput(
                                offsetX: offsetX,
                                offsetZ: offsetZ,
                                angleDegrees: rotation,
                              ),
                            );
                          },
                          child: Text(localizations.applyAdjustment),
                        ),
                      ],
                    ),
                  );
                },
              );
              horizontalController.dispose();
              verticalController.dispose();
              rotationController.dispose();

              if (input == null) {
                return;
              }
              final applied = await provider.transformRoomPrecisely(
                roomId: selectedRoomId,
                offsetX: input.offsetX,
                offsetZ: input.offsetZ,
                angleDegrees: input.angleDegrees,
              );
              if (context.mounted) {
                setModalState(() {});
              }
              if (!mounted) {
                return;
              }
              _showMessage(
                applied
                    ? localizations.preciseAdjustmentApplied
                    : localizations.unsafeMovementRejected,
                error: !applied,
              );
            }

            Future<void> alignNearestWall() async {
              final previewResult = provider.createWallAlignmentPreview(
                roomId: selectedRoomId,
              );
              final preview = previewResult.preview;
              if (preview == null) {
                _showMessage(
                  previewResult.status ==
                          WallAlignmentPreviewStatus.overlapPrevented
                      ? localizations.joinOverlapPrevented
                      : localizations.noSafeNearbyWall,
                  error: true,
                );
                return;
              }

              final confirmed = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text(localizations.alignmentPreviewTitle),
                  content: SizedBox(
                    width: 420,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          localizations.alignmentPreviewMessage,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F8FA),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFD8DCE2),
                              ),
                            ),
                            child: CustomPaint(
                              painter: _AlignmentPreviewPainter(
                                preview: preview,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 18,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            _PreviewLegend(
                              color: const Color(0xFFFF8A00),
                              label: localizations.alignmentCurrentPosition,
                            ),
                            _PreviewLegend(
                              color: const Color(0xFF00A86B),
                              label: localizations.alignmentProposedPosition,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: Text(localizations.cancel),
                    ),
                    FilledButton.icon(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      icon: const Icon(Icons.check),
                      label: Text(localizations.applyAlignment),
                    ),
                  ],
                ),
              );
              if (confirmed != true || !mounted) {
                return;
              }

              final result = await provider.applyWallAlignmentPreview(preview);
              if (context.mounted) {
                setModalState(() {});
              }
              if (!mounted) {
                return;
              }
              _showMessage(
                result == WallAlignmentResult.aligned
                    ? localizations.wallAlignedSuccessfully
                    : result == WallAlignmentResult.stalePreview
                    ? localizations.alignmentPreviewExpired
                    : localizations.noSafeNearbyWall,
                error: result != WallAlignmentResult.aligned,
              );
            }

            Future<void> joinSelectedRooms() async {
              final destinationId = targetRoomId;
              if (destinationId == null) {
                _showMessage(
                  localizations.noIndependentRoomAvailable,
                  error: true,
                );
                return;
              }

              final sourceRoom = rooms.firstWhere(
                (room) => room.id == selectedRoomId,
              );
              final targetRoom = rooms.firstWhere(
                (room) => room.id == destinationId,
              );
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text(localizations.joinPreviewTitle),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.join_inner_rounded,
                        size: 48,
                        color: Color(0xFF00A86B),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        localizations.joinPreviewMessage(
                          sourceRoom.name,
                          targetRoom.name,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: Text(localizations.cancel),
                    ),
                    FilledButton.icon(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      icon: const Icon(Icons.check),
                      label: Text(localizations.applyJoin),
                    ),
                  ],
                ),
              );

              if (confirmed != true) return;

              final result = await provider.joinRooms(
                sourceRoomId: selectedRoomId,
                targetRoomId: destinationId,
              );
              if (context.mounted) {
                setModalState(() {});
              }
              if (!mounted) return;

              _showMessage(
                result == WallAlignmentResult.aligned
                    ? localizations.joinCompleted
                    : result == WallAlignmentResult.overlapPrevented
                    ? localizations.joinOverlapPrevented
                    : localizations.noSafeNearbyWall,
                error: result != WallAlignmentResult.aligned,
              );
            }

            Widget movementButton({
              required IconData icon,
              required String tooltip,
              required VoidCallback onPressed,
            }) {
              return Tooltip(
                message: tooltip,
                child: SizedBox(
                  width: 58,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: onPressed,
                    child: Icon(icon),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                24 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    localizations.transformRoomsTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(localizations.connectedGroupTransformHint),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: provider.canUndoTransform
                              ? undoTransform
                              : null,
                          icon: const Icon(Icons.undo),
                          label: Text(localizations.undoLastTransform),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: provider.canRedoTransform
                              ? redoTransform
                              : null,
                          icon: const Icon(Icons.redo),
                          label: Text(localizations.redoLastTransform),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FilledButton.icon(
                    onPressed: alignNearestWall,
                    icon: const Icon(Icons.vertical_align_center),
                    label: Text(localizations.alignNearestWall),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: targetRoomId == null ? null : joinSelectedRooms,
                    icon: const Icon(Icons.join_inner_rounded),
                    label: Text(localizations.joinRooms),
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<String>(
                    initialValue: selectedRoomId,
                    decoration: InputDecoration(
                      labelText: localizations.selectedRoom,
                      border: const OutlineInputBorder(),
                    ),
                    items: rooms
                        .map(
                          (room) => DropdownMenuItem<String>(
                            value: room.id,
                            child: Text(room.name),
                          ),
                        )
                        .toList(),
                    onChanged: (roomId) {
                      if (roomId == null) {
                        return;
                      }

                      setModalState(() {
                        selectedRoomId = roomId;
                        final availableTargets = rooms.where(
                          (room) => provider.canJoinRoomPair(
                            sourceRoomId: roomId,
                            targetRoomId: room.id,
                          ),
                        );
                        if (targetRoomId == null ||
                            !availableTargets.any(
                              (room) => room.id == targetRoomId,
                            )) {
                          targetRoomId = availableTargets
                              .map((room) => room.id)
                              .firstOrNull;
                        }
                      });
                      setState(() {
                        _selectedRoomId = roomId;
                        _selectedFeatureId = null;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: targetRoomId,
                    decoration: InputDecoration(
                      labelText: localizations.roomToJoin,
                      border: const OutlineInputBorder(),
                    ),
                    items: rooms
                        .where(
                          (room) => provider.canJoinRoomPair(
                            sourceRoomId: selectedRoomId,
                            targetRoomId: room.id,
                          ),
                        )
                        .map(
                          (room) => DropdownMenuItem<String>(
                            value: room.id,
                            child: Text(room.name),
                          ),
                        )
                        .toList(),
                    onChanged: (roomId) {
                      setModalState(() {
                        targetRoomId = roomId;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<double>(
                    initialValue: movementStep,
                    decoration: InputDecoration(
                      labelText: localizations.movementDistance,
                      border: const OutlineInputBorder(),
                    ),
                    items: measurementSystem == MeasurementSystem.metric
                        ? [
                            DropdownMenuItem(
                              value: 0.05,
                              child: Text(localizations.fiveCentimeters),
                            ),
                            DropdownMenuItem(
                              value: 0.10,
                              child: Text(localizations.tenCentimeters),
                            ),
                            DropdownMenuItem(
                              value: 0.25,
                              child: Text(localizations.twentyFiveCentimeters),
                            ),
                            DropdownMenuItem(
                              value: 0.50,
                              child: Text(localizations.fiftyCentimeters),
                            ),
                          ]
                        : [
                            DropdownMenuItem(
                              value: MeasurementUnits.inchesToMeters(1),
                              child: Text(localizations.oneInch),
                            ),
                            DropdownMenuItem(
                              value: MeasurementUnits.inchesToMeters(3),
                              child: Text(localizations.threeInches),
                            ),
                            DropdownMenuItem(
                              value: MeasurementUnits.inchesToMeters(6),
                              child: Text(localizations.sixInches),
                            ),
                            DropdownMenuItem(
                              value: MeasurementUnits.metersPerFoot,
                              child: Text(localizations.oneFoot),
                            ),
                          ],
                    onChanged: (step) {
                      if (step == null) {
                        return;
                      }
                      setModalState(() {
                        movementStep = step;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: applyPreciseAdjustment,
                    icon: const Icon(Icons.tune_rounded),
                    label: Text(localizations.preciseAdjustment),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    localizations.movement,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        movementButton(
                          icon: Icons.keyboard_arrow_up,
                          tooltip: localizations.moveUp,
                          onPressed: () async {
                            await moveRoom(offsetX: 0, offsetZ: -movementStep);
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            movementButton(
                              icon: Icons.keyboard_arrow_left,
                              tooltip: localizations.moveLeft,
                              onPressed: () async {
                                await moveRoom(
                                  offsetX: -movementStep,
                                  offsetZ: 0,
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            movementButton(
                              icon: Icons.keyboard_arrow_down,
                              tooltip: localizations.moveDown,
                              onPressed: () async {
                                await moveRoom(
                                  offsetX: 0,
                                  offsetZ: movementStep,
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            movementButton(
                              icon: Icons.keyboard_arrow_right,
                              tooltip: localizations.moveRight,
                              onPressed: () async {
                                await moveRoom(
                                  offsetX: movementStep,
                                  offsetZ: 0,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    localizations.rotation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            await rotateRoom(-15);
                          },
                          icon: const Icon(Icons.rotate_left),
                          label: Text(
                            localizations.rotateFifteenDegreesLeft,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            await rotateRoom(15);
                          },
                          icon: const Icon(Icons.rotate_right),
                          label: Text(
                            localizations.rotateFifteenDegreesRight,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(bottomSheetContext).pop(),
                    icon: const Icon(Icons.check),
                    label: Text(localizations.finishEditing),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> _showRoomListDialog() async {
    ModalRoute<dynamic>? roomListRoute;
    final action = await showModalBottomSheet<_RoomListAction>(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        roomListRoute = ModalRoute.of(bottomSheetContext);
        return Consumer<FloorPlanProvider>(
          builder: (context, provider, child) {
            final rooms = provider.completedRooms;
            final localizations = AppLocalizations.of(context)!;
            final measurementSystem = context
                .watch<MeasurementSettingsProvider>()
                .system;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            localizations.registeredRooms,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: localizations.close,
                          onPressed: () {
                            Navigator.pop(bottomSheetContext);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (rooms.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: Text(localizations.noRoomsYet)),
                      )
                    else
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: rooms.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final room = rooms[index];

                            final area = PlanEditGeometry.area(room);
                            final perimeter = PlanEditGeometry.perimeter(room);

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(room.name),
                              subtitle: Text(
                                localizations.roomSummary(
                                  room.isClosed
                                      ? _formatArea(area, measurementSystem)
                                      : localizations.planOpenContour,
                                  _formatLength(perimeter, measurementSystem),
                                  room.points.length,
                                ),
                              ),
                              trailing: PopupMenuButton<_RoomListActionType>(
                                key: ValueKey('room-actions-${room.id}'),
                                tooltip: localizations.actions,
                                onSelected: (type) {
                                  Navigator.pop(
                                    bottomSheetContext,
                                    _RoomListAction(
                                      type: type,
                                      roomId: room.id,
                                    ),
                                  );
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value:
                                          _RoomListActionType.editMeasurements,
                                      child: ListTile(
                                        dense: true,
                                        leading: const Icon(
                                          Icons.straighten_outlined,
                                        ),
                                        title: Text(
                                          localizations.editMeasurements,
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: _RoomListActionType.rename,
                                      child: ListTile(
                                        dense: true,
                                        leading: const Icon(Icons.edit_outlined),
                                        title: Text(localizations.rename),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: _RoomListActionType.delete,
                                      child: ListTile(
                                        dense: true,
                                        leading: const Icon(
                                          Icons.delete_forever_outlined,
                                        ),
                                        title: Text(
                                          localizations.planDeleteRoom,
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    if (rooms.length > 1) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(
                              bottomSheetContext,
                              const _RoomListAction(
                                type: _RoomListActionType.organize,
                              ),
                            );
                          },
                          icon: const Icon(Icons.grid_view_rounded),
                          label: Text(localizations.organizeRooms),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    await roomListRoute?.completed;
    if (action == null || !mounted) {
      return;
    }

    switch (action.type) {
      case _RoomListActionType.delete:
        final room = _findRoom(action.roomId);
        if (room != null) await _deletePlanRoom(room);
        break;
      case _RoomListActionType.editMeasurements:
        await _openMeasurementEditor(roomId: action.roomId);
        break;

      case _RoomListActionType.rename:
        final room = _findRoom(action.roomId);
        if (room != null) {
          await _editRoomName(room);
        }
        break;

      case _RoomListActionType.organize:
        await _organizeRooms();
        break;
    }
  }

  Future<void> _editRoomName(RoomModel room) async {
    final localizations = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: room.name);

    final newName = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(localizations.renameRoom),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: localizations.roomNameShortLabel,
              hintText: localizations.roomNameMainBedroomExample,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              Navigator.pop(dialogContext, value.trim());
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(localizations.cancel),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, controller.text.trim());
              },
              child: Text(localizations.save),
            ),
          ],
        );
      },
    );

    controller.dispose();
    if (newName == null || newName.trim().isEmpty || !mounted) {
      return;
    }

    await context.read<FloorPlanProvider>().updateRoomName(
      room.id,
      newName.trim(),
    );
  }
}

enum _RoomListActionType { delete, editMeasurements, rename, organize }

class _RoomListAction {
  final _RoomListActionType type;

  final String? roomId;

  const _RoomListAction({required this.type, this.roomId});
}

class _PreciseTransformInput {
  final double offsetX;
  final double offsetZ;
  final double angleDegrees;

  const _PreciseTransformInput({
    required this.offsetX,
    required this.offsetZ,
    required this.angleDegrees,
  });
}

class _PreviewLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _PreviewLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 7),
        Text(label),
      ],
    );
  }
}
