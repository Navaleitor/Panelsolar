import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

void main() {
  group('Viento ASCE 7-22 (B.6 punto 17)', () {
    test('Kz ≈ 1.00 a 10 m en exposición C', () {
      expect(WindPressure.kz(10, WindExposure.c), closeTo(1.0, 0.01));
    });

    test('Kz usa la altura mínima (4.6 m; 9.1 m en B)', () {
      expect(
        WindPressure.kz(2, WindExposure.c),
        WindPressure.kz(15 * 0.3048, WindExposure.c),
      );
      expect(
        WindPressure.kz(2, WindExposure.b),
        WindPressure.kz(30 * 0.3048, WindExposure.b),
      );
      expect(
        WindPressure.kz(10, WindExposure.d),
        greaterThan(WindPressure.kz(10, WindExposure.c)),
      );
    });

    test('Ke = e^(−0.000119·z): Monterrey (540 m) ≈ 0.938', () {
      expect(WindPressure.ke(0), 1);
      expect(WindPressure.ke(540), closeTo(0.938, 0.001));
    });

    test('qz = 0.613·Kz·Kzt·Kd·Ke·V² y fuerza por anclaje', () {
      final r = WindPressure.compute(
        const WindInput(
          basicSpeedMs: 40,
          heightM: 10,
          siteElevationM: 0,
          tributaryAreaM2: 0.8,
        ),
      );
      final expected = 0.613 * r.kz * 0.85 * 1600;
      expect(r.qzPa, closeTo(expected, 1e-9));
      expect(r.qzPa, closeTo(834, 10));
      expect(r.netPressurePa, closeTo(-1.5 * expected, 1e-9));
      expect(r.forcePerAnchorN, closeTo(1.5 * expected * 0.8, 1e-9));
      expect(WindPressure.kmhToMs(144), 40);
    });
  });
}
