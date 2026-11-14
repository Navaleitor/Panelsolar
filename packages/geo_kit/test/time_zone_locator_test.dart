import 'dart:io';

import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

void main() {
  final locator = TimeZoneLocator.fromGzip(
    File(TimeZoneLocator.assetPath).readAsBytesSync(),
  );
  final rows = File('test/golden/timezones_sample.csv')
      .readAsLinesSync()
      .skip(1)
      .map((l) => l.split(','))
      .toList();

  group('Zona horaria sin conexión', () {
    test('ciudades pedidas por el dueño: Hermosillo, Cancún y Tijuana', () {
      // Hermosillo: UTC−7 todo el año (Sonora no usa horario de verano).
      expect(locator.zoneAt(29.0729, -110.9559), 'America/Hermosillo');
      // Cancún: UTC−5 todo el año (Quintana Roo).
      expect(locator.zoneAt(21.1619, -86.8515), 'America/Cancun');
      // Tijuana: UTC−8 con horario de verano (como California).
      expect(locator.zoneAt(32.5149, -117.0382), 'America/Tijuana');
    });

    test('las 16 ciudades de referencia coinciden exactamente', () {
      for (final r in rows.where((r) => !r[0].startsWith(RegExp('r|mx')))) {
        expect(
          locator.zoneAt(double.parse(r[1]), double.parse(r[2])),
          r[3],
          reason: r[0],
        );
      }
    });

    test('≥ 99 % de 4 000 puntos al azar igual que los datos completos', () {
      final random = rows.where((r) => r[0].startsWith(RegExp('r|mx')));
      var ok = 0;
      for (final r in random) {
        if (locator.zoneAt(double.parse(r[1]), double.parse(r[2])) == r[3]) {
          ok++;
        }
      }
      expect(ok / random.length, greaterThanOrEqualTo(0.99));
    });

    test('metadatos y atribución', () {
      expect(locator.zones, contains('America/Monterrey'));
      expect(locator.dataVersion, isNotEmpty);
      expect(TimeZoneLocator.attribution, contains('OpenStreetMap'));
      expect(TimeZoneLocator.flutterAssetKey, startsWith('packages/geo_kit/'));
    });

    test('zona náutica por longitud', () {
      expect(TimeZoneLocator.nauticalZone(-100), 'Etc/GMT+7');
      expect(TimeZoneLocator.nauticalZone(120), 'Etc/GMT-8');
      expect(TimeZoneLocator.nauticalZone(3), 'Etc/GMT');
      expect(TimeZoneLocator.nauticalZone(-179.9), 'Etc/GMT+12');
    });

    test('archivo inválido', () {
      expect(
        () => TimeZoneLocator.fromGzip(gzip.encode('XXXX0000'.codeUnits)),
        throwsFormatException,
      );
      expect(
        () => TimeZoneLocator.fromGzip(
          gzip.encode([...'PSTZ'.codeUnits, 9, 0, 0, 0]),
        ),
        throwsFormatException,
      );
    });

    test('carga y búsqueda rápidas', () {
      final sw = Stopwatch()..start();
      final l = TimeZoneLocator.fromGzip(
        File(TimeZoneLocator.assetPath).readAsBytesSync(),
      );
      final load = sw.elapsedMilliseconds;
      for (var i = 0; i < 1000; i++) {
        l.zoneAt(25.6866, -100.3161);
      }
      // ignore: avoid_print, se informa el tiempo en el registro del CI.
      print(
        'carga $load ms; 1000 búsquedas ${sw.elapsedMilliseconds - load} ms',
      );
      expect(sw.elapsedMilliseconds, lessThan(3000));
    });
  });
}
