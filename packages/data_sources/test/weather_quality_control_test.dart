import 'dart:convert';
import 'dart:typed_data';

import 'package:data_sources/data_sources.dart';
import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import 'helpers.dart';

WeatherSeries _nasaFixture() => NasaPowerClient.parse(
  fixture('nasa_power_hourly.json'),
  latitude: 25.67,
  longitude: -100.31,
  yearStart: 2024,
  yearEnd: 2024,
  accessedAt: DateTime.utc(2026),
).series;

int _epoch(int d, int h) =>
    DateTime.utc(2024, 1, d, h).millisecondsSinceEpoch ~/ 1000;

void main() {
  group('Control de calidad', () {
    final qc = WeatherQualityControl.check(_nasaFixture(), fixtureSite);
    final s = qc.series;
    final r = qc.report;

    test('rellena la hora faltante (noche → 0)', () {
      expect(r.missingRecords, 1);
      expect(s.length, 48);
      final i = s.startEpochSeconds.indexOf(_epoch(1, 5));
      expect(s.ghi[i], 0);
      expect(s.tempAir[i].isNaN, isFalse);
    });

    test('GHI faltante de día se toma del día siguiente a la misma hora', () {
      final i = s.startEpochSeconds.indexOf(_epoch(1, 18));
      expect(s.ghi[i], s.ghi[i + 24]);
      expect(r.missingValues['ghi'], 2); // la hora agregada + el −999
    });

    test('temperatura faltante se interpola', () {
      final i = s.startEpochSeconds.indexOf(_epoch(1, 20));
      expect(
        s.tempAir[i],
        closeTo((s.tempAir[i - 1] + s.tempAir[i + 1]) / 2, 1e-9),
      );
    });

    test('negativos a 0 y albedo nocturno con el promedio', () {
      expect(r.negativeValues, 1);
      final i = s.startEpochSeconds.indexOf(_epoch(1, 16));
      // La DNI negativa se puso en 0 y el cierre la recalculó desde la GHI.
      expect(s.dni[i], greaterThan(0));
      expect(r.componentsClosed, greaterThan(0));
      expect(s.albedo!.every((a) => !a.isNaN), isTrue);
    });

    test('informe usable y con advertencias', () {
      expect(r.isUsable, isTrue);
      expect(r.ghiAboveExtraterrestrial, 0);
      expect(r.warnings.length, 4);
      expect(r.totalMissingValues, greaterThan(0));
    });

    test('recorta GHI mayor que la extraterrestre y avisa', () {
      final base = _nasaFixture();
      final ghi = Float64List.fromList(base.ghi);
      ghi[2] = 500; // 02 UTC = noche en Monterrey
      final w = WeatherSeries(
        startEpochSeconds: base.startEpochSeconds,
        ghi: ghi,
        dni: base.dni,
        dhi: base.dhi,
        tempAir: base.tempAir,
        windSpeed: base.windSpeed,
      );
      final out = WeatherQualityControl.check(w, fixtureSite);
      expect(out.report.ghiAboveExtraterrestrial, 1);
      expect(
        out.series.ghi[2],
        WeatherQualityControl.extraterrestrialTolerance,
      );
      expect(out.report.warnings.join(), contains('extraterrestre'));
    });

    test('serie casi vacía: no usable', () {
      const n = 24;
      final nan = Float64List(n)..fillRange(0, n, double.nan);
      final w = WeatherSeries(
        startEpochSeconds: [
          for (var i = 0; i < n; i++) _epoch(1, 0) + i * 3600,
        ],
        ghi: nan,
        dni: nan,
        dhi: nan,
        tempAir: nan,
        windSpeed: Float64List(n)..fillRange(0, n, -1),
      );
      final out = WeatherQualityControl.check(w, fixtureSite);
      expect(out.report.isUsable, isFalse);
      expect(out.series.tempAir.every((t) => t == 0), isTrue);
      expect(out.series.windSpeed.every((v) => v == 0), isTrue);
      expect(out.report.warnings.last, contains('demasiados huecos'));
    });

    test('un TMY (no cronológico) no se regulariza', () {
      final tmy = PvgisClient.parseTmy(
        jsonDecode(fixture('pvgis_tmy.json')) as Map<String, dynamic>,
        latitude: 25.67,
        longitude: -100.31,
        accessedAt: DateTime.utc(2026),
      );
      final shuffled = WeatherSeries(
        startEpochSeconds: [...tmy.series.startEpochSeconds.reversed],
        ghi: tmy.series.ghi,
        dni: tmy.series.dni,
        dhi: tmy.series.dhi,
        tempAir: tmy.series.tempAir,
        windSpeed: tmy.series.windSpeed,
      );
      final out = WeatherQualityControl.check(shuffled, fixtureSite);
      expect(out.report.missingRecords, 0);
      expect(out.series.length, 48);
    });
  });

  group('Comparación NASA vs PVGIS', () {
    test('advierte si la diferencia anual supera el 10 %', () {
      const c = CrossSourceCheck(
        primaryAnnualGhi: 2000,
        referenceAnnualGhi: 1750,
      );
      expect(c.differencePercent, closeTo(14.29, 0.01));
      expect(c.exceedsThreshold, isTrue);
      expect(c.warnings.single, contains('14.3 %'));
      const ok = CrossSourceCheck(
        primaryAnnualGhi: 1800,
        referenceAnnualGhi: 1750,
      );
      expect(ok.warnings, isEmpty);
      const hot = CrossSourceCheck(
        primaryAnnualGhi: 1800,
        referenceAnnualGhi: 1750,
        primaryMeanTemp: 19,
        referenceMeanTemp: 12.5,
      );
      expect(hot.temperatureExceedsThreshold, isTrue);
      expect(hot.warnings.single, contains('6.5 °C'));
    });

    test('compara el año típico de dos series', () {
      final s = _yearSeries(1);
      final s2 = _yearSeries(1.2);
      final c = WeatherQualityControl.compareAnnual(
        s2,
        s,
        const Site(latitude: 0, longitude: 0),
      );
      expect(c.differencePercent, closeTo(20, 1e-6));
    });
  });
}

WeatherSeries _yearSeries(double scale) {
  final epochs = <int>[];
  var t = DateTime.utc(2023);
  while (t.year == 2023) {
    epochs.add(t.millisecondsSinceEpoch ~/ 1000);
    t = t.add(const Duration(hours: 1));
  }
  final n = epochs.length;
  return WeatherSeries(
    startEpochSeconds: epochs,
    ghi: Float64List(n)..fillRange(0, n, 200 * scale),
    dni: Float64List(n),
    dhi: Float64List(n),
    tempAir: Float64List(n),
    windSpeed: Float64List(n),
  );
}
