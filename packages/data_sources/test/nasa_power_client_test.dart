import 'package:data_sources/data_sources.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  group('NasaPowerClient', () {
    test('construye la URL horaria con los 6 parámetros en UTC', () {
      final uri = NasaPowerClient(client: FakeServer().client)
          .buildUri(25.67, -100.31, 2021, 2025);
      expect(uri.host, 'power.larc.nasa.gov');
      expect(uri.path, '/api/temporal/hourly/point');
      expect(uri.queryParameters['parameters'], contains('ALLSKY_SRF_ALB'));
      expect(uri.queryParameters['start'], '20210101');
      expect(uri.queryParameters['end'], '20251231');
      expect(uri.queryParameters['time-standard'], 'UTC');
      expect(uri.queryParameters['community'], 'RE');
    });

    test('últimos 5 años completos', () {
      final y = NasaPowerClient.lastCompleteYears(DateTime.utc(2026, 11, 10));
      expect((y.start, y.end), (2021, 2025));
    });

    test('interpreta la respuesta: −999 → NaN, versión y altitud', () async {
      final server = FakeServer()
        ..routes['hourly'] = (200, fixture('nasa_power_hourly.json'));
      final d = await NasaPowerClient(client: server.client).fetchHourly(
        latitude: 25.67,
        longitude: -100.31,
        yearStart: 2024,
        yearEnd: 2024,
        now: DateTime.utc(2026, 11, 10),
      );
      expect(d.source, WeatherSource.nasaPower);
      expect(d.version, 'v2.10.4');
      expect(d.elevation, closeTo(786.43, 0.01));
      expect(d.series.length, 47); // 48 h menos la hora quitada
      final i18 = d.series.startEpochSeconds.indexOf(
        DateTime.utc(2024, 1, 1, 18).millisecondsSinceEpoch ~/ 1000,
      );
      expect(d.series.ghi[i18].isNaN, isTrue);
      expect(d.series.albedo![0].isNaN, isTrue); // de noche NASA no da albedo
      expect(d.series.albedo!.where((a) => !a.isNaN), isNotEmpty);
      expect(server.requested.single.queryParameters['latitude'], '25.6700');
    });

    test('error de la API con mensaje', () async {
      final server = FakeServer()
        ..routes['hourly'] = (422, '{"messages": ["fecha inválida"]}');
      expect(
        () => NasaPowerClient(client: server.client).fetchHourly(
          latitude: 0,
          longitude: 0,
          yearStart: 2024,
          yearEnd: 2024,
        ),
        throwsA(
          isA<DataSourceException>()
              .having((e) => e.statusCode, 'código', 422)
              .having((e) => e.message, 'mensaje', contains('fecha inválida')),
        ),
      );
    });

    test('reintenta ante 429 y luego responde', () async {
      var n = 0;
      final server = FakeServer();
      final client = NasaPowerClient(
        client: server.client,
        retryDelays: const [Duration.zero, Duration.zero],
      );
      server.routes['hourly'] = (429, 'demasiadas');
      final f = client.fetchHourly(
        latitude: 25.67,
        longitude: -100.31,
        yearStart: 2024,
        yearEnd: 2024,
      );
      await expectLater(f, throwsA(isA<DataSourceException>()));
      n = server.calls;
      expect(n, 3); // 1 intento + 2 reintentos
    });
  });
}
