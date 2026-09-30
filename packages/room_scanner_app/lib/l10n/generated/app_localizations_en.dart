// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get undoScanEdit => 'Undo last action';

  @override
  String get redoScanEdit => 'Redo last action';

  @override
  String get placeOpeningByTouch => 'Place opening on the plan';

  @override
  String get touchOpeningInstructions =>
      'Tap a wall and slide the opening into position. You can also choose the closing wall. Adjust the width and confirm.';

  @override
  String get deleteOpening => 'Delete opening';

  @override
  String get deleteOpeningConfirmation =>
      'This opening will be removed. If it connects two rooms, the connection will be removed without deleting the rooms.';

  @override
  String get appTitle => 'ARchScan';

  @override
  String get newRoom => 'New room';

  @override
  String get roomName => 'Room name';

  @override
  String get roomDestination => 'Purpose or name';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get wall => 'Wall';

  @override
  String get door => 'Door';

  @override
  String get window => 'Window';

  @override
  String get roomTypeLiving => 'Living room';

  @override
  String get roomTypeKitchen => 'Kitchen';

  @override
  String get roomTypeBathroom => 'Bathroom';

  @override
  String get roomTypeBedroom => 'Bedroom';

  @override
  String get roomTypeLaundry => 'Laundry room';

  @override
  String get roomTypeHallway => 'Hallway';

  @override
  String get roomTypeDiningRoom => 'Dining room';

  @override
  String get roomTypeDailyDiningRoom => 'Breakfast room';

  @override
  String get roomTypePatio => 'Patio';

  @override
  String get roomTypeHall => 'Hall';

  @override
  String get roomTypeBalcony => 'Balcony';

  @override
  String get roomTypeTerrace => 'Terrace';

  @override
  String get roomTypeGarage => 'Garage';

  @override
  String get roomTypePlayroom => 'Playroom';

  @override
  String get roomTypeOther => 'Other space';

  @override
  String get scanWithRoomPlan => 'Scan with RoomPlan';

  @override
  String get roomPlanSpaceSaved => 'RoomPlan space saved';

  @override
  String roomPlanCaptureFailed(String error) {
    return 'RoomPlan could not complete the scan: $error';
  }

  @override
  String get roomType => 'Room type';

  @override
  String get viewPlan => 'View floor plan';

  @override
  String get editRoomName => 'Edit room name';

  @override
  String get roomNameExample => 'Example: Ana\'s bedroom';

  @override
  String get whatIsSpaceName => 'What is this space called?';

  @override
  String get roomSuggestionOffice => 'Office';

  @override
  String get roomSuggestionStorage => 'Storage';

  @override
  String get spaceSaved => 'Space saved';

  @override
  String get whatWouldYouLikeToDo =>
      'What would you like to do now? To continue from another space, select a door or window on the floor plan.';

  @override
  String get addAnotherSpace => 'Add another space';

  @override
  String get viewFullPlan => 'View full floor plan';

  @override
  String get chooseOpeningToContinue => 'Choose a door or window to continue';

  @override
  String get noAvailableOpenings => 'There are no available openings.';

  @override
  String get openingAlreadyConnected =>
      'This opening already connects two spaces.';

  @override
  String get unfinishedScan => 'Unfinished scan';

  @override
  String get unfinishedScanFound => 'We found a scan that was not completed.';

  @override
  String get continueScan => 'Continue scanning';

  @override
  String get discardScan => 'Discard';

  @override
  String get markStartRecommendation => 'Mark the starting point';

  @override
  String get addNextCornerRecommendation => 'Add the next corner';

  @override
  String get closeSpaceRecommendation => 'You can now close the space';

  @override
  String get calculating => 'CALCULATING...';

  @override
  String get markStart => 'MARK START';

  @override
  String get measureNextCorner => 'MEASURE NEXT CORNER';

  @override
  String get placeDoor => 'PLACE DOOR';

  @override
  String get placeWindow => 'PLACE WINDOW';

  @override
  String get addCorner => 'ADD CORNER';

  @override
  String get markSecondEnd => 'MARK SECOND END';

  @override
  String get measureDoor => 'MEASURE DOOR';

  @override
  String get measureWindow => 'MEASURE WINDOW';

  @override
  String get preparingCamera => 'Preparing camera...';

  @override
  String get basicScanner => 'Basic scanner';

  @override
  String get cameraStartFailed => 'The camera could not be started';

  @override
  String get unknownError => 'Unknown error.';

  @override
  String get retryCamera => 'Retry camera';

  @override
  String get cameraPermissionRequired =>
      'Camera permission is required to use the Basic scanner.';

  @override
  String get cameraUnavailable =>
      'The device does not have an available camera.';

  @override
  String get cameraTimeoutMessage =>
      'The camera took too long to respond. You can try starting it again.';

  @override
  String get closeRoom => 'Close room';

  @override
  String get chooseClosingCorner => 'Choose the corner where you want to close';

  @override
  String get chooseDifferentCorner =>
      'Choose a corner different from the starting one';

  @override
  String get diagonalClosureDetectedTitle => 'Diagonal closure detected';

  @override
  String get diagonalClosureDetectedMessage =>
      'Closing directly would create a diagonal. The application can add the missing orthogonal corner and close against the first real corner of the room.';

  @override
  String get addCornerAndClose => 'Add corner and close';

  @override
  String smartCloseMessage(String distance) {
    return 'The measurement ends $distance meters from the starting point. Do you want to adjust the closure exactly to the starting point?';
  }

  @override
  String get continueMeasuring => 'Continue measuring';

  @override
  String cameraResumeFailed(String error) {
    return 'The camera could not be resumed: $error';
  }

  @override
  String get continuationFromOpening => 'Continuation from an opening';

  @override
  String get continuationFirstCornerInstruction =>
      'From the green point, measure the distance to the first actual corner of the room.';

  @override
  String get markRoomStartingPoint => 'Mark the room\'s starting point.';

  @override
  String get measureNextCornerInstruction =>
      'Measure the distance to the next corner and choose its direction.';

  @override
  String get traceStarted => 'Drawing started';

  @override
  String cornerRegistered(int count) {
    return 'Corner $count registered';
  }

  @override
  String get needThreeCornersToClose =>
      'You need at least 3 corners to close the room.';

  @override
  String get canContinueOrClose =>
      'You can continue adding corners or close the room.';

  @override
  String get lastCornerRemoved => 'Last corner removed.';

  @override
  String get measureFirstCorner => 'Measure first corner';

  @override
  String get measureFirstCornerBeforeFeatures =>
      'First, measure the first actual corner of the room.';

  @override
  String get couldNotAddStart => 'The starting point could not be added.';

  @override
  String get startMarked =>
      'Starting point marked. Now measure the first wall.';

  @override
  String get couldNotCalculateCorner =>
      'The new corner could not be calculated.';

  @override
  String get invalidCorner => 'The corner is not valid.';

  @override
  String get firstCornerRegistered =>
      'First corner registered. Continue measuring the room\'s walls.';

  @override
  String measurementRegistrationFailed(String error) {
    return 'The measurement could not be registered: $error';
  }

  @override
  String get couldNotCalculateLocation =>
      'The location could not be calculated.';

  @override
  String get enterOpeningWidth => 'Enter the opening width.';

  @override
  String get couldNotAttachOpening =>
      'The opening could not be attached to a wall.';

  @override
  String doorAdjustedToWall(String width) {
    return 'Door measuring $width meters adjusted to the wall.';
  }

  @override
  String windowAdjustedToWall(String width) {
    return 'Window measuring $width meters adjusted to the wall.';
  }

  @override
  String locationRegistrationFailed(String error) {
    return 'The location could not be registered: $error';
  }

  @override
  String get openingWallQuestion => 'Which wall contains the opening?';

  @override
  String get openingWallExplanation =>
      'Choose the closing wall if the door or window is on the segment that joins the last corner to the first.';

  @override
  String get detectWallAutomatically => 'Detect wall automatically';

  @override
  String get useClosingWall => 'Use closing wall';

  @override
  String get placeElement => 'Place element';

  @override
  String get measureCorner => 'Measure corner';

  @override
  String get featureDistanceInstruction =>
      'Enter the distance from the last position to the door or window.';

  @override
  String get cornerDistanceInstruction =>
      'Enter the distance from the last corner to the new corner.';

  @override
  String get manualFirstWallInstruction =>
      'This device does not support ARCore. Manually enter the distance from the starting corner to the new one.';

  @override
  String get manualNextWallInstruction =>
      'This device does not support ARCore. Manually enter the distance from the previous corner to the new one.';

  @override
  String get distance => 'Distance';

  @override
  String get distanceExample => 'Example: 3.50';

  @override
  String get meters => 'meters';

  @override
  String get enterPositiveDistance => 'Enter a distance greater than 0';

  @override
  String get direction => 'Direction';

  @override
  String get directionExample => 'Example: 90';

  @override
  String get degrees => 'degrees';

  @override
  String get enterValidDirection => 'Enter a valid direction';

  @override
  String get doorWidth => 'Door width';

  @override
  String get windowWidth => 'Window width';

  @override
  String get widthExample => 'Example: 1.20';

  @override
  String get enterMinimumOpeningWidth => 'Enter a minimum width of 0.20 meters';

  @override
  String get quickDirection => 'Quick direction:';

  @override
  String get front => 'Front';

  @override
  String get right => 'Right';

  @override
  String get back => 'Back';

  @override
  String get left => 'Left';

  @override
  String get featureDoesNotCreateCorner =>
      'This does not create a new room corner.';

  @override
  String get positionValidatedBeforeAdding =>
      'The new position is validated before it is added to the floor plan.';

  @override
  String get useMeasurement => 'Use measurement';

  @override
  String get measurementSystem => 'Measurement system';

  @override
  String get metricSystem => 'Meters';

  @override
  String get imperialSystem => 'Feet and inches';

  @override
  String get feet => 'Feet';

  @override
  String get inches => 'Inches';

  @override
  String get squareMeters => 'square meters';

  @override
  String get squareFeet => 'square feet';

  @override
  String get changeDoorHingeSide => 'Change hinge side';

  @override
  String get changeDoorOpeningDirection => 'Change opening direction';

  @override
  String get chooseDoorOpeningDirection => 'Choose door opening direction';

  @override
  String get doorOpensInterior => 'Open toward the interior';

  @override
  String get doorOpensExterior => 'Open toward the exterior';

  @override
  String get editOpeningDimensions => 'Edit measurements and position';

  @override
  String get openingWidth => 'Opening width';

  @override
  String get distanceFromWallStart => 'Distance from the starting wall corner';

  @override
  String get wallLength => 'Wall length';

  @override
  String get invalidOpeningMeasurement =>
      'Enter valid measurements for the width and position.';

  @override
  String get openingUpdated => 'Opening updated successfully.';

  @override
  String get openingHeight => 'Opening height';

  @override
  String get sillHeight => 'Height above floor';

  @override
  String get horizontalOrientation => 'Horizontal';

  @override
  String get verticalOrientation => 'Vertical';

  @override
  String doorPlanDimensions(String width, String height) {
    return '$width wide · $height high';
  }

  @override
  String windowPlanDimensions(
      String width, String height, String sill, String orientation) {
    return '$width wide · $height high\n$sill above floor · $orientation';
  }

  @override
  String get noRoomsToEdit => 'There are no rooms to edit.';

  @override
  String get transformRoomsTitle => 'Move and rotate rooms';

  @override
  String get touchTransformRooms => 'Move rooms with gestures';

  @override
  String get zoomOut => 'Zoom out';

  @override
  String get zoomIn => 'Zoom in';

  @override
  String get resetView => 'Reset view';

  @override
  String get touchTransformExplanation =>
      'Drag the room with one finger. Use two fingers to pan or zoom the plan; the adjustment button rotates it.';

  @override
  String get connectedGroupTransformHint =>
      'If the room is connected through an opening, the entire group will move or rotate as a single unit.';

  @override
  String get selectedRoom => 'Selected room';

  @override
  String get movementDistance => 'Distance of each movement';

  @override
  String get fiveCentimeters => '5 centimeters';

  @override
  String get tenCentimeters => '10 centimeters';

  @override
  String get twentyFiveCentimeters => '25 centimeters';

  @override
  String get fiftyCentimeters => '50 centimeters';

  @override
  String get oneInch => '1 inch';

  @override
  String get threeInches => '3 inches';

  @override
  String get sixInches => '6 inches';

  @override
  String get oneFoot => '1 foot';

  @override
  String get movement => 'Movement';

  @override
  String get moveUp => 'Move up';

  @override
  String get moveDown => 'Move down';

  @override
  String get moveLeft => 'Move left';

  @override
  String get moveRight => 'Move right';

  @override
  String get rotation => 'Rotation';

  @override
  String get rotateFifteenDegreesLeft => 'Rotate 15 degrees to the left';

  @override
  String get rotateFifteenDegreesRight => 'Rotate 15 degrees to the right';

  @override
  String get finishEditing => 'Finish editing';

  @override
  String get preciseAdjustment => 'Precise adjustment';

  @override
  String get preciseAdjustmentExplanation =>
      'Enter the exact horizontal movement, vertical movement, and rotation for the selected group.';

  @override
  String get horizontalAdjustment => 'Horizontal movement';

  @override
  String get verticalAdjustment => 'Vertical movement';

  @override
  String get rotationDegrees => 'Rotation in degrees';

  @override
  String get applyAdjustment => 'Apply adjustment';

  @override
  String get invalidPreciseAdjustment =>
      'Enter at least one valid non-zero value.';

  @override
  String get preciseAdjustmentApplied =>
      'The precise adjustment was applied successfully.';

  @override
  String get undoLastTransform => 'Undo last adjustment';

  @override
  String get redoLastTransform => 'Redo last adjustment';

  @override
  String get alignNearestWall => 'Align with the nearest wall';

  @override
  String get alignmentPreviewTitle => 'Alignment preview';

  @override
  String get alignmentPreviewMessage =>
      'Review the current position and the proposed position before applying the adjustment.';

  @override
  String get alignmentCurrentPosition => 'Current position';

  @override
  String get alignmentProposedPosition => 'Proposed position';

  @override
  String get applyAlignment => 'Apply alignment';

  @override
  String get alignmentPreviewExpired =>
      'The floor plan changed after the preview was generated. Create a new alignment preview.';

  @override
  String get wallAlignedSuccessfully => 'The walls were aligned successfully.';

  @override
  String get joinRooms => 'Join spaces';

  @override
  String get roomToJoin => 'Destination space';

  @override
  String get joinPreviewTitle => 'Join preview';

  @override
  String joinPreviewMessage(String source, String target) {
    return '$source will be moved to join it with $target. The application will reject the operation if it causes overlaps.';
  }

  @override
  String get applyJoin => 'Apply join';

  @override
  String get joinCompleted => 'The spaces were joined successfully.';

  @override
  String get joinOverlapPrevented =>
      'The join was cancelled because it would cause an overlap.';

  @override
  String get noIndependentRoomAvailable =>
      'There is no other independent space available to join.';

  @override
  String get noSafeNearbyWall =>
      'No nearby parallel wall could be aligned safely.';

  @override
  String get sharedWall => 'Shared wall';

  @override
  String get partialSharedWall => 'Shared wall segment';

  @override
  String get roomAdjustedAutomatically => 'The room was adjusted successfully.';

  @override
  String get unsafeMovementRejected =>
      'The movement was cancelled because it would cause an overlap.';

  @override
  String get unsafeRotationRejected =>
      'The rotation was cancelled because it would cause an overlap.';

  @override
  String get selectedDoor => 'Selected door';

  @override
  String get selectedWindow => 'Selected window';

  @override
  String get openingConnectedStatus => 'Connected';

  @override
  String get openingAvailableStatus => 'Available';

  @override
  String get openingStartAtMarkedPoint => 'Starts at the marked point';

  @override
  String get continueScanFromHere => 'Continue scanning from here';

  @override
  String get selectedDoorUnavailable =>
      'The selected door is no longer available.';

  @override
  String get selectedOpeningUnavailable =>
      'The selected opening is no longer available.';

  @override
  String get openingWallNotFound => 'The opening wall could not be identified.';

  @override
  String get continuationDirectionTitle =>
      'Which way does the floor plan continue?';

  @override
  String get continuationDirectionExplanation =>
      'The green point marks where the new space will begin. Choose the arrow pointing toward the space you are going to scan.';

  @override
  String continueToward(String direction) {
    return 'Continue toward $direction';
  }

  @override
  String get directionRight => 'the right';

  @override
  String get directionLeft => 'the left';

  @override
  String get directionDown => 'down';

  @override
  String get directionUp => 'up';

  @override
  String get notEnoughRoomsToOrganize =>
      'There are not enough spaces to organize.';

  @override
  String get organizeRooms => 'Organize spaces';

  @override
  String get organizeRoomsExplanation =>
      'Only independent groups will be arranged. Spaces connected by openings or shared walls move together, preserving alignment, measurements, doors, and windows.\n\nThe first group stays fixed. An already assembled plan will not change. You can undo the arrangement.';

  @override
  String get roomsOrganizedSuccessfully => 'Spaces organized successfully.';

  @override
  String get floorPlan2D => 'Overall 2D floor plan';

  @override
  String get editMeasurements => 'Edit measurements';

  @override
  String get moreOptions => 'More options';

  @override
  String get importPlan => 'Import floor plan';

  @override
  String get importProject => 'Import JSON or SVG';

  @override
  String get exportProject => 'Export file';

  @override
  String get exportJson => 'JSON — complete project backup';

  @override
  String get exportSvg => 'SVG — editable vector floor plan';

  @override
  String get exportPng => 'PNG — sharp floor plan image';

  @override
  String get exportJpg => 'JPG — compact floor plan image';

  @override
  String get exportDestination => 'What would you like to do with the file?';

  @override
  String get saveToFiles => 'Save to Files…';

  @override
  String get shareFile => 'Share…';

  @override
  String get replaceProjectTitle => 'Replace the open project';

  @override
  String get replaceProjectMessage =>
      'The file is valid. If you continue, it will replace the open floor plan. Files saved outside ARchScan will not be deleted.';

  @override
  String get shareJson => 'Save JSON to Files';

  @override
  String get exportPdf => 'Save PDF to Files';

  @override
  String get registeredRooms => 'Registered spaces';

  @override
  String get tapRoomToAddOpening =>
      'Tap inside a space to add a door or window.';

  @override
  String roomCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spaces',
      one: '1 space',
    );
    return '$_temp0';
  }

  @override
  String get planImportedSuccessfully => 'Floor plan imported successfully.';

  @override
  String get planImportCancelledOrInvalid => 'Import cancelled or invalid.';

  @override
  String get addElement => 'Add element';

  @override
  String get selectElementToAdd => 'Select the element you want to add.';

  @override
  String get noRoomsYet => 'There are no spaces yet.';

  @override
  String get renameRoom => 'Rename space';

  @override
  String get roomNameShortLabel => 'Name';

  @override
  String get roomNameMainBedroomExample => 'Example: Main bedroom';

  @override
  String get noScannedRooms => 'There are no scanned spaces';

  @override
  String get completeScanToViewPlan =>
      'Complete a scan to view the overall floor plan.';

  @override
  String get closeProject => 'Close project';

  @override
  String get close => 'Close';

  @override
  String roomSummary(String area, String perimeter, int cornerCount) {
    String _temp0 = intl.Intl.pluralLogic(
      cornerCount,
      locale: localeName,
      other: '$cornerCount corners',
      one: '1 corner',
    );
    return '$area · $perimeter perimeter · $_temp0';
  }

  @override
  String get actions => 'Actions';

  @override
  String get rename => 'Rename';

  @override
  String get completeAllFields => 'Please complete all fields.';

  @override
  String get newProject => 'New project';

  @override
  String get projectNameExample => 'E.g. Office renovation';

  @override
  String get create => 'Create';

  @override
  String get myProjects => 'My projects';

  @override
  String get localProjectsStoredOnDevice =>
      'Projects stored only on this device';

  @override
  String get newScan => 'New scan';

  @override
  String get noSavedProjects => 'You have no saved projects';

  @override
  String get pressNewScanToStart => 'Press “New scan” to begin';

  @override
  String projectUpdated(String date) {
    return 'Updated: $date';
  }

  @override
  String get viewFloorPlan => 'View floor plan';

  @override
  String get delete => 'Delete';

  @override
  String get permissionsRequired => 'Permissions required';

  @override
  String get cameraLocationPermissionsDenied =>
      'Camera permission was not granted. Enable it in system settings to scan.';

  @override
  String get scannerUnavailable => 'Scanner unavailable';

  @override
  String get basicScannerInitializationFailed =>
      'The camera is available, but the Basic Scanner could not be initialized.';

  @override
  String get deviceCameraUnavailable =>
      'This device does not have a camera available for scanning.';

  @override
  String get understood => 'Understood';

  @override
  String get arTrackingActive => 'Augmented reality active';

  @override
  String get arCalibrating => 'Calibrating';

  @override
  String get markOpeningEndpointA => 'Mark endpoint A';

  @override
  String get markOpeningEndpointB => 'Mark endpoint B';

  @override
  String get pointOpeningEndpointAInstruction =>
      'Aim at endpoint A of the opening and mark the reference.';

  @override
  String get pointOpeningEndpointBInstruction =>
      'Now aim at endpoint B of the same opening.';

  @override
  String get openingReferenceAlignedInstruction =>
      'Reference aligned. You can now measure the new space.';

  @override
  String get invalidOpeningReferencePoint =>
      'No valid point was detected. Aim at the opening and try again.';

  @override
  String get openingReferenceEndpointsTooClose =>
      'The endpoints are too close. Mark endpoint B again.';

  @override
  String openingReferenceDifference(String difference) {
    return 'Reference aligned. Warning: the augmented reality measurement differs from the plan by $difference.';
  }

  @override
  String get openingReferenceAligned => 'Reference aligned correctly.';

  @override
  String get invalidCameraPosition =>
      'No valid camera position was detected. Aim at a recognized surface and try again.';

  @override
  String get needTwoCornersBeforeOpening =>
      'Mark at least 2 corners before measuring an opening.';

  @override
  String featureStartRegistered(String feature) {
    return 'Start of $feature registered. Move the camera to the other endpoint and press again.';
  }

  @override
  String get openingMeasurementFailed => 'The opening could not be measured.';

  @override
  String featureSaved(String feature, String warning) {
    return '$feature saved. $warning';
  }

  @override
  String get referenceOpeningMissing =>
      'The reference opening no longer exists.';

  @override
  String get closeRoomFailed =>
      'The space could not be closed. Review the traced points.';

  @override
  String get connectOpeningFailed =>
      'The space could not be connected to the selected opening.';

  @override
  String get initializingApplication => 'Starting ARchScan…';

  @override
  String get applicationInitializationFailed =>
      'The application could not start';

  @override
  String get applicationInitializationFailedDetails =>
      'Check your connection and try again. Your saved projects remain protected.';

  @override
  String get retryApplicationStart => 'Retry startup';

  @override
  String get arInitializationFailedTitle => 'AR could not start';

  @override
  String get arInitializationFailedMessage =>
      'The augmented reality session did not respond in time. You can retry or continue with the basic scanner using the camera.';

  @override
  String get retryArScanner => 'Retry augmented reality';

  @override
  String get useBasicScanner => 'Continue with the basic scanner';

  @override
  String get privacyAndAccount => 'Privacy and data';

  @override
  String get privacyAndData => 'Privacy and data';

  @override
  String get privacyOverview => 'Privacy overview';

  @override
  String get privacyOverviewLocalDescription =>
      'ARchScan works without an account and keeps your projects on the device. It does not synchronize surveys with external servers.';

  @override
  String get localDataTitle => 'Data stored on the device';

  @override
  String get localDataDescription =>
      'Projects, interrupted scans, and preferences are stored locally so the application can work without a connection.';

  @override
  String get localOnlyDataDescription =>
      'Projects, room names, geometry, measurements, and preferences remain in ARchScan\'s private storage on this device.';

  @override
  String get cameraAndSensorsTitle => 'Camera and sensors';

  @override
  String get cameraAndSensorsDescription =>
      'The camera and sensors are used while you measure. ARchScan does not store or transmit photographs, videos, geographic location, or raw sensor readings.';

  @override
  String get exportsAndSharingTitle => 'Exports and files';

  @override
  String get exportsAndSharingDescription =>
      'JSON and PDF files are created or shared only when you choose an export or import action.';

  @override
  String get trackingTitle => 'Tracking and advertising';

  @override
  String get trackingDescription =>
      'ARchScan contains no advertising, creates no advertising profiles, and does not track you across applications or websites.';

  @override
  String get deleteLocalDataTitle => 'Delete projects from this device';

  @override
  String get deleteLocalDataDescription =>
      'Permanently deletes all projects stored by ARchScan on this device. Exported JSON and PDF files are not modified.';

  @override
  String get deleteAllLocalData => 'Delete all local projects';

  @override
  String get deleteLocalDataConfirmationTitle => 'Delete all local projects?';

  @override
  String get deleteLocalDataConfirmationMessage =>
      'This action will permanently delete the projects stored by ARchScan on this device and cannot be undone. Exported JSON, PDF, or DXF files will remain where you saved them.';

  @override
  String get deleteLocalDataPermanently => 'Delete permanently';

  @override
  String get deletingLocalData => 'Deleting projects…';

  @override
  String get localDataDeleted => 'Local projects were deleted successfully.';

  @override
  String get cameraPermissionDenied =>
      'Camera permission was not granted. Enable it in system settings to scan.';

  @override
  String get planImportInvalid =>
      'The file does not contain a compatible project, and no changes were made.';

  @override
  String get openingHeightPositive => 'Enter a height greater than zero.';

  @override
  String get windowSillHeight => 'Window sill height';

  @override
  String get openingSillNonNegative =>
      'Enter a sill height of zero or greater.';

  @override
  String get moveOpeningOnWall => 'Move along a wall';

  @override
  String get roomsArrangementUnchanged =>
      'The floor plan layout was not changed.';

  @override
  String get exportDxf => 'Save 2D DXF to Files (feet and inches)';

  @override
  String get dxfExportFailed =>
      'The DXF file could not be exported. Your project was not changed.';

  @override
  String get fileSaveFailed =>
      'The file could not be saved outside ARchScan. Your project was not changed.';

  @override
  String get planTapWall => 'Tap a wall to place the opening.';

  @override
  String get planSelectWall => 'Tap a wall or a corner to edit it on the plan.';

  @override
  String get planChooseRoom =>
      'This wall belongs to multiple rooms. Choose which one to edit.';

  @override
  String get planConnectionBlocked =>
      'This change would displace a connected opening. Move the room group or remove the connection first.';

  @override
  String get planOverlapBlocked =>
      'This change overlaps another room. The previous plan was preserved.';

  @override
  String get planNoClosure =>
      'No valid nearby closure with a complete wall path was found. Move the endpoint and try again.';

  @override
  String get planStaleEdit =>
      'The plan changed during editing. Select the wall again.';

  @override
  String get planInvalidGeometry =>
      'The change creates crossings, walls that are too short, or openings outside their wall. It was not applied.';

  @override
  String get planClosePreview =>
      'Review the highlighted path: it connects to the nearest point or wall that allows closure without crossings or overlaps.';

  @override
  String get planDeletePreview =>
      'The selected wall and its openings will be removed. The contour will stay open. An already open contour may split into separate paths. Neighbouring openings will remain, disconnected. You can undo this operation.';

  @override
  String get planMeasurePreview =>
      'Review the highlighted wall and its openings before confirming the measurement.';

  @override
  String get planConfirm => 'Confirm change';

  @override
  String get planCorner => 'Corner';

  @override
  String get planDragSelection =>
      'Drag the selection to move it. Tap another point to change the selection.';

  @override
  String get planDeleteWall => 'Delete wall';

  @override
  String get planAddDoor => 'Add door';

  @override
  String get planAddWindow => 'Add window';

  @override
  String get planUndo => 'Undo';

  @override
  String get planRedo => 'Redo';

  @override
  String get planInvalidLength =>
      'Enter a valid length of at least 0.05 meters. Inches must be between 0 and less than 12.';

  @override
  String get planLengthAnchor =>
      'This wall\'s first corner stays fixed; the next corner is adjusted. You will see a preview before saving.';

  @override
  String get planPreview => 'Preview on plan';

  @override
  String get planOpenContour => 'Open contour';

  @override
  String get planDeleteRoom => 'Delete room';

  @override
  String planDeleteRoomConfirmation(String roomName) {
    return 'Delete “$roomName” and all its walls and openings? Connections to other rooms will be removed, without deleting those rooms. You can undo this change during this session.';
  }

  @override
  String get planRoomDeleted => 'Room deleted. You can undo this change.';

  @override
  String get openingsAddedFromPlan =>
      'Finish measuring the room, then add doors and windows by touching its walls in the plan.';

  @override
  String get markPreviousVertex => 'Mark previous vertex';

  @override
  String get markStartVertex => 'Mark starting vertex';

  @override
  String get pointPreviousVertexInstruction =>
      'Aim at the previous contour vertex and confirm it.';

  @override
  String get pointStartVertexInstruction =>
      'Aim at the vertex where you will continue and confirm it.';

  @override
  String get vertexReferenceAligned =>
      'Room orientation aligned. You can continue scanning.';

  @override
  String get continueFromSelectedVertexTitle => 'Continue from this vertex?';

  @override
  String get continueFromSelectedVertexBody =>
      'The highlighted vertex will be the start. In AR you will first mark the previous vertex and then this point to preserve the wall orientation.';

  @override
  String get areaSummaryTitle => 'Project areas';

  @override
  String get totalAreaLabel => 'Total area';

  @override
  String get validationTooCloseToPreviousPoint =>
      'The point is too close to the previous point.';

  @override
  String get validationDuplicatePoint =>
      'This point is too close to an existing corner.';

  @override
  String get validationSelfIntersection =>
      'The change would create a crossing in the plan.';

  @override
  String get validationInsufficientCorners =>
      'At least 3 corners are required.';

  @override
  String get validationInsufficientArea => 'The room area is too small.';

  @override
  String get validationInvalidGeometry => 'The geometry is not valid.';

  @override
  String get measurementEditorTitle => 'Edit measurements';

  @override
  String get noRoomsToEditMessage => 'There are no spaces to edit.';

  @override
  String get measurementEditorEmptyHint =>
      'First complete and save a space from the Scanner.';

  @override
  String get wallsSection => 'Walls';

  @override
  String get selectWallToEdit =>
      'Select a wall to correct its length. The wall\'s current direction is preserved automatically.';

  @override
  String get areaLabel => 'Area';

  @override
  String get perimeterLabel => 'Perimeter';

  @override
  String get cornersLabel => 'Corners';

  @override
  String wallNumber(Object number) {
    return 'Wall $number';
  }

  @override
  String cornerRange(Object end, Object start) {
    return 'Corner $start → Corner $end';
  }

  @override
  String editWallTitle(Object number) {
    return 'Edit wall $number';
  }

  @override
  String currentMeasurement(Object value) {
    return 'Current measurement: $value';
  }

  @override
  String get newLength => 'New length';

  @override
  String get lengthExample => 'Example: 3.25';

  @override
  String get wallLengthChangeNotice =>
      'The new measurement changes the actual geometry of the space. The plan will be validated before saving the change.';

  @override
  String get invalidNumber => 'Enter a valid number.';

  @override
  String get positiveLengthRequired => 'The length must be greater than 0.';

  @override
  String get measurementUpdated => 'Measurement updated successfully.';

  @override
  String get invalidNewMeasurement => 'The new measurement is not valid.';

  @override
  String get validAngleRequired => 'Enter a valid angle';

  @override
  String get directionFront => '↑ Front · 0°';

  @override
  String get directionRightPreview => '→ Right · 90°';

  @override
  String get directionBack => '↓ Back · 180°';

  @override
  String get directionLeftPreview => '← Left · 270°';

  @override
  String customDirection(Object angle) {
    return 'Custom direction · $angle°';
  }

  @override
  String get referenceOpeningConnected =>
      'The opening is already connected to another space.';

  @override
  String get needThreeCornersToCloseMessage =>
      'You need at least 3 corners to close the space.';

  @override
  String get closeRoomFailedFallback => 'The space could not be closed.';

  @override
  String get saveRoomFailed =>
      'The space could not be saved. Review overlaps and try again.';

  @override
  String get scanErrorNoActiveRoom => 'No active room.';

  @override
  String get scanErrorNeedWallBeforeOpening =>
      'Measure at least one wall before adding an opening.';

  @override
  String get scanErrorInvalidOpeningHeights =>
      'The height must be positive and the sill height cannot be negative.';

  @override
  String scanErrorOpeningTooNarrow(String minWidth) {
    return 'Enter a minimum width of $minWidth.';
  }

  @override
  String get scanErrorInvalidWallIndex => 'The selected wall is not valid.';

  @override
  String get scanErrorNoValidWall => 'No valid wall was found.';

  @override
  String scanErrorEndpointsTooClose(String measuredWidth) {
    return 'The two opening points are too close. Measured: $measuredWidth.';
  }

  @override
  String scanErrorOpeningExceedsWall(String openingWidth, String wallLength) {
    return 'The opening measures $openingWidth, but the wall measures $wallLength.';
  }

  @override
  String get scanErrorOpeningOverlaps =>
      'The opening overlaps with another door or window. Choose a different position on the wall.';

  @override
  String get scanErrorCloseSelfIntersection =>
      'The contour self-intersects. Review the traced walls.';

  @override
  String get defaultProjectName => 'My Complete Home';

  @override
  String scanWarningOpeningMeasured(String measuredWidth) {
    return 'Opening measured: $measuredWidth.';
  }
}
