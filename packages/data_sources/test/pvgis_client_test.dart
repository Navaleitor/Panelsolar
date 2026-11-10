import 'package:data_sources/data_sources.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  group('PvgisClient', () {
    test('TMY: columnas, base de datos y años', () async {
      final server = FakeServer()
        ..routes['/tmy'] = (200, fixture('pvgis_tmy.json'));
      final d = await PvgisClient(client: server.client).fetchTmy(
        latitude: 25.67,
        longitude: -100.31,
        now: DateTime.utc(2026, 11, 10),
      );
      expect(d.source, WeatherSource.pvgisTmy);
      expect(d.series.length, 48);
      expect(d.radiationDatabase, 'PVGIS-ERA5');
      expect((d.yearStart, d.yearEnd), (2005, 2023));
      expect(d.elevation, 534);
      expect(
        d.series.startEpochSeconds.first,
        DateTime.utc(2016).millisecondsSinceEpoch ~/ 1000,
      );
      expect(d.series.tempAir.first, closeTo(15.02, 1e-9));
      expect(server.requested.single.path, '/api/v5_3/tmy');
    });

    test('horizonte: azimut convertido a desde el norte', () async {
      final server = FakeServer()
        ..routes['printhorizon'] = (200, fixture('pvgis_horizon.json'));
      final h = await PvgisClient(client: server.client)
          .fetchHorizon(latitude: 25.67, longitude: -100.31);
      expect(h.points.length, 48); // −180 y 180 son el mismo azimut (norte)
      expect(h.points.first.azimuth, 0);
      for (final p in h.points) {
        expect(p.elevation, greaterThanOrEqualTo(0));
      }
    });

    test('error 400 con mensaje de PVGIS', () {
      final server = FakeServer()
        ..routes['/tmy'] = (400, '{"message": "Location over the sea"}');
      expect(
        () =>
            PvgisClient(client: server.client)
                .fetchTmy(latitude: 0, longitude: 0),
        throwsA(
          isA<DataSourceException>().having(
            (e) => e.message,
            'mensaje',
            contains('Location over the sea'),
          ),
        ),
      );
    });
  });
}
