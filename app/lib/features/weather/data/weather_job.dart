import 'dart:io';

import 'package:data_sources/data_sources.dart';
import 'package:http/http.dart' as http;
import 'package:panelsolar/features/weather/domain/weather_analysis.dart';
import 'package:solar_engine/solar_engine.dart';

/// Carpeta de caché para coordenadas escritas a mano (sin proyecto).
const String weatherManualCacheId = 'sin_proyecto';

/// Petición de análisis de clima.
///
/// - `projectId`: proyecto dueño de la caché (o [weatherManualCacheId]).
/// - `elevation`: altitud conocida del sitio (m); si es nula se usa la de
///   PVGIS o NASA.
typedef WeatherJob = ({
  String projectId,
  double latitude,
  double longitude,
  double? elevation,
  bool forceRefresh,
});

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
      projectId: job.projectId,
      site: Site(latitude: job.latitude, longitude: job.longitude),
      forceRefresh: job.forceRefresh,
    );
    // Altitud: la del proyecto; si no, la de PVGIS (modelo de terreno) o NASA.
    final site = Site(
      latitude: job.latitude,
      longitude: job.longitude,
      elevation:
          job.elevation ??
          climate.tmy?.elevation ??
          climate.primary.elevation ??
          0,
    );
    return analyzeClimate(climate, site, year: year);
  } finally {
    if (client == null) c.close();
  }
}
