import 'package:flutter_test/flutter_test.dart';
import 'package:room_scanner_ar/scanner/adapters/basic_scanner_adapter.dart';
import 'package:room_scanner_ar/scanner/models/scanner_point.dart';

void main() {
  late BasicScannerAdapter adapter;

  setUp(() async {
    adapter = BasicScannerAdapter();
    await adapter.initialize();
  });

  tearDown(() async {
    await adapter.dispose();
  });

  test('starts initialized and tracking after initialize()', () {
    expect(adapter.isAvailable, isTrue);
    expect(adapter.isTracking, isTrue);
    expect(adapter.capturedPoints, 0);
  });

  test('first preview returns the origin', () {
    final point = adapter.previewNextPoint();
    expect(point, isNotNull);
    expect(point!.x, 0.0);
    expect(point.z, 0.0);
  });

  test('commit advances position and history', () {
    final origin = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(origin);

    expect(adapter.capturedPoints, 1);
    expect(adapter.currentX, 0.0);
    expect(adapter.currentZ, 0.0);
  });

  test('setNextMeasurement and preview compute correct position', () {
    final origin = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(origin);

    adapter.setNextMeasurement(distanceMeters: 2.0, angleDegrees: 90);
    final next = adapter.previewNextPoint()!;

    expect(next.x, closeTo(2.0, 0.001));
    expect(next.z, closeTo(0.0, 0.001));
  });

  test('90-degree direction moves along +X', () {
    final origin = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(origin);

    adapter.setNextMeasurement(distanceMeters: 1.0, angleDegrees: 90);
    final point = adapter.previewNextPoint()!;

    expect(point.x, closeTo(1.0, 0.001));
    expect(point.z, closeTo(0.0, 0.001));
  });

  test('0-degree direction moves along -Z', () {
    final origin = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(origin);

    adapter.setNextMeasurement(distanceMeters: 1.0, angleDegrees: 0);
    final point = adapter.previewNextPoint()!;

    expect(point.x, closeTo(0.0, 0.001));
    expect(point.z, closeTo(-1.0, 0.001));
  });

  test('capturePoint commits automatically', () async {
    final origin = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(origin);

    adapter.setNextMeasurement(distanceMeters: 3.0, angleDegrees: 180);
    final captured = await adapter.capturePoint();

    expect(captured, isNotNull);
    expect(adapter.capturedPoints, 2);
    expect(adapter.currentZ, closeTo(3.0, 0.001));
  });

  test('removeLastPoint rolls back position', () {
    final origin = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(origin);

    adapter.setNextMeasurement(distanceMeters: 2.0, angleDegrees: 90);
    final second = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(second);

    expect(adapter.capturedPoints, 2);
    adapter.removeLastPoint();
    expect(adapter.capturedPoints, 1);
    expect(adapter.currentX, 0.0);
    expect(adapter.currentZ, 0.0);
  });

  test('removeLastPoint on empty history is a no-op', () {
    adapter.removeLastPoint();
    expect(adapter.capturedPoints, 0);
  });

  test('reset clears all state', () {
    final origin = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(origin);
    adapter.reset();

    expect(adapter.capturedPoints, 0);
    expect(adapter.currentX, 0.0);
    expect(adapter.currentZ, 0.0);
  });

  test('seedPath sets position to last seeded point', () {
    const p1 = ScannerPoint(x: 1, y: 0, z: 2, accuracy: 0, source: PointSource.camera);
    const p2 = ScannerPoint(x: 3, y: 0, z: 4, accuracy: 0, source: PointSource.camera);
    adapter.seedPath([p1, p2]);

    expect(adapter.capturedPoints, 2);
    expect(adapter.currentX, 3.0);
    expect(adapter.currentZ, 4.0);
  });

  test('captureInitialPoint resets and commits origin', () {
    adapter.setNextMeasurement(distanceMeters: 5.0, angleDegrees: 45);
    final origin = adapter.captureInitialPoint();

    expect(origin.x, 0.0);
    expect(origin.z, 0.0);
    expect(adapter.capturedPoints, 1);
  });

  test('setNextMeasurement rejects non-positive distance', () {
    expect(
      () => adapter.setNextMeasurement(distanceMeters: 0, angleDegrees: 0),
      throwsArgumentError,
    );
    expect(
      () => adapter.setNextMeasurement(distanceMeters: -1, angleDegrees: 0),
      throwsArgumentError,
    );
  });

  test('setNextMeasurement rejects non-finite angle', () {
    expect(
      () => adapter.setNextMeasurement(
        distanceMeters: 1,
        angleDegrees: double.nan,
      ),
      throwsArgumentError,
    );
  });

  test('cancelPendingMeasurement clears pending without changing history', () {
    final origin = adapter.previewNextPoint()!;
    adapter.commitPendingPoint(origin);

    adapter.setNextMeasurement(distanceMeters: 2.0, angleDegrees: 90);
    adapter.cancelPendingMeasurement();

    expect(adapter.previewNextPoint(), isNull);
    expect(adapter.capturedPoints, 1);
  });

  test('dispose makes adapter non-tracking', () async {
    await adapter.dispose();
    expect(adapter.isTracking, isFalse);
  });
}
