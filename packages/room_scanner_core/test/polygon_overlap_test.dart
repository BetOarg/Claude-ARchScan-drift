import 'package:room_scanner_core/room_scanner_core.dart';
import 'package:test/test.dart';

ARPoint p(double x, double z) => ARPoint(x: x, y: 0, z: z);

List<ARPoint> rect(double x0, double z0, double x1, double z1) =>
    [p(x0, z0), p(x1, z0), p(x1, z1), p(x0, z1)];

void main() {
  group('interiorsOverlap', () {
    final unit = rect(0, 0, 1, 1);

    test('rooms sharing a wall or a corner do not overlap', () {
      expect(PolygonOverlap.interiorsOverlap(unit, rect(1, 0, 2, 1)), isFalse);
      expect(PolygonOverlap.interiorsOverlap(unit, rect(1, 1, 2, 2)), isFalse);
    });

    test('partial overlap is detected', () {
      expect(
        PolygonOverlap.interiorsOverlap(unit, rect(0.5, 0.5, 1.5, 1.5)),
        isTrue,
      );
    });

    test('a room fully inside another overlaps, in both orders', () {
      final inner = rect(0.25, 0.25, 0.75, 0.75);
      expect(PolygonOverlap.interiorsOverlap(unit, inner), isTrue);
      expect(PolygonOverlap.interiorsOverlap(inner, unit), isTrue);
    });

    test('identical rooms overlap', () {
      expect(PolygonOverlap.interiorsOverlap(unit, rect(0, 0, 1, 1)), isTrue);
    });

    test('crossing rooms with no corner inside the other overlap', () {
      expect(
        PolygonOverlap.interiorsOverlap(
          rect(0, 0.4, 3, 0.6),
          rect(1.4, -1, 1.6, 2),
        ),
        isTrue,
      );
    });

    test('tolerates overlaps within 1 mm but not beyond', () {
      expect(
        PolygonOverlap.interiorsOverlap(unit, rect(0.9995, 0, 2, 1)),
        isFalse,
      );
      expect(
        PolygonOverlap.interiorsOverlap(unit, rect(0.998, 0, 2, 1)),
        isTrue,
      );
    });

    test('polygons with fewer than three corners never overlap', () {
      expect(
        PolygonOverlap.interiorsOverlap(unit, [p(0.5, 0.5), p(0.6, 0.6)]),
        isFalse,
      );
    });
  });

  group('strictlyInside', () {
    final unit = rect(0, 0, 1, 1);

    test('interior points are inside and boundary points are not', () {
      expect(PolygonOverlap.strictlyInside(p(0.5, 0.5), unit), isTrue);
      expect(PolygonOverlap.strictlyInside(p(1, 0.5), unit), isFalse);
      expect(PolygonOverlap.strictlyInside(p(0.9995, 0.5), unit), isFalse);
      expect(PolygonOverlap.strictlyInside(p(1.5, 0.5), unit), isFalse);
    });
  });

  test('centroid averages corners on the floor plane', () {
    final center = PolygonOverlap.centroid([
      ARPoint(x: 0, y: 2, z: 0),
      ARPoint(x: 4, y: 2, z: 0),
      ARPoint(x: 4, y: 2, z: 2),
    ]);
    expect(center.x, closeTo(8 / 3, 1e-12));
    expect(center.y, 0);
    expect(center.z, closeTo(2 / 3, 1e-12));
  });

  test('distanceSquaredToSegment clamps and handles degenerate segments', () {
    expect(
      PolygonOverlap.distanceSquaredToSegment(p(2, 3), p(0, 0), p(4, 0)),
      closeTo(9, 1e-12),
    );
    expect(
      PolygonOverlap.distanceSquaredToSegment(p(6, 0), p(0, 0), p(4, 0)),
      closeTo(4, 1e-12),
    );
    expect(
      PolygonOverlap.distanceSquaredToSegment(p(1, 1), p(0, 0), p(0, 0.0005)),
      closeTo(2, 1e-12),
    );
  });
}
