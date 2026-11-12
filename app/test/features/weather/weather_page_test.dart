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

import '../../helpers/pump_app.dart';
import 'weather_test_data.dart';

void main() {
  late WeatherAnalysis canned;
  late Directory cacheDir;

  setUpAll(() {
    canned = analyzeClimate(monterreyClimate(), monterrey, year: 2026);
  });
  setUp(() => cacheDir = Directory.systemTemp.createTempSync('ps_weather'));
  tearDown(() => cacheDir.deleteSync(recursive: true));

  Future<void> openWeather(
    WidgetTester tester,
    Future<WeatherAnalysis> Function(WeatherJob, String) runner,
  ) async {
    await tester.pumpPanelsolar(
      overrides: [
        weatherCacheDirProvider.overrideWith((ref) async => cacheDir.path),
        weatherRunnerProvider.overrideWithValue(runner),
      ],
    );
    await tester.tap(find.text('Ajustes'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settingsWeatherEntry')));
    await tester.pumpAndSettle();
  }

  Future<void> tapAndWait(WidgetTester tester, Finder until) async {
    await tester.tap(find.byKey(const Key('weatherAnalyze')));
    await tester.pump();
    for (var i = 0; i < 50 && until.evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 20));
    }
  }

  testWidgets('Ajustes → Clima: calcula y muestra resultados', (tester) async {
    WeatherJob? received;
    await openWeather(tester, (job, dir) async {
      received = job;
      return canned;
    });
    expect(find.widgetWithText(AppBar, 'Clima y producción'), findsOneWidget);

    await tapAndWait(tester, find.byKey(const Key('weatherAnnual')));
    expect(received!.latitude, closeTo(25.6866, 1e-9));
    expect(received!.forceRefresh, isFalse);
    final annual = canned.annualEnergy.toStringAsFixed(0);
    expect(find.text('$annual kWh por kWp al año'), findsOneWidget);
    expect(find.byKey(const Key('weatherOptimal')), findsOneWidget);

    final list = find
        .descendant(
          of: find.byKey(const Key('weatherList')),
          matching: find.byType(Scrollable),
        )
        .first;
    await tester.scrollUntilVisible(
      find.text('Solsticio de junio'),
      300,
      scrollable: list,
    );
    await tester.scrollUntilVisible(
      find.text('• Advertencia de prueba'),
      300,
      scrollable: list,
    );
    await tester.scrollUntilVisible(
      find.textContaining('PVGIS © Unión Europea'),
      300,
      scrollable: list,
    );

    // "Volver a descargar" fuerza la actualización.
    await tester.scrollUntilVisible(
      find.text('Volver a descargar'),
      -300,
      scrollable: list,
    );
    await tester.tap(find.text('Volver a descargar'));
    await tester.pumpAndSettle();
    expect(received!.forceRefresh, isTrue);
  });

  testWidgets('muestra el progreso mientras calcula', (tester) async {
    final pending = Completer<WeatherAnalysis>();
    await openWeather(tester, (job, dir) => pending.future);
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
    await openWeather(tester, (job, dir) async {
      calls++;
      return canned;
    });
    await tester.enterText(find.byKey(const Key('weatherLat')), '95');
    await tester.enterText(find.byKey(const Key('weatherLon')), 'abc');
    await tester.tap(find.byKey(const Key('weatherAnalyze')));
    await tester.pumpAndSettle();
    expect(find.text('Escriba un número válido'), findsNWidgets(2));
    expect(calls, 0);
  });

  testWidgets('si fallan las fuentes muestra el error', (tester) async {
    await openWeather(
      tester,
      (job, dir) async =>
          throw const DataSourceException('No se pudo obtener el clima.'),
    );
    final error = find.textContaining('No se pudo obtener el clima');
    await tapAndWait(tester, error);
    expect(error, findsOneWidget);
  });

  test(
    'runWeatherJob: descarga con cliente falso, guarda caché y analiza',
    () async {
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
      const job = (latitude: 25.67, longitude: -100.31, forceRefresh: false);
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
      expect(
        Directory('${cacheDir.path}/$weatherDemoProjectId').listSync().length,
        3,
      );
    },
  );

  test('el análisis también funciona dentro de un isolate', () async {
    final a = await Isolate.run(
      () => analyzeClimate(monterreyClimate(), monterrey, year: 2026),
    );
    expect(a.annualEnergy, closeTo(canned.annualEnergy, 1e-6));
  });
}
