import 'package:data_sources/src/attribution/attributions.dart';
import 'package:data_sources/src/cache/project_cache.dart';
import 'package:data_sources/src/http/retrying_get.dart';
import 'package:data_sources/src/quality/quality_report.dart';
import 'package:data_sources/src/quality/weather_quality_control.dart';
import 'package:data_sources/src/weather/nasa_power_client.dart';
import 'package:data_sources/src/weather/pvgis_client.dart';
import 'package:data_sources/src/weather/weather_dataset.dart';
import 'package:solar_engine/solar_engine.dart';

/// Clima de un sitio listo para simular.
class SiteClimate {
  /// Crea el resultado.
  const new({
    required this.primary,
    required this.primaryQuality,
    required this.warnings,
    this.tmy,
    this.horizon,
    this.crossCheck,
  });

  /// Serie principal ya limpia (NASA POWER 5 años; TMY si NASA falló).
  final WeatherDataset primary;

  /// Control de calidad de la serie principal.
  final QualityReport primaryQuality;

  /// TMY de PVGIS (validación cruzada), si se pudo descargar.
  final WeatherDataset? tmy;

  /// Horizonte del terreno de PVGIS, si se pudo descargar.
  final HorizonProfile? horizon;

  /// Comparación anual NASA vs. PVGIS.
  final CrossSourceCheck? crossCheck;

  /// Advertencias para el usuario (en español).
  final List<String> warnings;

  /// Textos de atribución de las fuentes usadas.
  List<String> get attributions => [
    ...Attributions.forDataset(primary),
    if (tmy != null && tmy!.source != primary.source)
      ...Attributions.forDataset(tmy!),
  ];
}

/// Obtiene el clima de un proyecto: primero de la caché y, si no está,
/// lo descarga (NASA POWER + PVGIS), lo revisa y lo guarda comprimido.
class WeatherRepository {
  /// Crea el repositorio.
  new({
    required this.nasa,
    required this.pvgis,
    required this.cache,
    DateTime Function()? clock,
  }) : _clock = clock ?? (() => DateTime.now().toUtc());

  /// Cliente NASA POWER.
  final NasaPowerClient nasa;

  /// Cliente PVGIS.
  final PvgisClient pvgis;

  /// Caché por proyecto.
  final ProjectCache cache;

  final DateTime Function() _clock;

  /// Carga el clima del sitio. Con [forceRefresh] ignora la caché.
  Future<SiteClimate> load({
    required String projectId,
    required Site site,
    bool forceRefresh = false,
  }) async {
    final warnings = <String>[];
    final years = NasaPowerClient.lastCompleteYears(_clock());
    final nasaKey = 'nasa_power_${years.start}_${years.end}';

    final nasaData = await _cached(
      projectId,
      nasaKey,
      site,
      forceRefresh,
      () => nasa.fetchHourly(
        latitude: site.latitude,
        longitude: site.longitude,
        yearStart: years.start,
        yearEnd: years.end,
        now: _clock(),
      ),
      warnings,
    );
    final tmyData = await _cached(
      projectId,
      'pvgis_tmy',
      site,
      forceRefresh,
      () => pvgis.fetchTmy(
        latitude: site.latitude,
        longitude: site.longitude,
        now: _clock(),
      ),
      warnings,
    );
    final horizon = await _horizon(projectId, site, forceRefresh, warnings);

    final primaryRaw = nasaData ?? tmyData;
    if (primaryRaw == null) {
      throw const DataSourceException(
        'No se pudo obtener el clima de NASA POWER ni de PVGIS.',
      );
    }
    if (nasaData == null) {
      warnings.add('Se usa el año típico de PVGIS porque NASA POWER falló.');
    }
    final qc = WeatherQualityControl.check(primaryRaw.series, site);
    warnings.addAll(qc.report.warnings);
    WeatherDataset? tmyClean;
    CrossSourceCheck? cross;
    if (tmyData != null) {
      tmyClean = tmyData.withSeries(
        WeatherQualityControl.check(tmyData.series, site).series,
      );
      if (nasaData != null) {
        cross = WeatherQualityControl.compareAnnual(
          qc.series,
          tmyClean.series,
          site,
        );
        warnings.addAll(cross.warnings);
      }
    }
    return SiteClimate(
      primary: primaryRaw.withSeries(qc.series),
      primaryQuality: qc.report,
      tmy: tmyClean,
      horizon: horizon,
      crossCheck: cross,
      warnings: warnings,
    );
  }

  Future<WeatherDataset?> _cached(
    String projectId,
    String key,
    Site site,
    bool force,
    Future<WeatherDataset> Function() download,
    List<String> warnings,
  ) async {
    if (!force) {
      final json = await cache.read(projectId, key);
      if (json is Map<String, dynamic>) {
        final d = WeatherDataset.fromJson(json);
        if ((d.latitude - site.latitude).abs() < 1e-4 &&
            (d.longitude - site.longitude).abs() < 1e-4) {
          return d;
        }
      }
    }
    try {
      final d = await download();
      await cache.write(projectId, key, d.toJson());
      return d;
    } on DataSourceException catch (e) {
      warnings.add(e.message);
      return null;
    }
  }

  Future<HorizonProfile?> _horizon(
    String projectId,
    Site site,
    bool force,
    List<String> warnings,
  ) async {
    const key = 'pvgis_horizon';
    if (!force) {
      final json = await cache.read(projectId, key);
      if (json is Map<String, dynamic> &&
          json['lat'] == site.latitude &&
          json['lon'] == site.longitude) {
        return HorizonProfile([
          for (final p in (json['points'] as List).cast<List<dynamic>>())
            (
              azimuth: (p[0] as num).toDouble(),
              elevation: (p[1] as num).toDouble(),
            ),
        ]);
      }
    }
    try {
      final h = await pvgis.fetchHorizon(
        latitude: site.latitude,
        longitude: site.longitude,
      );
      await cache.write(projectId, key, {
        'lat': site.latitude,
        'lon': site.longitude,
        'points': [
          for (final p in h.points) [p.azimuth, p.elevation],
        ],
      });
      return h;
    } on DataSourceException catch (e) {
      warnings.add('Horizonte no disponible: ${e.message}');
      return null;
    }
  }
}
