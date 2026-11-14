import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:data_sources/data_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:panelsolar/features/weather/data/weather_job.dart';
import 'package:panelsolar/features/weather/data/weather_providers.dart';
import 'package:panelsolar/features/weather/domain/weather_analysis.dart';
import 'package:persistence/persistence.dart' as db;

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';
import 'weather_test_data.dart';

typedef Runner = Future<WeatherAnalysis> Function(WeatherJob, String);

void main() {
  late WeatherAnalysis canned;
  late Directory cacheDir;

  setUpAll(() {
    canned = analyzeClimate(monterreyClimate(), monterrey, year: 2026);
  });
  setUp(() => cacheDir = Directory.systemTemp.createTempSync('ps_weather'));
  tearDown(() => cacheDir.deleteSync(recursive: true));

  Future<void> pump(WidgetTester tester, Runner runner, {TestEnv? env}) =>
      tester.pumpPanelsolar(
        env: env,
        extraOverrides: [
          weatherCacheDirProvider.overrideWith((ref) async => cacheDir.path),
          weatherRunnerProvider.overrideWithValue(runner),
        ],
      );

  Future<void> openFromSettings(WidgetTester tester, Runner runner) async {
    await pump(tester, runner);
    await tester.tap(find.text('Ajustes'));
    await tester.pumpAndSettle();
    await tester.tapKey('settingsWeatherEntry');
  }

  Future<void> tapAndWait(WidgetTester tester, Finder until) async {
    await tester.tapKey('weatherAnalyze');
    for (var i = 0; i < 50 && until.evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 20));
    }
  }

  Future<void> openProjectWeather(WidgetTester tester) async {
    await openProject(tester);
    await tester.dragUntilVisible(
      find.byKey(const Key('project-weather')),
      find.byType(ListView).first,
      const Offset(0, -300),
    );
    await tester.tapKey('project-weather');
  }

  Finder list() => find
      .descendant(
        of: find.byKey(const Key('weatherList')),
        matching: find.byType(Scrollable),
      )
      .first;

  testWidgets('desde Ajustes: coordenadas a mano, resultados y fuentes', (
    tester,
  ) async {
    WeatherJob? received;
    await openFromSettings(tester, (job, dir) async {
      received = job;
      return canned;
    });
    expect(find.widgetWithText(AppBar, 'Clima y producción'), findsOneWidget);

    await tapAndWait(tester, find.byKey(const Key('weatherAnnual')));
    expect(received!.projectId, weatherManualCacheId);
    expect(received!.latitude, closeTo(25.6866, 1e-9));
    // Sin altitud: el motor usa internamente la de la fuente, sin error.
    expect(received!.elevation, isNull);
    // El servicio falso no deduce zona: se estima por la longitud.
    expect(received!.timeZone, isNull);
    expect(received!.utcOffsetHours, isNull);
    expect(received!.forceRefresh, isFalse);
    final annual = canned.annualEnergy.toStringAsFixed(0);
    expect(find.text('$annual kWh por kWp al año'), findsOneWidget);
    expect(find.byKey(const Key('weatherOptimal')), findsOneWidget);

    final design = canned.designTemperatures;
    await tester.scrollUntilVisible(
      find.byKey(const Key('weatherDesignMax')),
      300,
      scrollable: list(),
    );
    expect(
      find.text(
        'Mínima para diseño: ${design.min.toStringAsFixed(1)} °C '
        '(${design.minSource})',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('NASA POWER: mínima'), findsOneWidget);
    expect(find.textContaining('PVGIS: mínima'), findsOneWidget);
    for (final text in ['Solsticio de junio', '• Advertencia de prueba']) {
      await tester.scrollUntilVisible(find.text(text), 300, scrollable: list());
    }
    await tester.scrollUntilVisible(
      find.textContaining('PVGIS © Unión Europea'),
      300,
      scrollable: list(),
    );
    await tester.scrollUntilVisible(
      find.text('Volver a descargar'),
      -300,
      scrollable: list(),
    );
    await tester.tap(find.text('Volver a descargar'));
    await tester.pumpAndSettle();
    expect(received!.forceRefresh, isTrue);
  });

  testWidgets('desde el proyecto usa su ubicación y altitud', (tester) async {
    final env = TestEnv();
    final (_, project) = await seedClientWithProject(tester, env);
    await tester.runAsync(
      () => db.SiteRepository(env.db).save(
        projectId: project.id,
        latitude: 40.4168,
        longitude: -3.7038,
        altitudeM: 667,
        timeZone: 'America/Hermosillo',
        source: db.LocationSource.manual,
      ),
    );
    WeatherJob? received;
    await pump(tester, (job, dir) async {
      received = job;
      return canned;
    }, env: env);
    await openProjectWeather(tester);

    expect(find.text('Ubicación guardada del proyecto:'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '40.4168'), findsOneWidget);
    await tapAndWait(tester, find.byKey(const Key('weatherAnnual')));
    expect(received!.projectId, project.id);
    expect(received!.latitude, 40.4168);
    expect(received!.longitude, -3.7038);
    expect(received!.elevation, 667);
    // Zona guardada del proyecto → su desfase estándar (sin horario de verano).
    expect(received!.timeZone, 'America/Hermosillo');
    expect(received!.utcOffsetHours, -7);
  });

  testWidgets('proyecto sin ubicación: avisa y deja escribirla', (
    tester,
  ) async {
    final env = TestEnv();
    final (_, project) = await seedClientWithProject(tester, env);
    WeatherJob? received;
    await pump(tester, (job, dir) async {
      received = job;
      return canned;
    }, env: env);
    await openProjectWeather(tester);

    expect(find.textContaining('todavía no tiene ubicación'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('weatherLat')), '19.43');
    await tester.enterText(find.byKey(const Key('weatherLon')), '-99,13');
    await tapAndWait(tester, find.byKey(const Key('weatherAnnual')));
    expect(received!.projectId, project.id);
    expect(received!.latitude, 19.43);
    expect(received!.longitude, -99.13);
  });

  testWidgets('muestra el progreso mientras calcula', (tester) async {
    final pending = Completer<WeatherAnalysis>();
    await openFromSettings(tester, (job, dir) => pending.future);
    await tester.tap(find.byKey(const Key('weatherAnalyze')));
    await tester.pump();
    await tester.pump();
    expect(find.text('Descargando clima y simulando…'), findsOneWidget);
    pending.complete(canned);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('weatherAnnual')), findsOneWidget);
  });

  testWidgets('coordenada inválida no consulta', (tester) async {
    var calls = 0;
    await openFromSettings(tester, (job, dir) async {
      calls++;
      return canned;
    });
    await tester.enterText(find.byKey(const Key('weatherLat')), '95');
    await tester.enterText(find.byKey(const Key('weatherLon')), 'abc');
    await tester.tap(find.byKey(const Key('weatherAnalyze')));
    await tester.pumpAndSettle();
    expect(find.text('Escribe un número válido'), findsNWidgets(2));
    expect(calls, 0);
  });

  testWidgets('si fallan las fuentes muestra el error en palabras simples', (
    tester,
  ) async {
    await openFromSettings(
      tester,
      (job, dir) async => throw const DataSourceException(
        'No se pudo obtener el clima de NASA POWER ni de PVGIS.',
      ),
    );
    final error = find.textContaining('No se pudo obtener el clima de NASA');
    await tapAndWait(tester, error);
    expect(error, findsOneWidget);
    expect(find.textContaining('DataSourceException'), findsNothing);
  });

  test('runWeatherJob: descarga con cliente falso y guarda caché', () async {
    const fixtures = '../packages/data_sources/test/fixtures';
    var calls = 0;
    final client = MockClient((r) async {
      calls++;
      final path = r.url.path;
      final name = path.contains('hourly')
          ? 'nasa_power_hourly.json'
          : (path.contains('tmy') ? 'pvgis_tmy.json' : 'pvgis_horizon.json');
      return http.Response.bytes(
        File('$fixtures/$name').readAsBytesSync(),
        200,
      );
    });
    const job = (
      projectId: 'p1',
      latitude: 25.67,
      longitude: -100.31,
      elevation: 540.0,
      timeZone: 'America/Monterrey',
      utcOffsetHours: -6.0,
      forceRefresh: false,
    );
    final a = await runWeatherJob(
      job,
      cacheDir.path,
      client: client,
      year: 2026,
    );
    expect(calls, 3);
    expect(a.sourceLabel, startsWith('NASA POWER'));
    expect(a.attributions.length, 3);
    expect(a.sunPath.length, 4);
    expect(Directory('${cacheDir.path}/p1').listSync().length, 3);
  });

  test('el análisis también funciona dentro de un isolate', () async {
    final a = await Isolate.run(
      () => analyzeClimate(monterreyClimate(), monterrey, year: 2026),
    );
    expect(a.annualEnergy, closeTo(canned.annualEnergy, 1e-6));
  });
}
