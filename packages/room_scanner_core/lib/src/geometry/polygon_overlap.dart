import '../models/room_model.dart';

/// Interior-overlap geometry used when arranging and aligning rooms on the
/// plan (XZ floor plane).
///
/// Rooms that only touch along a wall or at a corner do not overlap. This is
/// deliberately looser at the boundary than `PlanEditGeometry.overlaps`
/// (points within 1 mm of an edge count as outside, instead of 0.01 mm) and,
/// unlike `ScanValidator`'s self-intersection check, never treats touching
/// segments as crossing.
class PolygonOverlap {
  /// Squared distance (1 mm) within which a point counts as on the boundary.
  static const double _boundaryToleranceSquared = 0.000001;

  /// Minimum cross-product magnitude for two segments to cross properly.
  static const double _crossingTolerance = 0.000001;

  /// Whether the interiors of two closed polygons overlap.
  ///
  /// Polygons with fewer than three corners never overlap.
  static bool interiorsOverlap(List<ARPoint> first, List<ARPoint> second) {
    if (first.length < 3 || second.length < 3) {
      return false;
    }

    for (var firstIndex = 0; firstIndex < first.length; firstIndex++) {
      final firstStart = first[firstIndex];
      final firstEnd = first[(firstIndex + 1) % first.length];
      for (var secondIndex = 0; secondIndex < second.length; secondIndex++) {
        final secondStart = second[secondIndex];
        final secondEnd = second[(secondIndex + 1) % second.length];
        if (_segmentsCrossProperly(
          firstStart,
          firstEnd,
          secondStart,
          secondEnd,
        )) {
          return true;
        }
      }
    }

    if (first.any((point) => strictlyInside(point, second)) ||
        second.any((point) => strictlyInside(point, first))) {
      return true;
    }

    if (_anyEdgeMidpointInside(first, second) ||
        _anyEdgeMidpointInside(second, first)) {
      return true;
    }

    return strictlyInside(centroid(first), second) ||
        strictlyInside(centroid(second), first);
  }

  /// Whether [point] lies inside [polygon] and not on its boundary.
  static bool strictlyInside(ARPoint point, List<ARPoint> polygon) {
    var inside = false;
    for (var index = 0; index < polygon.length; index++) {
      final start = polygon[index];
      final end = polygon[(index + 1) % polygon.length];
      if (distanceSquaredToSegment(point, start, end) <=
          _boundaryToleranceSquared) {
        return false;
      }
      final crossesRay = (start.z > point.z) != (end.z > point.z);
      if (!crossesRay) {
        continue;
      }
      final crossingX =
          start.x + (point.z - start.z) * (end.x - start.x) / (end.z - start.z);
      if (crossingX > point.x) {
        inside = !inside;
      }
    }
    return inside;
  }

  /// Average of the corners on the floor plane (`y` is 0).
  static ARPoint centroid(List<ARPoint> points) {
    final totalX = points.fold<double>(0.0, (sum, point) => sum + point.x);
    final totalZ = points.fold<double>(0.0, (sum, point) => sum + point.z);
    return ARPoint(
      x: totalX / points.length,
      y: 0.0,
      z: totalZ / points.length,
    );
  }

  /// Squared floor-plane distance from [point] to the segment [start]-[end].
  ///
  /// Degenerate segments (shorter than 1 mm) are measured from [start].
  static double distanceSquaredToSegment(
    ARPoint point,
    ARPoint start,
    ARPoint end,
  ) {
    final dx = end.x - start.x;
    final dz = end.z - start.z;
    final lengthSquared = dx * dx + dz * dz;
    if (lengthSquared <= 0.000001) {
      final pointDx = point.x - start.x;
      final pointDz = point.z - start.z;
      return pointDx * pointDx + pointDz * pointDz;
    }
    final projection =
        (((point.x - start.x) * dx + (point.z - start.z) * dz) / lengthSquared)
            .clamp(0.0, 1.0)
            .toDouble();
    final projectedX = start.x + dx * projection;
    final projectedZ = start.z + dz * projection;
    final distanceX = point.x - projectedX;
    final distanceZ = point.z - projectedZ;
    return distanceX * distanceX + distanceZ * distanceZ;
  }

  static bool _anyEdgeMidpointInside(
    List<ARPoint> edges,
    List<ARPoint> polygon,
  ) {
    for (var index = 0; index < edges.length; index++) {
      final start = edges[index];
      final end = edges[(index + 1) % edges.length];
      final midpoint = ARPoint(
        x: (start.x + end.x) / 2,
        y: (start.y + end.y) / 2,
        z: (start.z + end.z) / 2,
      );
      if (strictlyInside(midpoint, polygon)) {
        return true;
      }
    }
    return false;
  }

  static bool _segmentsCrossProperly(
    ARPoint firstStart,
    ARPoint firstEnd,
    ARPoint secondStart,
    ARPoint secondEnd,
  ) {
    final firstSideStart = _cross(firstStart, firstEnd, secondStart);
    final firstSideEnd = _cross(firstStart, firstEnd, secondEnd);
    final secondSideStart = _cross(secondStart, secondEnd, firstStart);
    final secondSideEnd = _cross(secondStart, secondEnd, firstEnd);
    return firstSideStart * firstSideEnd < -_crossingTolerance &&
        secondSideStart * secondSideEnd < -_crossingTolerance;
  }

  static double _cross(ARPoint start, ARPoint end, ARPoint point) {
    return (end.x - start.x) * (point.z - start.z) -
        (end.z - start.z) * (point.x - start.x);
  }
}
