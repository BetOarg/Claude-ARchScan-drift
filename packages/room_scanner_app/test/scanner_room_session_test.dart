import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:room_scanner_ar/services/scan_draft_service.dart';
import 'package:room_scanner_core/room_scanner_core.dart';

import 'support/scanner_session_harness.dart';

// The saved-room flow also clears the draft, so it lives in
// scanner_room_session_close_test.dart (see scanner_session_harness.dart).
void main() {
  setUpSessionPreferences();

  group('restoreOrStartScanRoom', () {
    testWidgets('continues an open room without starting a new one',
        (tester) async {
      final providers = SessionProviders();
      final host = await pumpSessionHost(
        tester,
        providers,
        resumeRoom: openRoom('resume'),
      );

      await host.restoreOrStartScanRoom(providers.scanner);

      expect(providers.scanner.currentRoom?.id, 'resume');
      expect(host.startedRooms, 0);
      expect(host.restoredHistories, [isEmpty]);
    });

    testWidgets('starts a new room when there is no draft', (tester) async {
      final providers = SessionProviders();
      final host = await pumpSessionHost(tester, providers);

      await host.restoreOrStartScanRoom(providers.scanner);

      expect(host.startedRooms, 1);
      expect(host.restoredHistories, isEmpty);
    });

    testWidgets('restores a draft and its Basic history when continued',
        (tester) async {
      final providers = SessionProviders();
      seedDraft(
        ScanDraft(
          room: openRoom('draft'),
          continuationReference: null,
          basicHistory: [ARPoint(x: 1, y: 0, z: 1)],
        ),
      );
      final host = await pumpSessionHost(tester, providers);

      final restoring =
          TrackedFlow(host.restoreOrStartScanRoom(providers.scanner));
      await tester.pumpAndSettle();
      await tester.tap(find.text(sessionL10n(tester).continueScan));
      await tester.pumpAndSettle();

      expect(restoring.isDone, isTrue, reason: 'restore flow did not finish');
      expect(providers.scanner.currentRoom?.id, 'draft');
      expect(host.startedRooms, 0);
      expect(host.restoredHistories.single.single.x, 1);
    });

    testWidgets('discarding a draft deletes it and starts a new room',
        (tester) async {
      final providers = SessionProviders();
      seedDraft(
          ScanDraft(room: openRoom('draft'), continuationReference: null));
      final host = await pumpSessionHost(tester, providers);

      final restoring =
          TrackedFlow(host.restoreOrStartScanRoom(providers.scanner));
      await tester.pumpAndSettle();
      await tester.tap(find.text(sessionL10n(tester).discardScan));
      await tester.pumpAndSettle();

      expect(restoring.isDone, isTrue, reason: 'restore flow did not finish');
      expect(host.startedRooms, 1);
      expect(await storedDraft(), isNull);
    });
  });

  group('closeScanRoom', () {
    testWidgets('rejects fewer than three corners before asking for a name',
        (tester) async {
      final providers = SessionProviders();
      providers.scanner.restoreCurrentRoom(openRoom('short', corners: 2));
      final host = await pumpSessionHost(tester, providers);

      await host.closeScanRoom(providers.scanner);
      await tester.pumpAndSettle();

      expect(
        host.errors,
        [sessionL10n(tester).needThreeCornersToCloseMessage],
      );
      expect(find.byType(AlertDialog), findsNothing);
      expect(providers.floorPlan.completedRooms, isEmpty);
    });

    testWidgets('reports a save failure and keeps the room open',
        (tester) async {
      final providers = SessionProviders();
      providers.floorPlan.persister = ({
        required String uuid,
        required String name,
        required List<RoomModel> rooms,
      }) async {
        throw StateError('disk full');
      };
      providers.scanner.restoreCurrentRoom(openRoom('failing'));
      final host = await pumpSessionHost(tester, providers);

      final closing = TrackedFlow(host.closeScanRoom(providers.scanner));
      await tester.pumpAndSettle();
      await tester.tap(
        find.widgetWithText(FilledButton, sessionL10n(tester).save),
      );
      await tester.pumpAndSettle();

      expect(closing.isDone, isTrue, reason: 'close flow did not finish');
      expect(host.errors, [sessionL10n(tester).saveRoomFailed]);
      expect(providers.scanner.currentRoom?.id, 'failing');
      expect(providers.scanner.currentRoom?.isClosed, isFalse);
      expect(providers.floorPlan.completedRooms, isEmpty);
    });
  });
}
