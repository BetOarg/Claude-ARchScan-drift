import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:room_scanner_ar/l10n/generated/app_localizations.dart';
import 'package:room_scanner_ar/providers/floor_plan_provider.dart';
import 'package:room_scanner_ar/providers/scanner_provider.dart';
import 'package:room_scanner_ar/scanner/scanner_room_session.dart';
import 'package:room_scanner_ar/services/scan_draft_service.dart';
import 'package:room_scanner_core/room_scanner_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

// ScanDraftService serializes writes through a static future that is bound to
// the zone of the first test using it. A later testWidgets zone never runs
// callbacks scheduled on it, so each test file may exercise draft writes
// (discard or clear) in at most one test. Test files run in separate isolates.

const sessionProjectUuid = 'session-project';
const _draftKey = 'scan_draft_v1_$sessionProjectUuid';

class SessionHost extends StatefulWidget {
  const SessionHost({super.key, this.resumeRoom});

  final RoomModel? resumeRoom;

  @override
  State<SessionHost> createState() => SessionHostState();
}

class SessionHostState extends State<SessionHost>
    with ScannerRoomSession<SessionHost> {
  final List<String> errors = <String>[];
  final List<List<ARPoint>> restoredHistories = <List<ARPoint>>[];
  int startedRooms = 0;

  @override
  void initState() {
    super.initState();
    activeResumeRoom = widget.resumeRoom;
  }

  @override
  String get scanProjectUuid => sessionProjectUuid;

  @override
  void startScanRoom(ScannerProvider provider) {
    startedRooms++;
    provider.startNewRoom();
  }

  @override
  void onScanRoomRestored(RoomModel room, List<ARPoint> history) {
    restoredHistories.add(history);
  }

  @override
  void showScanError(String message) => errors.add(message);

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

/// Providers under test. Create them inside the test body so their futures
/// run in that test's fake-async zone.
class SessionProviders {
  SessionProviders() {
    addTearDown(scanner.dispose);
    addTearDown(floorPlan.dispose);
  }

  final ScannerProvider scanner = ScannerProvider();
  final FloorPlanProvider floorPlan = FloorPlanProvider()
    ..loadProject(uuid: sessionProjectUuid, name: 'Plan', rooms: const []);
}

void setUpSessionPreferences() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final previousPreferences = SharedPreferencesAsyncPlatform.instance;
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    addTearDown(() {
      SharedPreferencesAsyncPlatform.instance = previousPreferences;
    });
  });
}

RoomModel openRoom(String id, {int corners = 4}) {
  const square = <List<double>>[
    [0, 0],
    [4, 0],
    [4, 3],
    [0, 3],
  ];
  return RoomModel(
    id: id,
    name: 'Living',
    type: RoomType.living,
    isClosed: false,
    points: [
      for (final corner in square.take(corners))
        ARPoint(x: corner[0], y: 0, z: corner[1]),
    ],
  );
}

Future<SessionHostState> pumpSessionHost(
  WidgetTester tester,
  SessionProviders providers, {
  RoomModel? resumeRoom,
}) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ScannerProvider>.value(
          value: providers.scanner,
        ),
        ChangeNotifierProvider<FloorPlanProvider>.value(
          value: providers.floorPlan,
        ),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SessionHost(resumeRoom: resumeRoom),
      ),
    ),
  );
  return tester.state<SessionHostState>(find.byType(SessionHost));
}

AppLocalizations sessionL10n(WidgetTester tester) =>
    AppLocalizations.of(tester.element(find.byType(SessionHost)))!;

/// Records completion instead of awaiting, so a flow stuck on an unexpected
/// dialog fails the test rather than hanging it.
class TrackedFlow {
  TrackedFlow(Future<void> flow) {
    flow.then((_) => isDone = true);
  }

  bool isDone = false;
}

/// Stores a draft without going through ScanDraftService (see note above).
void seedDraft(ScanDraft draft) {
  SharedPreferences.setMockInitialValues(<String, Object>{
    _draftKey: jsonEncode(draft.toJson()),
  });
}

Future<String?> storedDraft() async =>
    (await SharedPreferences.getInstance()).getString(_draftKey);
