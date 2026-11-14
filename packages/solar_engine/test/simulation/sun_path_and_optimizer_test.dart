import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import '../helpers/golden.dart';

void main() {
  group('Carta solar', () {
    final mty = goldenSites['monterrey']!;
    final days = SunPath.characteristicDays(mty, 2026);

    test('cuatro días con el Sol sobre el horizonte', () {
      expect(days.length, 4);
      for (final pts in days.values) {
        expect(pts, isNotEmpty);
        expect(pts.every((p) => p.elevation > 0), isTrue);
      }
    });

    test('altura máxima al mediodía ≈ 90 − |φ − δ|', () {
      double maxElev(SunPathDay d) =>
          days[d]!.map((p) => p.elevation).reduce((a, b) => a > b ? a : b);
      // Solsticio de junio: δ ≈ +23.44°; diciembre: δ ≈ −23.44°.
      expect(
        maxElev(SunPathDay.juneSolstice),
        closeTo(90 - (25.69 - 23.44), 0.5),
      );
      expect(
        maxElev(SunPathDay.decemberSolstice),
        closeTo(90 - (25.69 + 23.44), 0.5),
      );
      expect(maxElev(SunPathDay.marchEquinox), closeTo(90 - 25.69, 0.6));
    });

    test('el día de junio es más largo que el de diciembre', () {
      expect(
        days[SunPathDay.juneSolstice]!.length,
        greaterThan(days[SunPathDay.decemberSolstice]!.length),
      );
      expect(SunPathDay.septemberEquinox.month, 9);
    });
  });

  group('Orientación óptima', () {
    for (final site in ['monterrey', 'madrid']) {
      test('$site: inclinación cercana a la latitud y azimut al sur', () {
        final s = goldenSites[site]!;
        final inputs = SimulationInputs.prepare(
          site: s,
          weather: loadTmy(site),
        );
        final optimizer = OrientationOptimizer(
          inputs: inputs,
          system: PvSystem.reference(tilt: 0, azimuth: 180),
        );
        final best = optimizer.optimize();
        expect(best.tilt, closeTo(s.latitude, 12));
        expect(best.azimuth, closeTo(180, 25));
        expect(best.evaluations, lessThan(60));
        // Ninguna orientación vecina rinde más (±5°).
        for (final (dt, da) in [
          (5.0, 0.0),
          (-5.0, 0.0),
          (0.0, 10.0),
          (0.0, -10.0),
        ]) {
          final e = optimizer.energyAt(best.tilt + dt, best.azimuth + da);
          expect(e, lessThanOrEqualTo(best.annualEnergy + 1e-6));
        }
      });
    }

    test('hemisferio sur mira al norte', () {
      // Bogotá reflejada al sur (latitud −4.7) con su mismo clima.
      const s = Site(latitude: -25, longitude: -74.07, elevation: 2640);
      final inputs = SimulationInputs.prepare(
        site: s,
        weather: loadTmy('bogota'),
      );
      final best = OrientationOptimizer(
        inputs: inputs,
        system: PvSystem.reference(tilt: 0, azimuth: 0),
        maxAzimuthDeviation: 45,
      ).optimize();
      expect(best.azimuth < 45 || best.azimuth > 315, isTrue);
      expect(best.tilt, greaterThan(5));
    });
  });
}
