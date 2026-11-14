import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

void main() {
  group('HorizonBuilder', () {
    test('obstáculo lejano que cruza el norte (350° → 10°)', () {
      const span = [
        (azimuth: 350.0, elevation: 10.0),
        (azimuth: 0.0, elevation: 20.0),
        (azimuth: 10.0, elevation: 10.0),
      ];
      expect(HorizonBuilder.spanElevation(span, 355), closeTo(15, 1e-9));
      expect(HorizonBuilder.spanElevation(span, 0), closeTo(20, 1e-9));
      expect(HorizonBuilder.spanElevation(span, 180), isNull);
    });

    test('combina terreno y obstáculos tomando el más alto', () {
      final terrain = HorizonProfile([
        (azimuth: 0, elevation: 2),
        (azimuth: 180, elevation: 6),
      ]);
      const tree = [
        (azimuth: 170.0, elevation: 25.0),
        (azimuth: 190.0, elevation: 25.0),
      ];
      final h = HorizonBuilder.combine(terrain: terrain, spans: [tree]);
      expect(h.elevationAt(180), closeTo(25, 1e-9));
      expect(h.elevationAt(90), closeTo(4, 1e-9));
      expect(h.blocks(20, 180), isTrue);
      expect(h.blocks(20, 120), isFalse);
    });
  });

  group('SunSamples', () {
    test('DNI de cielo despejado con el Sol en el cenit ≈ 947 W/m²', () {
      expect(SunSamples.clearSkyDni(0), closeTo(947.2, 0.5));
      expect(SunSamples.clearSkyDni(95), 0);
    });

    test('muestras de un año: sólo con Sol arriba y peso positivo', () {
      const site = Site(
        latitude: 25.69,
        longitude: -100.32,
        utcOffsetHours: -6,
      );
      final s = SunSamples.year(site, dayStep: 14, minuteStep: 60);
      expect(s, isNotEmpty);
      expect(s.every((x) => x.elevation > 0 && x.weight > 0), isTrue);
      expect(s.map((x) => x.month).toSet(), hasLength(12));
    });
  });

  group('ShadeHeatmapCalculator', () {
    const site = Site(latitude: 25.69, longitude: -100.32, utcOffsetHours: -6);
    final samples = SunSamples.year(site, dayStep: 14, minuteStep: 60);
    const plane = [
      (x: 0.0, y: 0.0),
      (x: 10.0, y: 0.0),
      (x: 10.0, y: 10.0),
      (x: 0.0, y: 10.0),
    ];

    test('sin obstáculos ni horizonte → 0 % de pérdida', () {
      final map = ShadeHeatmapCalculator.compute(
        plane: plane,
        obstacles: const [],
        samples: samples,
        cellSize: 1,
      );
      expect(map.columns, 10);
      expect(map.rows, 10);
      expect(map.averageLoss, 0);
    });

    test('horizonte que tapa todo → 100 %', () {
      final map = ShadeHeatmapCalculator.compute(
        plane: plane,
        obstacles: const [],
        samples: samples,
        horizon: HorizonProfile([(azimuth: 0, elevation: 90)]),
        cellSize: 1,
      );
      expect(map.averageLoss, closeTo(1, 1e-12));
    });

    test(
      'cubo de escalera al sur: más pérdida pegado al norte y en invierno',
      () {
        // Caja de 2 × 1 m y 2.4 m de alto en el borde sur, al centro.
        const stairs = ShadingObstacle(
          footprint: [(x: 4, y: 0), (x: 6, y: 0), (x: 6, y: 1), (x: 4, y: 1)],
          heightM: 2.4,
        );
        final map = ShadeHeatmapCalculator.compute(
          plane: plane,
          obstacles: const [stairs],
          samples: samples,
          cellSize: 0.5,
        );
        double cell(double x, double y) =>
            map.at((x / map.cellSize).floor(), (y / map.cellSize).floor());
        // Dentro de la huella siempre hay sombra.
        expect(cell(5, 0.5), closeTo(1, 1e-12));
        // Justo al norte pierde mucho; lejos al norte casi nada.
        expect(cell(5, 1.75), greaterThan(0.3));
        expect(cell(5, 9.75), lessThan(0.02));
        expect(cell(5, 1.75), greaterThan(cell(5, 4.75)));
        // En diciembre (Sol bajo) la pérdida es mayor que en junio.
        expect(map.monthlyLoss[11], greaterThan(map.monthlyLoss[5]));
        expect(map.averageLoss, inExclusiveRange(0.02, 0.2));
      },
    );

    test('rejilla demasiado fina se agranda para no pasar de maxCells', () {
      final map = ShadeHeatmapCalculator.compute(
        plane: plane,
        obstacles: const [],
        samples: samples.take(5).toList(),
        cellSize: 0.01,
        maxCells: 400,
      );
      expect(map.columns * map.rows, lessThanOrEqualTo(400));
      expect(map.cellCenter(0, 0).x, closeTo(map.cellSize / 2, 1e-9));
    });
  });
}
