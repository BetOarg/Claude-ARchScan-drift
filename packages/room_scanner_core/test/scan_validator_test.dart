import 'package:room_scanner_core/room_scanner_core.dart';
import 'package:test/test.dart';

ARPoint _p(double x, double z) => ARPoint(x: x, y: 0, z: z);

void main() {
  group('validateNewPoint', () {
    test('accepts the first point unconditionally', () {
      final result = ScanValidator.validateNewPoint(_p(0, 0), []);
      expect(result.isValid, isTrue);
    });

    test('rejects a point too close to the previous one', () {
      final existing = [_p(0, 0)];
      final result = ScanValidator.validateNewPoint(_p(0.1, 0), existing);
      expect(result.isValid, isFalse);
      expect(result.errorCode, ValidationErrorCode.tooCloseToPreviousPoint);
    });

    test('accepts a point beyond minCornerDistance', () {
      final existing = [_p(0, 0)];
      final result = ScanValidator.validateNewPoint(_p(0.5, 0), existing);
      expect(result.isValid, isTrue);
    });

    test('rejects a duplicate of an earlier (non-last) point', () {
      final existing = [_p(0, 0), _p(1, 0), _p(1, 1)];
      final result = ScanValidator.validateNewPoint(_p(0.05, 0.05), existing);
      expect(result.isValid, isFalse);
      expect(result.errorCode, ValidationErrorCode.duplicatePoint);
    });

    test('detects self-intersection when new segment crosses an existing wall',
        () {
      // Square-shaped path going clockwise, then a diagonal crossing it.
      final existing = [_p(0, 0), _p(2, 0), _p(2, 2), _p(0, 2)];
      // This segment from (0,2) to (1,-1) crosses the first wall (0,0)→(2,0).
      final result = ScanValidator.validateNewPoint(_p(1, -1), existing);
      expect(result.isValid, isFalse);
      expect(result.errorCode, ValidationErrorCode.selfIntersection);
    });

    test('suggests auto-close when near the starting point', () {
      final existing = [_p(0, 0), _p(2, 0), _p(2, 2)];
      final result = ScanValidator.validateNewPoint(_p(0.3, 0.3), existing);
      expect(result.isValid, isTrue);
      expect(result.warningMessage, isNotNull);
      expect(result.suggestedPoint, isNotNull);
      expect(result.suggestedPoint!.x, 0);
      expect(result.suggestedPoint!.z, 0);
    });

    test('does not suggest auto-close with fewer than 3 points', () {
      final existing = [_p(0, 0), _p(1, 0)];
      final result = ScanValidator.validateNewPoint(_p(0.1, 0.1), existing);
      // With only 2 existing points, duplicate check fires (near point 0).
      expect(result.isValid, isFalse);
    });

    test('accepts a valid fourth point forming a rectangle', () {
      final existing = [_p(0, 0), _p(3, 0), _p(3, 3)];
      final result = ScanValidator.validateNewPoint(_p(0, 3), existing);
      expect(result.isValid, isTrue);
      expect(result.warningMessage, isNull);
    });
  });

  group('validateClosure', () {
    test('rejects fewer than 3 points', () {
      final result = ScanValidator.validateClosure([_p(0, 0), _p(1, 0)]);
      expect(result.isValid, isFalse);
      expect(result.errorCode, ValidationErrorCode.insufficientCorners);
    });

    test('rejects a triangle with insufficient area', () {
      final result = ScanValidator.validateClosure([
        _p(0, 0),
        _p(0.1, 0),
        _p(0, 0.1),
      ]);
      expect(result.isValid, isFalse);
      expect(result.errorCode, ValidationErrorCode.insufficientArea);
    });

    test('accepts a rectangle with sufficient area', () {
      final result = ScanValidator.validateClosure([
        _p(0, 0),
        _p(2, 0),
        _p(2, 2),
        _p(0, 2),
      ]);
      expect(result.isValid, isTrue);
    });
  });

  group('hasSelfIntersections', () {
    test('convex polygon has no self-intersections', () {
      expect(
        ScanValidator.hasSelfIntersections([
          _p(0, 0),
          _p(2, 0),
          _p(2, 2),
          _p(0, 2),
        ]),
        isFalse,
      );
    });

    test('figure-eight polygon has self-intersections', () {
      expect(
        ScanValidator.hasSelfIntersections([
          _p(0, 0),
          _p(2, 2),
          _p(2, 0),
          _p(0, 2),
        ]),
        isTrue,
      );
    });
  });

  group('validatePointUpdate', () {
    test('rejects moving a vertex too close to its neighbor', () {
      final points = [_p(0, 0), _p(2, 0), _p(2, 2), _p(0, 2)];
      final result = ScanValidator.validatePointUpdate(
        1,
        _p(0.1, 0),
        points,
        true,
      );
      expect(result.isValid, isFalse);
      expect(result.errorCode, ValidationErrorCode.tooCloseToPreviousPoint);
    });

    test('accepts a valid vertex move', () {
      final points = [_p(0, 0), _p(2, 0), _p(2, 2), _p(0, 2)];
      final result = ScanValidator.validatePointUpdate(
        1,
        _p(3, 0),
        points,
        true,
      );
      expect(result.isValid, isTrue);
    });

    test('rejects a move that creates a duplicate', () {
      final points = [_p(0, 0), _p(2, 0), _p(2, 2), _p(0, 2)];
      // Move vertex 2 to be very close to vertex 1 — triggers too-close first.
      final result = ScanValidator.validatePointUpdate(
        2,
        _p(2, 0.1),
        points,
        true,
      );
      expect(result.isValid, isFalse);
      expect(result.errorCode, ValidationErrorCode.tooCloseToPreviousPoint);
    });
  });
}
