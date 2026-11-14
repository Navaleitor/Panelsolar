import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import '../helpers/golden.dart';

void main() {
  final inputs = SimulationInputs.prepare(
    site: goldenSites['monterrey']!,
    weather: loadTmy('monterrey'),
  );

  group('Producción del sistema real (B.6 puntos 8 y 9)', () {
    test('10 paneles de 550 W con inversor de 5 kW', () {
      final r = DesignSimulator.run(
        inputs: inputs,
        groups: const [
          ArrayGroup(
            tiltDeg: 20,
            azimuthDeg: 180,
            panelCount: 10,
            panelPowerW: 550,
          ),
        ],
        pacW: 5000,
      );
      expect(r.pdcW, 5500);
      expect(r.dcAcRatio, closeTo(1.1, 1e-12));
      expect(r.dcAcInRange, isTrue);
      expect(r.specificYield, inInclusiveRange(1500, 2100));
      expect(r.performanceRatio, inInclusiveRange(0.7, 0.9));
      expect(r.yearlyKwh, hasLength(25));
      expect(r.yearlyKwh.first, closeTo(r.firstYearKwh, 1e-9));
      // Degradación 0.5 %/año: el año 25 da (0.995)^24 del primero.
      expect(
        r.yearlyKwh.last / r.firstYearKwh,
        closeTo(const SystemLosses().degradationFactor(24), 1e-12),
      );
      expect(r.lifetimeKwh, lessThan(25 * r.firstYearKwh));
      final monthSum = r.monthlyFirstYearKwh.reduce((a, b) => a + b);
      expect(monthSum, closeTo(r.firstYearKwh, 1e-6));
    });

    test('la sombra y una relación DC/AC alta bajan la energía', () {
      const base = ArrayGroup(
        tiltDeg: 20,
        azimuthDeg: 180,
        panelCount: 10,
        panelPowerW: 550,
      );
      final clean = DesignSimulator.run(
        inputs: inputs,
        groups: const [base],
        pacW: 5000,
      );
      final shaded = DesignSimulator.run(
        inputs: inputs,
        groups: const [
          ArrayGroup(
            tiltDeg: 20,
            azimuthDeg: 180,
            panelCount: 10,
            panelPowerW: 550,
            shadingLoss: 0.1,
          ),
        ],
        pacW: 5000,
      );
      expect(shaded.firstYearKwh / clean.firstYearKwh, closeTo(0.9, 0.005));
      expect(shaded.shadingLoss, closeTo(0.1, 1e-12));
      final small = DesignSimulator.run(
        inputs: inputs,
        groups: const [base],
        pacW: 3000,
      );
      expect(small.dcAcInRange, isFalse);
      expect(small.clippedKwh, greaterThan(clean.clippedKwh));
      expect(small.clippingFraction, greaterThan(0));
    });

    test('dos planos suman energía; sin inversor no produce', () {
      final two = DesignSimulator.run(
        inputs: inputs,
        groups: const [
          ArrayGroup(
            tiltDeg: 20,
            azimuthDeg: 90,
            panelCount: 5,
            panelPowerW: 550,
          ),
          ArrayGroup(
            tiltDeg: 20,
            azimuthDeg: 270,
            panelCount: 5,
            panelPowerW: 550,
          ),
        ],
        pacW: 5000,
      );
      expect(two.pdcW, 5500);
      expect(two.firstYearKwh, greaterThan(0));
      final none = DesignSimulator.run(
        inputs: inputs,
        groups: const [],
        pacW: 0,
      );
      expect(none.firstYearKwh, 0);
      expect(none.dcAcRatio, 0);
      expect(none.specificYield, 0);
      expect(none.performanceRatio, 0);
      expect(none.clippingFraction, 0);
    });
  });
}
