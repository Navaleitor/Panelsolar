import 'dart:typed_data';

import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import '../helpers/golden.dart';

void main() {
  final mty = goldenSites['monterrey']!;
  final tmy = loadTmy('monterrey');
  final inputs = SimulationInputs.prepare(site: mty, weather: tmy);

  group('Simulación de un año típico (Monterrey)', () {
    final result = Simulator.run(
      inputs,
      PvSystem.reference(tilt: 26, azimuth: 180),
      keepHourly: true,
    );

    test('12 meses con energía y año típico = suma de meses', () {
      expect(result.monthlyAcEnergy.length, 12);
      expect(result.monthlyAcEnergy.every((e) => e > 0), isTrue);
      final sum = result.monthlyAcEnergy.reduce((a, b) => a + b);
      expect(result.annualAcEnergy, closeTo(sum, 1e-9));
      // Unas horas de la noche quedan en otro mes local: el año típico
      // difiere muy poco del total de la serie.
      expect(result.annualAcEnergy, closeTo(result.totalAcEnergy, 1));
    });

    test('rendimiento específico y PR razonables', () {
      expect(result.specificYield, inInclusiveRange(1500, 2100));
      expect(result.performanceRatio, inInclusiveRange(0.7, 0.9));
      expect(result.hourlyAcPower!.length, tmy.length);
      expect(result.clippedEnergy, greaterThanOrEqualTo(0));
    });

    test('un TMY no tiene años calendario completos', () {
      expect(result.yearlyAcEnergy, isEmpty);
    });

    test('la degradación reduce la energía', () {
      final year10 = Simulator.run(
        inputs,
        PvSystem.reference(tilt: 26, azimuth: 180),
        operatingYear: 10,
      );
      expect(
        year10.annualAcEnergy / result.annualAcEnergy,
        closeTo(const SystemLosses().degradationFactor(10), 0.002),
      );
    });

    test('más relación DC/AC ⇒ más recorte', () {
      const big = PvSystem(
        tilt: 26,
        azimuth: 180,
        pdc0: 1000,
        inverter: PvwattsInverter(pacMax: 500),
      );
      final r = Simulator.run(inputs, big);
      expect(big.dcAcRatio, 2);
      expect(r.clippedEnergy, greaterThan(50));
    });
  });

  group('Entradas', () {
    test('sin DNI/DHI se usa Erbs y se aplica el albedo de la serie', () {
      final n = tmy.length;
      final nanList = Float64List(n)..fillRange(0, n, double.nan);
      final albedo = Float64List(n)..fillRange(0, n, 0.3);
      albedo[0] = -999;
      final w = WeatherSeries(
        startEpochSeconds: tmy.startEpochSeconds,
        ghi: tmy.ghi,
        dni: nanList,
        dhi: nanList,
        tempAir: tmy.tempAir,
        windSpeed: tmy.windSpeed,
        albedo: albedo,
      );
      final erbsInputs = SimulationInputs.prepare(site: mty, weather: w);
      expect(erbsInputs.albedo[0], 0.2);
      expect(erbsInputs.albedo[1], 0.3);
      expect(erbsInputs.dni.every((v) => v.isFinite && v >= 0), isTrue);
      final r = Simulator.run(
        erbsInputs,
        PvSystem.reference(tilt: 26, azimuth: 180),
      );
      final ref = Simulator.run(
        inputs,
        PvSystem.reference(tilt: 26, azimuth: 180),
      );
      // Erbs vs. DNI/DHI de PVGIS: misma energía con ±10 %.
      expect(
        r.annualAcEnergy,
        closeTo(ref.annualAcEnergy, 0.1 * ref.annualAcEnergy),
      );
    });

    test('columnas de distinto largo lanzan error', () {
      expect(
        () => WeatherSeries(
          startEpochSeconds: [0, 3600],
          ghi: Float64List(2),
          dni: Float64List(2),
          dhi: Float64List(2),
          tempAir: Float64List(1),
          windSpeed: Float64List(2),
        ),
        throwsArgumentError,
      );
    });

    test('un horizonte alto bloquea la directa', () {
      final wall = HorizonProfile([
        (azimuth: 0, elevation: 89),
        (azimuth: 180, elevation: 89),
      ]);
      final blocked = SimulationInputs.prepare(
        site: mty,
        weather: tmy,
        horizon: wall,
      );
      final pv = PvSystem.reference(tilt: 26, azimuth: 180);
      final r = Simulator.run(blocked, pv);
      final ref = Simulator.run(inputs, pv);
      expect(r.annualAcEnergy, lessThan(0.6 * ref.annualAcEnergy));
      expect(
        blocked.beamBlocked.where((b) => b == 1).length,
        greaterThan(4000),
      );
    });

    test('valores faltantes de temperatura y viento usan 25 °C y 1 m/s', () {
      final w = WeatherSeries(
        startEpochSeconds: [tmy.startEpochSeconds[4380]],
        ghi: Float64List.fromList([tmy.ghi[4380]]),
        dni: Float64List.fromList([tmy.dni[4380]]),
        dhi: Float64List.fromList([tmy.dhi[4380]]),
        tempAir: Float64List.fromList([double.nan]),
        windSpeed: Float64List.fromList([double.nan]),
      );
      final i = SimulationInputs.prepare(site: mty, weather: w);
      final h = Simulator.hourly(
        i,
        PvSystem.reference(tilt: 26, azimuth: 180),
        0,
      );
      expect(h.cellTemperature, closeTo(25 + h.poa.global / (25 + 6.84), 1e-9));
    });

    test('sin IAM la irradiancia efectiva es la POA', () {
      const pv = PvSystem(
        tilt: 26,
        azimuth: 180,
        pdc0: 1000,
        inverter: PvwattsInverter(pacMax: 1000),
        iamB0: null,
      );
      final h = Simulator.hourly(inputs, pv, 4380 + 18);
      expect(h.iam, 1);
      expect(h.effectiveIrradiance, closeTo(h.poa.global, 1e-9));
    });
  });

  group('Sitio', () {
    test('desfase horario estimado y hemisferio', () {
      const s = Site(latitude: -33.45, longitude: -70.66);
      expect(s.utcOffsetHours, -5);
      expect(s.isSouthernHemisphere, isTrue);
      expect(s.equatorFacingAzimuth, 0);
      expect(mty.equatorFacingAzimuth, 180);
      expect(
        const Site(latitude: 0, longitude: 0, utcOffsetHours: 3).utcOffsetHours,
        3,
      );
      expect(
        const Site(latitude: 0, longitude: 0).pressureHpa,
        closeTo(1013.25, 0.1),
      );
    });
  });
}
