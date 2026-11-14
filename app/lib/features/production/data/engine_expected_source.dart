import 'package:panelsolar/features/production/domain/expected_production_source.dart';
import 'package:panelsolar/features/weather/data/weather_job.dart';
import 'package:persistence/persistence.dart';

/// Energía mensual típica (12 valores, kWh) de 1 kWp según el análisis de
/// clima de F2 (descarga o lee la caché del proyecto).
typedef MonthlyEnergyPerKwp = Future<List<double>> Function(WeatherJob job);

/// [ExpectedProductionSource] con el motor de F2: energía mensual típica
/// de 1 kWp en la orientación óptima del sitio × kWp del proyecto.
///
/// Usa la caché de clima del proyecto si ya se consultó en "Clima y
/// producción"; si no, intenta descargarla (si no hay red, no propone
/// nada y el usuario escribe el valor). El resultado queda en memoria.
class EngineExpectedSource implements ExpectedProductionSource {
  new({required this.sites, required this.production, required this.analyze});

  final SiteRepository sites;
  final ProductionRepository production;
  final MonthlyEnergyPerKwp analyze;
  final _cache = <String, List<double>>{};

  @override
  Future<({double expectedKwh, double? poaKwhM2})?> expectedFor(
    String projectId,
    DateTime month,
  ) async {
    final kwp = (await production.watchSettings(projectId).first)?.systemKwp;
    if (kwp == null) return null;
    final site = await sites.watchForProject(projectId).first;
    if (site == null) return null;
    try {
      final monthly = _cache[projectId] ??= await analyze((
        projectId: projectId,
        latitude: site.latitude,
        longitude: site.longitude,
        elevation: site.altitudeM,
        timeZone: null,
        utcOffsetHours: null,
        forceRefresh: false,
      ));
      final perKwp = monthly[month.month - 1];
      return (expectedKwh: perKwp * kwp, poaKwhM2: null);
    } on Object {
      return null;
    }
  }
}
