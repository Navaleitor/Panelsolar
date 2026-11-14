import 'dart:io';

import 'package:data_sources/data_sources.dart';
import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  late Directory tmp;
  setUp(() => tmp = Directory.systemTemp.createTempSync('ps_cache'));
  tearDown(() => tmp.deleteSync(recursive: true));

  group('ProjectCache', () {
    test('escribe y lee comprimido; ids raros se sanean', () async {
      final cache = ProjectCache(tmp);
      await cache.write('proy/1', 'clave x', {'a': 1});
      expect(await cache.read('proy/1', 'clave x'), {'a': 1});
      expect(cache.sizeOf('proy/1', 'clave x'), greaterThan(0));
      expect(await cache.read('proy/1', 'otra'), isNull);
      expect(cache.sizeOf('proy/1', 'otra'), 0);
      await cache.clearProject('proy/1');
      expect(await cache.read('proy/1', 'clave x'), isNull);
    });

    test('archivo dañado se trata como ausente', () async {
      final cache = ProjectCache(tmp);
      File('${tmp.path}/p/k.json.gz')
        ..createSync(recursive: true)
        ..writeAsStringSync('basura');
      expect(await cache.read('p', 'k'), isNull);
    });
  });

  group('WeatherDataset JSON', () {
    test('ida y vuelta conserva datos y NaN', () {
      final d = NasaPowerClient.parse(
        fixture('nasa_power_hourly.json'),
        latitude: 25.67,
        longitude: -100.31,
        yearStart: 2024,
        yearEnd: 2024,
        accessedAt: DateTime.utc(2026, 11, 10),
      );
      final back = WeatherDataset.fromJson(d.toJson());
      expect(back.series.length, d.series.length);
      expect(back.version, d.version);
      expect(back.accessedAt, d.accessedAt);
      expect(back.series.ghi[18].isNaN, d.series.ghi[18].isNaN);
      expect(back.series.tempAir[10], closeTo(d.series.tempAir[10], 0.006));
      expect(back.series.albedo, isNotNull);
      expect(back.series.sampleOffsetMinutes, 30);
    });
  });

  group('WeatherRepository', () {
    FakeServer serverOk() => FakeServer()
      ..routes['hourly'] = (200, fixture('nasa_power_hourly.json'))
      ..routes['/tmy'] = (200, fixture('pvgis_tmy.json'))
      ..routes['printhorizon'] = (200, fixture('pvgis_horizon.json'));

    WeatherRepository repo(FakeServer s) => WeatherRepository(
      nasa: NasaPowerClient(client: s.client, retryDelays: const []),
      pvgis: PvgisClient(client: s.client, retryDelays: const []),
      cache: ProjectCache(tmp),
      clock: () => DateTime.utc(2026, 11, 10),
    );

    test('descarga, revisa, compara y guarda en caché', () async {
      final server = serverOk();
      final climate = await repo(server)
          .load(projectId: 'p1', site: fixtureSite);
      expect(server.calls, 3);
      expect(climate.primary.source, WeatherSource.nasaPower);
      expect(climate.primary.series.length, 48);
      expect(climate.tmy, isNotNull);
      expect(climate.horizon, isNotNull);
      expect(climate.primaryQuality.missingRecords, 1);
      expect(climate.attributions.length, 3);
      expect(
        climate.attributions[1],
        contains('v2.10.4 version on 2026/11/10'),
      );
      expect(climate.warnings, isNotEmpty);
      // Con 2 días no hay meses completos: la comparación no advierte.
      expect(climate.crossCheck, isNotNull);
      expect(climate.crossCheck!.exceedsThreshold, isFalse);
      expect(server.requested.first.queryParameters['start'], '20210101');

      // Segunda carga: todo desde la caché, sin red.
      final again = await repo(server).load(projectId: 'p1', site: fixtureSite);
      expect(server.calls, 3);
      expect(again.horizon!.points.length, climate.horizon!.points.length);
      expect(again.primary.series.length, 48);

      // Forzar actualización vuelve a descargar.
      await repo(server)
          .load(projectId: 'p1', site: fixtureSite, forceRefresh: true);
      expect(server.calls, 6);
    });

    test('otra ubicación en el mismo proyecto invalida la caché', () async {
      final server = serverOk();
      await repo(server).load(projectId: 'p1', site: fixtureSite);
      await repo(server).load(
        projectId: 'p1',
        site: const Site(latitude: 25.7, longitude: -100.31),
      );
      expect(server.calls, 6);
    });

    test('si NASA falla se usa el TMY de PVGIS', () async {
      final server = serverOk()..routes['hourly'] = (500, 'caído');
      final climate = await repo(server)
          .load(projectId: 'p2', site: fixtureSite);
      expect(climate.primary.source, WeatherSource.pvgisTmy);
      expect(climate.crossCheck, isNull);
      expect(climate.attributions.single, contains('PVGIS'));
      expect(climate.warnings.join(' '), contains('NASA POWER falló'));
    });

    test('si todo falla lanza error', () async {
      final server = FakeServer();
      await expectLater(
        repo(server).load(projectId: 'p3', site: fixtureSite),
        throwsA(isA<DataSourceException>()),
      );
    });
  });

  group('Atribuciones', () {
    test('textos oficiales', () {
      expect(
        Attributions.nasaPowerReference,
        contains('Langley Research Center'),
      );
      expect(
        Attributions.nasaPowerDataReference(
          'v2.10.4',
          DateTime.utc(2026, 3, 5),
        ),
        "The data was obtained from the POWER Project's Hourly v2.10.4 version on 2026/03/05.",
      );
      expect(
        Attributions.pvgis(DateTime.utc(2026)),
        contains('2001–2026 (CC BY 4.0)'),
      );
      expect(DataSourcesInfo.name, 'data_sources');
    });
  });

  test('User-Agent identifica a la app sin datos personales', () {
    expect(panelsolarUserAgent, startsWith('Panelsolar/'));
    expect(
      const DataSourceException('x', statusCode: 1).toString(),
      contains('x'),
    );
    expect(HorizonProfile.flat().elevationAt(0), 0);
  });
}
