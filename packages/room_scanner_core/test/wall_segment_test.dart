import 'package:room_scanner_core/room_scanner_core.dart';
import 'package:test/test.dart';

ARPoint p(double x, double z, [double y = 0]) => ARPoint(x: x, y: y, z: z);

WallFeature opening(String id, double from, double to) => WallFeature(
      id: id,
      type: FeatureType.door,
      start: p(from, 0),
      end: p(to, 0),
    );

void main() {
  // 5 m wall along +X.
  final wall = WallSegment.between(p(0, 0), p(5, 0))!;

  test('rejects degenerate walls', () {
    expect(WallSegment.between(p(1, 1), p(1, 1.0005)), isNull);
    expect(wall.length, closeTo(5, 1e-12));
  });

  test('projects with and without clamping', () {
    expect(wall.rawFraction(p(-1, 3)), closeTo(-0.2, 1e-12));
    expect(wall.fraction(p(-1, 3)), 0);
    expect(wall.fraction(p(2.5, -4)), closeTo(0.5, 1e-12));
    expect(wall.fraction(p(9, 0)), 1);
  });

  test('interpolates height along the wall', () {
    final sloped = WallSegment.between(p(0, 0, 0), p(4, 0, 2))!;
    final middle = sloped.pointAt(0.5);
    expect(middle.x, 2);
    expect(middle.y, 1);
  });

  test('measures distance to the closest wall point', () {
    expect(wall.distanceSquaredTo(p(2, 3)), closeTo(9, 1e-12));
    expect(wall.distanceSquaredTo(p(7, 0)), closeTo(4, 1e-12));
  });

  test('contains points within 5 cm and 1 % past either end', () {
    expect(wall.contains(p(2, 0.049)), isTrue);
    expect(wall.contains(p(2, 0.051)), isFalse);
    expect(wall.contains(p(5.04, 0)), isTrue);
    expect(wall.contains(p(5.06, 0)), isFalse);
  });

  test('reports the sorted span of an opening on the wall', () {
    final reversed = WallFeature(
      id: 'w',
      type: FeatureType.window,
      start: p(3, 0),
      end: p(2, 0),
    );
    expect(wall.featureSpan(reversed), (2.0, 3.0));
    expect(wall.featureSpan(opening('off', 1, 2).copyWith(start: p(1, 1))),
        isNull);
  });

  group('overlapsOpening', () {
    final existing = [opening('a', 1, 2)];

    test('detects overlaps beyond the separation in metres', () {
      // 10 cm overlap on a 5 m wall.
      expect(
        wall.overlapsOpening(1.9, 2.9, existing, separationMeters: 0.02),
        isTrue,
      );
    });

    test('allows touching or overlapping within the separation', () {
      expect(
        wall.overlapsOpening(2.0, 3.0, existing, separationMeters: 0.02),
        isFalse,
      );
      expect(
        wall.overlapsOpening(1.99, 3.0, existing, separationMeters: 0.02),
        isFalse,
      );
    });

    test('ignores the edited opening and openings on other walls', () {
      expect(
        wall.overlapsOpening(
          1.5,
          2.5,
          existing,
          separationMeters: 0,
          ignoreFeatureId: 'a',
        ),
        isFalse,
      );
      final elsewhere = [
        opening('b', 1, 2).copyWith(start: p(1, 2), end: p(2, 2)),
      ];
      expect(
        wall.overlapsOpening(1, 2, elsewhere, separationMeters: 0),
        isFalse,
      );
    });
  });

  test('centres an opening and keeps it inside the wall', () {
    expect(wall.centredOpeningStart(p(2.5, 1), 1), closeTo(2, 1e-12));
    expect(wall.centredOpeningStart(p(0.1, 0), 1), 0);
    expect(wall.centredOpeningStart(p(4.9, 0), 1), closeTo(4, 1e-12));
    expect(wall.centredOpeningStart(p(2.5, 0), 5.01), isNull);
  });

  group('nearestWallIndex', () {
    final square = [p(0, 0), p(4, 0), p(4, 3), p(0, 3)];

    test('finds the closest wall including the closing edge', () {
      expect(WallSegment.nearestWallIndex(square, 4, p(2, -0.5)), 0);
      expect(WallSegment.nearestWallIndex(square, 4, p(4.2, 1.5)), 1);
      expect(WallSegment.nearestWallIndex(square, 4, p(-0.3, 1.5)), 3);
    });

    test('only considers the first wallCount walls', () {
      expect(WallSegment.nearestWallIndex(square, 3, p(-0.3, 1.5)), 0);
    });

    test('skips degenerate walls and reports none when all are', () {
      final collapsed = [p(1, 1), p(1, 1), p(3, 1)];
      expect(WallSegment.nearestWallIndex(collapsed, 2, p(2, 0)), 1);
      expect(WallSegment.nearestWallIndex([p(1, 1), p(1, 1)], 1, p(0, 0)), -1);
    });
  });
}
