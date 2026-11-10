import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

void main() {
  group('Pérdidas', () {
    test('combinación multiplicativa del desglose por defecto', () {
      const l = SystemLosses();
      // 1 − 0.98·0.98·0.98·0.995·0.985·0.99·0.97
      expect(l.totalPercent, closeTo(11.42, 0.01));
      expect(l.factor, closeTo(1 - l.totalPercent / 100, 1e-12));
    });

    test('sin pérdidas', () {
      expect(SystemLosses.none.totalPercent, 0);
      expect(SystemLosses.none.degradationFactor(10), 1);
    });

    test('degradación anual compuesta', () {
      const l = SystemLosses();
      expect(l.degradationFactor(0), 1);
      expect(l.degradationFactor(1), closeTo(0.995, 1e-12));
      expect(l.degradationFactor(25), closeTo(0.88222, 1e-5));
    });

    test('copyWith cambia solo lo indicado', () {
      final l = const SystemLosses().copyWith(soiling: 5, shading: 3);
      expect(l.soiling, 5);
      expect(l.shading, 3);
      expect(l.mismatch, 2);
      final all = SystemLosses.none.copyWith(
        snow: 1,
        mismatch: 1,
        wiring: 1,
        connections: 1,
        lid: 1,
        nameplate: 1,
        availability: 1,
        annualDegradation: 1,
      );
      expect(
        all.totalPercent,
        closeTo(
          100 * (1 - 0.99 * 0.99 * 0.99 * 0.99 * 0.99 * 0.99 * 0.99),
          1e-9,
        ),
      );
      expect(all.annualDegradation, 1);
    });
  });

  group('Inversor PVWatts', () {
    const inv = PvwattsInverter(pacMax: 5000);

    test('sin potencia DC no hay AC', () {
      expect(inv.acPower(0), 0);
      expect(inv.acPower(-5), 0);
      expect(inv.isClipping(0), isFalse);
    });

    test('recorta a Pac,max', () {
      expect(inv.acPower(8000), 5000);
      expect(inv.isClipping(8000), isTrue);
      expect(inv.unclippedAcPower(8000), greaterThan(5000));
      expect(inv.isClipping(3000), isFalse);
    });

    test('eficiencia cerca de la nominal a media carga', () {
      final eta = inv.acPower(2600) / 2600;
      expect(eta, closeTo(0.96, 0.01));
      expect(inv.pdc0, closeTo(5000 / 0.96, 1e-9));
    });

    test('a carga muy baja la curva da potencia nula', () {
      expect(inv.acPower(10), 0);
    });
  });

  group('PVWatts DC', () {
    test('STC da la potencia nominal', () {
      expect(
        pvwattsDc(
          effectiveIrradiance: 1000,
          cellTemperature: 25,
          pdc0: 400,
          gammaPdc: -0.0035,
        ),
        400,
      );
    });

    test('nunca negativa', () {
      expect(
        pvwattsDc(
          effectiveIrradiance: 1000,
          cellTemperature: 400,
          pdc0: 400,
          gammaPdc: -0.0035,
        ),
        0,
      );
    });
  });
}
