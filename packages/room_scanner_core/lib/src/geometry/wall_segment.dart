import 'dart:math' as math;

import '../models/room_model.dart';

/// A wall between two consecutive corners, measured on the XZ floor plane.
///
/// Positions along the wall are expressed as fractions `t` in `[0, 1]` from
/// [start] to [end]; [pointAt] interpolates height (`y`) as well.
class WallSegment {
  /// Walls shorter than 1 mm (squared length) are treated as degenerate.
  static const double _minimumLengthSquared = 0.000001;

  /// Maximum distance (5 cm, squared) for a point to count as lying on a wall.
  static const double _onWallDistanceSquared = 0.0025;

  /// How far past either end (as a fraction) a point may still be on a wall.
  static const double _endOvershoot = 0.01;

  final ARPoint start;
  final ARPoint end;
  final double dx;
  final double dz;
  final double lengthSquared;
  final double length;

  const WallSegment._({
    required this.start,
    required this.end,
    required this.dx,
    required this.dz,
    required this.lengthSquared,
    required this.length,
  });

  /// Returns `null` when both corners (nearly) coincide.
  static WallSegment? between(ARPoint start, ARPoint end) {
    final dx = end.x - start.x;
    final dz = end.z - start.z;
    final lengthSquared = dx * dx + dz * dz;
    if (lengthSquared <= _minimumLengthSquared) return null;

    return WallSegment._(
      start: start,
      end: end,
      dx: dx,
      dz: dz,
      lengthSquared: lengthSquared,
      length: math.sqrt(lengthSquared),
    );
  }

  /// Unclamped fraction of the orthogonal projection of [point].
  double rawFraction(ARPoint point) =>
      ((point.x - start.x) * dx + (point.z - start.z) * dz) / lengthSquared;

  /// Fraction of the closest point of the wall to [point], in `[0, 1]`.
  double fraction(ARPoint point) =>
      rawFraction(point).clamp(0.0, 1.0).toDouble();

  ARPoint pointAt(double t) => ARPoint(
        x: start.x + dx * t,
        y: start.y + (end.y - start.y) * t,
        z: start.z + dz * t,
      );

  /// Squared floor-plane distance from [point] to the closest wall point.
  double distanceSquaredTo(ARPoint point) {
    final closest = pointAt(fraction(point));
    final distanceX = point.x - closest.x;
    final distanceZ = point.z - closest.z;
    return distanceX * distanceX + distanceZ * distanceZ;
  }

  /// Whether [point] lies on the wall within the on-wall tolerance.
  bool contains(ARPoint point) {
    final t = rawFraction(point);
    if (t < -_endOvershoot || t > 1 + _endOvershoot) return false;

    final projected = pointAt(t);
    final distanceX = point.x - projected.x;
    final distanceZ = point.z - projected.z;
    return distanceX * distanceX + distanceZ * distanceZ <=
        _onWallDistanceSquared;
  }

  /// Distance interval `(from, to)` in metres of [feature] along this wall,
  /// or `null` when either end of the feature is not on the wall.
  (double, double)? featureSpan(WallFeature feature) {
    if (!contains(feature.start) || !contains(feature.end)) return null;
    final first = fraction(feature.start) * length;
    final second = fraction(feature.end) * length;
    return (math.min(first, second), math.max(first, second));
  }

  /// Whether the span `[fromMeters, toMeters]` overlaps any opening of
  /// [features] lying on this wall by more than [separationMeters].
  ///
  /// The opening whose id equals [ignoreFeatureId] is skipped, so an opening
  /// can be moved without colliding with itself.
  bool overlapsOpening(
    double fromMeters,
    double toMeters,
    Iterable<WallFeature> features, {
    required double separationMeters,
    String? ignoreFeatureId,
  }) {
    for (final existing in features) {
      if (existing.id == ignoreFeatureId) continue;
      final span = featureSpan(existing);
      if (span == null) continue;
      if (fromMeters < span.$2 - separationMeters &&
          span.$1 < toMeters - separationMeters) {
        return true;
      }
    }
    return false;
  }

  /// Start distance in metres of an opening of [widthMeters] centred on the
  /// projection of [center], shifted as needed to stay inside the wall.
  ///
  /// Returns `null` when the opening is wider than the wall.
  double? centredOpeningStart(ARPoint center, double widthMeters) {
    if (widthMeters > length) return null;
    return (fraction(center) * length - widthMeters / 2)
        .clamp(0.0, length - widthMeters)
        .toDouble();
  }

  /// Index of the wall closest to [point] among the first [wallCount] walls
  /// of [points] (wall `i` joins corner `i` and `i + 1`, wrapping around).
  ///
  /// Degenerate walls are skipped. Returns `-1` when there is no valid wall.
  static int nearestWallIndex(
    List<ARPoint> points,
    int wallCount,
    ARPoint point,
  ) {
    var nearestIndex = -1;
    var nearestDistanceSquared = double.infinity;
    for (var index = 0; index < wallCount; index++) {
      final wall = between(points[index], points[(index + 1) % points.length]);
      if (wall == null) continue;
      final distanceSquared = wall.distanceSquaredTo(point);
      if (distanceSquared < nearestDistanceSquared) {
        nearestDistanceSquared = distanceSquared;
        nearestIndex = index;
      }
    }
    return nearestIndex;
  }
}
