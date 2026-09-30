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
