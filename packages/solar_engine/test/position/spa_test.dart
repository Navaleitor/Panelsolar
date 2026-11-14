import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import '../helpers/golden.dart';

void main() {
  group('NREL SPA', () {
    test('ejemplo del artículo de Reda y Andreas (2004), tabla A5.1', () {
      // 17-oct-2003 12:30:30 hora local (UTC−7), Golden, Colorado.
      final pos = Spa.compute(
        timeUtc: DateTime.utc(2003, 10, 17, 19, 30, 30),
        latitude: 39.742476,
        longitude: -105.1786,
        elevation: 1830.14,
        pressureHpa: 820,
        temperatureC: 11,
        deltaT: 67,
      );
      expect(pos.apparentZenith, closeTo(50.11162, 1e-5));
      expect(pos.azimuth, closeTo(194.34024, 1e-5));
      expect(pos.elevation, closeTo(90 - pos.zenith, 1e-12));
      expect(pos.isUp, isTrue);
    });

    test('coincide con pvlib (±0.01°) en los 6 sitios de referencia', () {
      final rows = readCsv('$goldenDir/solar_position.csv');
      expect(rows.length, greaterThan(2000));
      var maxErr = 0.0;
      for (final r in rows) {
        final site = goldenSites[r['site']]!;
        final pos = Spa.compute(
          timeUtc: DateTime.fromMillisecondsSinceEpoch(
            int.parse(r['sample_epoch']!) * 1000,
            isUtc: true,
          ),
          latitude: site.latitude,
          longitude: site.longitude,
          elevation: site.elevation,
          pressureHpa: site.pressureHpa,
        );
        final dz = (pos.zenith - num(r, 'zenith')).abs();
        final dza = (pos.apparentZenith - num(r, 'apparent_zenith')).abs();
        var daz = (pos.azimuth - num(r, 'azimuth')).abs();
        if (daz > 180) daz = 360 - daz;
        for (final e in [dz, dza, daz]) {
          if (e > maxErr) maxErr = e;
        }
      }
      expect(maxErr, lessThan(0.01));
    });

    test('el Sol está bajo el horizonte de noche', () {
      final pos = Spa.compute(
        timeUtc: DateTime.utc(2024, 6, 21, 6),
        latitude: 25.6866,
        longitude: -100.3161,
      );
      expect(pos.isUp, isFalse);
      expect(pos.apparentElevation, lessThan(0));
    });
  });

  group('ΔT', () {
    test('igual que pvlib.spa.calculate_deltat desde 1900', () {
      const cases = {
        (2000, 1): 63.87383281095924,
        (2024, 7): 74.19280657812504,
        (1990, 1): 56.92137028332472,
        (1970, 1): 40.23467888274606,
        (1950, 1): 29.086950910613957,
        (1930, 1): 24.130835825057865,
        (1910, 1): 10.445380968083992,
        (2100, 1): 202.8381222222219,
        (2200, 1): 442.18133888888855,
      };
      cases.forEach((ym, expected) {
        expect(deltaTSeconds(ym.$1, ym.$2), closeTo(expected, 1e-9));
      });
    });

    test('antes de 1900 usa la parábola de largo plazo', () {
      expect(deltaTSeconds(1800, 1), closeTo(-18.7, 0.1));
    });
  });
}
