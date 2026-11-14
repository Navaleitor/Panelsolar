import 'dart:io';

import 'package:data_sources/data_sources.dart';
import 'package:http/http.dart' as http;
import 'package:panelsolar/features/design/domain/design_analysis.dart';
import 'package:panelsolar/features/design/domain/design_inputs.dart';
import 'package:solar_engine/solar_engine.dart';

/// Trabajo completo del análisis: carga el clima (caché o descarga) y
/// analiza. Dart puro: la app lo corre entero en un isolate.
Future<DesignJobResult> runDesignJob(
  DesignJobInput job,
  String cacheDir, {
  http.Client? client,
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
      site: Site(latitude: job.site.latitude, longitude: job.site.longitude),
      forceRefresh: job.forceRefresh,
    );
    return analyzeDesign(job, climate);
  } finally {
    if (client == null) c.close();
  }
}
