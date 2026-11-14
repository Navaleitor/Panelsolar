import 'package:data_sources/data_sources.dart';
import 'package:solar_engine/solar_engine.dart';

/// Resultado de analizar el clima de un sitio para un sistema de referencia
/// de 1 kWp (relación DC/AC 1.2, pérdidas por defecto del plan B.6).
class WeatherAnalysis {
  /// Crea el resultado.
  const new({
    required this.latitude,
    required this.longitude,
    required this.optimalTilt,
    required this.optimalAzimuth,
    required this.annualEnergy,
    required this.monthlyEnergy,
    required this.latitudeTiltEnergy,
    required this.performanceRatio,
    required this.statistics,
    required this.designTemperatures,
    required this.sunPath,
    required this.warnings,
    required this.attributions,
    required this.sourceLabel,
    this.timeZone,
    this.utcOffsetHours,
  });

  /// Latitud (grados).
  final double latitude;

  /// Longitud (grados).
  final double longitude;

  /// Inclinación óptima (grados).
  final double optimalTilt;

  /// Azimut óptimo (grados desde el norte).
  final double optimalAzimuth;

  /// Producción anual con la orientación óptima (kWh por kWp).
  final double annualEnergy;

  /// Producción mensual con la orientación óptima (12 valores, kWh/kWp).
  final List<double> monthlyEnergy;

  /// Producción anual con la regla "inclinación = latitud" (referencia).
  final double latitudeTiltEnergy;

  /// Performance ratio del sistema de referencia.
  final double performanceRatio;

  /// Estadísticas climáticas (mensuales, por estación y de diseño).
  final ClimateStatistics statistics;

  /// Temperaturas para diseñar strings: la más extrema de NASA y PVGIS
  /// (decisión del dueño), con los valores de cada fuente.
  final SiteDesignTemperatures designTemperatures;

  /// Zona horaria IANA usada para los meses (nula = estimada por longitud).
  final String? timeZone;

  /// Desfase estándar usado (h).
  final double? utcOffsetHours;

  /// Trayectoria solar de los días característicos.
  final Map<SunPathDay, List<SunPathPoint>> sunPath;

  /// Advertencias del control de calidad y de la comparación de fuentes.
  final List<String> warnings;

  /// Atribuciones obligatorias de las fuentes.
  final List<String> attributions;

  /// Descripción corta de la serie usada (p. ej. "NASA POWER 2021–2025").
  final String sourceLabel;
}

/// Sistema de referencia: 1 kWp, DC/AC 1.2, inversor 96 %.
PvSystem referenceSystem({required double tilt, required double azimuth}) =>
    PvSystem.reference(tilt: tilt, azimuth: azimuth);

/// Analiza el clima ya descargado. Es una función pura y pesada: la app la
/// ejecuta en un isolate (`Isolate.run`) para no congelar la pantalla.
///
/// La búsqueda de orientación usa el TMY de PVGIS si existe (8760 h, más
/// rápido); la producción se calcula con la serie principal (5 años).
WeatherAnalysis analyzeClimate(
  SiteClimate climate,
  Site site, {
  int? year,
  String? timeZone,
}) {
  final inputs = SimulationInputs.prepare(
    site: site,
    weather: climate.primary.series,
    horizon: climate.horizon,
  );
  final tmy = climate.tmy;
  final searchInputs = tmy == null
      ? inputs
      : SimulationInputs.prepare(
          site: site,
          weather: tmy.series,
          horizon: climate.horizon,
        );
  final best = OrientationOptimizer(
    inputs: searchInputs,
    system: referenceSystem(tilt: 0, azimuth: site.equatorFacingAzimuth),
  ).optimize();
  final result = Simulator.run(
    inputs,
    referenceSystem(tilt: best.tilt, azimuth: best.azimuth),
  );
  final latitudeResult = Simulator.run(
    inputs,
    referenceSystem(
      tilt: site.latitude.abs(),
      azimuth: site.equatorFacingAzimuth,
    ),
  );
  final primary = climate.primary;
  final label = primary.source == WeatherSource.nasaPower
      ? 'NASA POWER ${primary.yearStart}–${primary.yearEnd}'
      : 'PVGIS ${primary.radiationDatabase ?? ''} TMY'.trim();
  final statistics = ClimateStatistics.compute(site, primary.series);
  final design = SiteDesignTemperatures.mostExtreme({
    _sourceName(primary): statistics.design,
    if (tmy != null && tmy.source != primary.source)
      _sourceName(tmy): ClimateStatistics.compute(site, tmy.series).design,
  });
  return WeatherAnalysis(
    latitude: site.latitude,
    longitude: site.longitude,
    optimalTilt: best.tilt,
    optimalAzimuth: best.azimuth,
    annualEnergy: result.annualAcEnergy,
    monthlyEnergy: result.monthlyAcEnergy,
    latitudeTiltEnergy: latitudeResult.annualAcEnergy,
    performanceRatio: result.performanceRatio,
    statistics: statistics,
    designTemperatures: design,
    timeZone: timeZone,
    utcOffsetHours: site.utcOffsetHours,
    sunPath: SunPath.characteristicDays(
      site,
      year ?? DateTime.now().year,
      stepMinutes: 15,
    ),
    warnings: climate.warnings,
    attributions: climate.attributions,
    sourceLabel: label,
  );
}

String _sourceName(WeatherDataset d) => switch (d.source) {
  WeatherSource.nasaPower => 'NASA POWER',
  WeatherSource.pvgisTmy => 'PVGIS',
};
