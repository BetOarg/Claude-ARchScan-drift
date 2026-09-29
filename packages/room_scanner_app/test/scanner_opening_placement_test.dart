import 'package:flutter_test/flutter_test.dart';
import 'package:room_scanner_ar/providers/scanner_provider.dart';
import 'package:room_scanner_core/room_scanner_core.dart';

ARPoint p(double x, double z) => ARPoint(x: x, y: 0, z: z);

/// Open room being scanned: walls 0..2 plus the implicit closing wall 3.
ScannerProvider scanning(List<ARPoint> points,
    {List<WallFeature> features = const []}) {
  return ScannerProvider()
    ..restoreCurrentRoom(
      RoomModel(
        id: 'scan',
        name: 'Living',
        type: RoomType.living,
        isClosed: false,
        points: points,
        features: features,
      ),
    );
}

final square = [p(0, 0), p(5, 0), p(5, 4), p(0, 4)];

WallFeature added(ScannerProvider provider) =>
    provider.currentRoom!.features.last;

void expectPoint(ARPoint actual, double x, double z) {
  expect(actual.x, closeTo(x, 1e-9));
  expect(actual.z, closeTo(z, 1e-9));
}

void main() {
  group('Basic width placement', () {
    test('centres the opening on the nearest wall', () {
      final provider = scanning(square);

      final result = provider.addFeatureToCurrentRoom(
        FeatureType.door,
        p(2.5, -0.3),
        widthMeters: 0.9,
      );

      expect(result.isValid, isTrue);
      expectPoint(added(provider).start, 2.05, 0);
      expectPoint(added(provider).end, 2.95, 0);
    });

    test('shifts an opening near a corner to stay inside the wall', () {
      final provider = scanning(square);

      provider.addFeatureToCurrentRoom(
        FeatureType.window,
        p(0.1, 0),
        widthMeters: 1.2,
      );

      expectPoint(added(provider).start, 0, 0);
      expectPoint(added(provider).end, 1.2, 0);
    });

    test('can use the closing wall of a room still being scanned', () {
      final provider = scanning(square);

      final result = provider.addFeatureToCurrentRoom(
        FeatureType.door,
        p(-0.2, 2),
        widthMeters: 1,
      );

      expect(result.isValid, isTrue);
      expectPoint(added(provider).start, 0, 2.5);
      expectPoint(added(provider).end, 0, 1.5);
    });

    test('rejects too narrow or wider-than-wall openings', () {
      final provider = scanning(square);

      expect(
        provider
            .addFeatureToCurrentRoom(FeatureType.door, p(2, 0),
                widthMeters: 0.19)
            .isValid,
        isFalse,
      );
      expect(
        provider
            .addFeatureToCurrentRoom(FeatureType.door, p(2, 0),
                widthMeters: 5.1)
            .isValid,
        isFalse,
      );
      expect(provider.currentRoom!.features, isEmpty);
    });
  });

  group('camera placement', () {
    test('projects both measured ends onto the wall', () {
      final provider = scanning(square);

      final result = provider.addFeatureToCurrentRoom(
        FeatureType.window,
        p(3.2, 0.1),
        endLocation: p(1.8, -0.05),
      );

      expect(result.isValid, isTrue);
      expectPoint(added(provider).start, 1.8, 0);
      expectPoint(added(provider).end, 3.2, 0);
    });

    test('rejects ends closer than 20 cm', () {
      final provider = scanning(square);

      final result = provider.addFeatureToCurrentRoom(
        FeatureType.window,
        p(2, 0),
        endLocation: p(2.15, 0),
      );

      expect(result.isValid, isFalse);
      expect(provider.currentRoom!.features, isEmpty);
    });
  });

  group('preferred wall', () {
    test('places on the preferred wall even when another is closer', () {
      final provider = scanning(square);

      provider.addFeatureToCurrentRoom(
        FeatureType.door,
        p(2.5, 0.2),
        widthMeters: 1,
        preferredWallIndex: 2,
      );

      expectPoint(added(provider).start, 3, 4);
      expectPoint(added(provider).end, 2, 4);
    });

    test('rejects an index outside the available walls', () {
      final provider = scanning(square);

      final result = provider.addFeatureToCurrentRoom(
        FeatureType.door,
        p(2.5, 0),
        widthMeters: 1,
        preferredWallIndex: 4,
      );

      expect(result.isValid, isFalse);
    });
  });

  group('overlap with existing openings', () {
    final window = WallFeature(
      id: 'window',
      type: FeatureType.window,
      start: p(1, 0),
      end: p(2, 0),
    );

    test('rejects a 10 cm overlap on a long wall', () {
      // Regression: the 2 cm separation used to be applied as a fraction of
      // the wall, so on a 5 m wall a 10 cm overlap was accepted.
      final provider = scanning(square, features: [window]);

      final result = provider.addFeatureToCurrentRoom(
        FeatureType.door,
        p(2.4, 0),
        widthMeters: 1,
      );

      expect(result.isValid, isFalse);
      expect(provider.currentRoom!.features, [window]);
    });

    test('accepts an opening that only touches the existing one', () {
      final provider = scanning(square, features: [window]);

      final result = provider.addFeatureToCurrentRoom(
        FeatureType.door,
        p(2.5, 0),
        widthMeters: 1,
      );

      expect(result.isValid, isTrue);
      expect(provider.currentRoom!.features, hasLength(2));
    });

    test('ignores openings on other walls', () {
      final provider = scanning(square, features: [window]);

      final result = provider.addFeatureToCurrentRoom(
        FeatureType.door,
        p(1.5, 4.2),
        widthMeters: 1,
      );

      expect(result.isValid, isTrue);
    });
  });
}
