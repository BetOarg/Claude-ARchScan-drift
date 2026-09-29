import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:room_scanner_ar/services/scan_draft_service.dart';

import 'support/scanner_session_harness.dart';

// Kept apart from scanner_room_session_test.dart because it clears the draft
// through ScanDraftService (see scanner_session_harness.dart).
void main() {
  setUpSessionPreferences();

  testWidgets('closeScanRoom saves the closed room and clears the draft',
      (tester) async {
    final providers = SessionProviders();
    seedDraft(ScanDraft(room: openRoom('saved'), continuationReference: null));
    providers.scanner.restoreCurrentRoom(openRoom('saved'));
    final host = await pumpSessionHost(tester, providers);

    final closing = TrackedFlow(host.closeScanRoom(providers.scanner));
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(FilledButton, sessionL10n(tester).save),
    );
    await tester.pumpAndSettle();

    expect(host.errors, isEmpty);
    expect(providers.floorPlan.completedRooms.single.id, 'saved');
    expect(providers.floorPlan.completedRooms.single.isClosed, isTrue);
    expect(await storedDraft(), isNull);

    // The flow ends on the (non-dismissible) completion dialog, which then
    // navigates to the floor plan; reaching it is the expected end state.
    expect(find.text(sessionL10n(tester).spaceSaved), findsOneWidget);
    expect(closing.isDone, isFalse);
  });
}
