import 'dart:io';

import 'package:data_sources/data_sources.dart';
import 'package:http/http.dart' as http;
import 'package:panelsolar/features/weather/domain/weather_analysis.dart';
import 'package:solar_engine/solar_engine.dart';

/// Proyecto de prueba de F2. Cuando F1 integre proyectos, la caché usará el
/// id real del proyecto.
const String weatherDemoProjectId = 'f2_demo';

/// Petición de análisis de clima.
typedef WeatherJob = ({double latitude, double longitude, bool forceRefresh});

/// Trabajo completo: descarga (o lee de la caché en [cacheDir]), control
/// de calidad y análisis. Todo es Dart puro, así que la app lo ejecuta
/// entero dentro de un isolate (`Isolate.run`) y la pantalla no se traba.
///
/// [client] permite inyectar un cliente HTTP falso en las pruebas.
Future<WeatherAnalysis> runWeatherJob(
  WeatherJob job,
  String cacheDir, {
  http.Client? client,
  int? year,
}) async {
  final c = client ?? http.Client();
  try {
    final repo = WeatherRepository(
      nasa: NasaPowerClient(client: c),
      pvgis: PvgisClient(client: c),
      cache: ProjectCache(Directory(cacheDir)),
    );
    final climate = await repo.load(
      projectId: weatherDemoProjectId,
      site: Site(latitude: job.latitude, longitude: job.longitude),
      forceRefresh: job.forceRefresh,
    );
    // La altitud del punto la da PVGIS (modelo de terreno) o NASA.
    final site = Site(
      latitude: job.latitude,
      longitude: job.longitude,
      elevation: climate.tmy?.elevation ?? climate.primary.elevation ?? 0,
    );
    return analyzeClimate(climate, site, year: year);
  } finally {
    if (client == null) c.close();
  }
}
