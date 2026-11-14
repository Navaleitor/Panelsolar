import 'dart:typed_data';

import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import '../helpers/golden.dart';

void main() {
  group('Estadísticas climáticas', () {
    final mty = goldenSites['monterrey']!;
    final stats = ClimateStatistics.compute(mty, loadTmy('monterrey'));

    test('12 meses con irradiación y temperaturas coherentes', () {
      expect(stats.monthly.length, 12);
      for (final m in stats.monthly) {
        expect(m.irradiation, greaterThan(0));
        expect(m.tempMin, lessThanOrEqualTo(m.tempMean));
        expect(m.tempMax, greaterThanOrEqualTo(m.tempMean));
      }
      // Monterrey: GHI anual ~1900 kWh/m² y junio más soleado que diciembre.
      expect(stats.annual.irradiation, inInclusiveRange(1600, 2200));
      expect(
        stats.monthly[5].irradiation,
        greaterThan(stats.monthly[11].irradiation),
      );
      expect(
        stats.monthly[0].dailyIrradiation,
        closeTo(stats.monthly[0].irradiation / 31, 1e-9),
      );
    });

    test('verano más caluroso que invierno en el hemisferio norte', () {
      final summer = stats.seasonal[Season.summer]!;
      final winter = stats.seasonal[Season.winter]!;
      expect(summer.tempMean, greaterThan(winter.tempMean));
      expect(summer.irradiation, greaterThan(winter.irradiation));
      final total = Season.values
          .map((s) => stats.seasonal[s]!.irradiation)
          .reduce((a, b) => a + b);
      expect(total, closeTo(stats.annual.irradiation, 1e-6));
    });

    test('temperaturas de diseño para strings', () {
      final d = stats.design;
      expect(d.recordMin, lessThan(d.recordMax));
      expect(
        d.recordMin,
        stats.monthly.map((m) => m.tempMin).reduce((a, b) => a < b ? a : b),
      );
      expect(d.meanAnnualMin, greaterThanOrEqualTo(d.recordMin));
      expect(d.meanAnnualMax, lessThanOrEqualTo(d.recordMax));
    });

    test('en el hemisferio sur las estaciones se invierten', () {
      // Serie sintética: temperatura = mes (enero 1 °C … diciembre 12 °C).
      final epochs = <int>[];
      final temp = <double>[];
      var t = DateTime.utc(2023);
      while (t.year == 2023) {
        epochs.add(t.millisecondsSinceEpoch ~/ 1000);
        temp.add(t.month.toDouble());
        t = t.add(const Duration(hours: 1));
      }
      final n = epochs.length;
      final zeros = Float64List(n);
      final w = WeatherSeries(
        startEpochSeconds: epochs,
        ghi: zeros,
        dni: zeros,
        dhi: zeros,
        tempAir: Float64List.fromList(temp),
        windSpeed: zeros,
      );
      const south = Site(latitude: -30, longitude: 0, utcOffsetHours: 0);
      final s = ClimateStatistics.compute(south, w);
      // Verano austral = dic, ene, feb.
      expect(s.seasonal[Season.summer]!.tempMin, 1);
      expect(s.seasonal[Season.summer]!.tempMax, 12);
      expect(s.seasonal[Season.winter]!.tempMean, closeTo(7.011, 0.001));
      expect(s.design.recordMin, 1);
      expect(s.design.meanAnnualMax, 12);
    });
  });
}
