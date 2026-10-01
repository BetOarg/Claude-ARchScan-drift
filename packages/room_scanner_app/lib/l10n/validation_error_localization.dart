import 'package:room_scanner_core/room_scanner_core.dart';

import '../l10n/generated/app_localizations.dart';

String validationErrorMessage(
  ValidationResult result,
  AppLocalizations l10n, {
  required String fallback,
}) {
  final data = result.errorData;
  switch (result.errorCode) {
    case ValidationErrorCode.tooCloseToPreviousPoint:
      return l10n.validationTooCloseToPreviousPoint;
    case ValidationErrorCode.duplicatePoint:
      return l10n.validationDuplicatePoint;
    case ValidationErrorCode.selfIntersection:
      return l10n.validationSelfIntersection;
    case ValidationErrorCode.insufficientCorners:
      return l10n.validationInsufficientCorners;
    case ValidationErrorCode.insufficientArea:
      return l10n.validationInsufficientArea;
    case ValidationErrorCode.invalidGeometry:
      return l10n.validationInvalidGeometry;
    case ValidationErrorCode.noActiveRoom:
      return l10n.scanErrorNoActiveRoom;
    case ValidationErrorCode.needWallBeforeOpening:
      return l10n.scanErrorNeedWallBeforeOpening;
    case ValidationErrorCode.invalidOpeningHeights:
      return l10n.scanErrorInvalidOpeningHeights;
    case ValidationErrorCode.openingTooNarrow:
      return l10n.scanErrorOpeningTooNarrow(data['minWidth'] ?? '0.20 m');
    case ValidationErrorCode.invalidWallIndex:
      return l10n.scanErrorInvalidWallIndex;
    case ValidationErrorCode.noValidWall:
      return l10n.scanErrorNoValidWall;
    case ValidationErrorCode.endpointsTooClose:
      return l10n.scanErrorEndpointsTooClose(data['measuredWidth'] ?? '');
    case ValidationErrorCode.openingExceedsWall:
      return l10n.scanErrorOpeningExceedsWall(
        data['openingWidth'] ?? '',
        data['wallLength'] ?? '',
      );
    case ValidationErrorCode.openingOverlaps:
      return l10n.scanErrorOpeningOverlaps;
    case ValidationErrorCode.closeSelfIntersection:
      return l10n.scanErrorCloseSelfIntersection;
    case ValidationErrorCode.roomNotFound:
      return l10n.planErrorRoomNotFound;
    case ValidationErrorCode.invalidMeasurement:
      return l10n.planErrorInvalidMeasurement;
    case ValidationErrorCode.editCausesConflict:
      return l10n.planErrorEditCausesConflict;
    case ValidationErrorCode.openingWidthTooSmall:
      return l10n.openingGeomWidthTooSmall;
    case ValidationErrorCode.negativeDistanceFromCorner:
      return l10n.openingGeomNegativeDistance;
    case ValidationErrorCode.openingHeightTooSmall:
      return l10n.openingGeomHeightTooSmall;
    case ValidationErrorCode.negativeSillHeight:
      return l10n.openingGeomNegativeSillHeight;
    case ValidationErrorCode.roomNotAvailable:
      return l10n.openingGeomRoomNotAvailable;
    case ValidationErrorCode.openingNotAvailable:
      return l10n.openingGeomOpeningNotAvailable;
    case ValidationErrorCode.wallNotIdentified:
      return l10n.openingGeomWallNotIdentified;
    case ValidationErrorCode.openingExceedsWallLength:
      return l10n.openingGeomExceedsWall(data['wallLength'] ?? '');
    case ValidationErrorCode.openingOverlapsExisting:
      return l10n.openingGeomOverlaps;
    case ValidationErrorCode.openingUpdateFailed:
      return l10n.openingGeomUpdateFailed;
    case ValidationErrorCode.invalidWallOrMeasurements:
      return l10n.openingGeomInvalidWallOrMeasurements;
    case ValidationErrorCode.connectedOpeningMustBeOnWall:
      return l10n.openingGeomConnectedMustBeOnWall;
    case null:
      return fallback;
  }
}

/// Localized warning text for a successful [ValidationResult] that carries an
/// opening measurement.
String? validationWarningMessage(
  ValidationResult result,
  AppLocalizations l10n,
) {
  final w = result.errorData['measuredWidth'];
  if (w != null) return l10n.scanWarningOpeningMeasured(w);
  return result.warningMessage;
}

String openingGeometryErrorMessage(
  ValidationErrorCode? code,
  Map<String, String> data,
  AppLocalizations l10n, {
  required String fallback,
}) {
  switch (code) {
    case ValidationErrorCode.openingWidthTooSmall:
      return l10n.openingGeomWidthTooSmall;
    case ValidationErrorCode.negativeDistanceFromCorner:
      return l10n.openingGeomNegativeDistance;
    case ValidationErrorCode.openingHeightTooSmall:
      return l10n.openingGeomHeightTooSmall;
    case ValidationErrorCode.negativeSillHeight:
      return l10n.openingGeomNegativeSillHeight;
    case ValidationErrorCode.roomNotAvailable:
      return l10n.openingGeomRoomNotAvailable;
    case ValidationErrorCode.openingNotAvailable:
      return l10n.openingGeomOpeningNotAvailable;
    case ValidationErrorCode.wallNotIdentified:
      return l10n.openingGeomWallNotIdentified;
    case ValidationErrorCode.openingExceedsWallLength:
      return l10n.openingGeomExceedsWall(data['wallLength'] ?? '');
    case ValidationErrorCode.openingOverlapsExisting:
      return l10n.openingGeomOverlaps;
    case ValidationErrorCode.openingUpdateFailed:
      return l10n.openingGeomUpdateFailed;
    case ValidationErrorCode.invalidWallOrMeasurements:
      return l10n.openingGeomInvalidWallOrMeasurements;
    case ValidationErrorCode.connectedOpeningMustBeOnWall:
      return l10n.openingGeomConnectedMustBeOnWall;
    default:
      return fallback;
  }
}
