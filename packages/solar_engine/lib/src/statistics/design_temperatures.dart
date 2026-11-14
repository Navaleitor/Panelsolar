import 'package:solar_engine/src/statistics/climate_statistics.dart';

/// Temperaturas para diseñar strings combinando varias fuentes de clima.
///
/// Decisión del dueño (2026-11-14): por defecto se usa la **más extrema**
/// (la mínima más fría y la máxima más caliente) y se conservan los valores
/// de cada fuente para mostrarlos. Ficha: docs/formulas/13-estadisticas-climaticas.md
class SiteDesignTemperatures {
  /// Combina las temperaturas de diseño de cada fuente ([bySource]: nombre
  /// de la fuente → temperaturas). Ignora valores `NaN`.
  factory mostExtreme(Map<String, DesignTemperatures> bySource) {
    String? minSource;
    String? maxSource;
    var min = double.nan;
    var max = double.nan;
    for (final e in bySource.entries) {
      final t = e.value;
      if (!t.recordMin.isNaN && (min.isNaN || t.recordMin < min)) {
        min = t.recordMin;
        minSource = e.key;
      }
      if (!t.recordMax.isNaN && (max.isNaN || t.recordMax > max)) {
        max = t.recordMax;
        maxSource = e.key;
      }
    }
    return SiteDesignTemperatures._(
      Map.unmodifiable(bySource),
      min,
      max,
      minSource,
      maxSource,
    );
  }

  new _(this.bySource, this.min, this.max, this.minSource, this.maxSource);

  /// Temperaturas de cada fuente (para mostrarlas todas).
  final Map<String, DesignTemperatures> bySource;

  /// Temperatura mínima de diseño (°C): la más fría de todas las fuentes.
  final double min;

  /// Temperatura máxima de diseño (°C): la más caliente de todas.
  final double max;

  /// Fuente de la que sale [min] (nulo si no hay datos).
  final String? minSource;

  /// Fuente de la que sale [max] (nulo si no hay datos).
  final String? maxSource;
}
