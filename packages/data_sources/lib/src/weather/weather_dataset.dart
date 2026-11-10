import 'dart:typed_data';

import 'package:solar_engine/solar_engine.dart';

/// Origen de una serie meteorológica.
enum WeatherSource {
  /// NASA POWER, serie horaria histórica.
  nasaPower,

  /// PVGIS 5.3, año meteorológico típico (TMY).
  pvgisTmy,
}

/// Serie meteorológica descargada con sus metadatos (para atribución y
/// caché).
class WeatherDataset {
  /// Crea el conjunto.
  const new({
    required this.source,
    required this.latitude,
    required this.longitude,
    required this.series,
    required this.version,
    required this.accessedAt,
    this.elevation,
    this.radiationDatabase,
    this.yearStart,
    this.yearEnd,
  });

  /// Reconstruye desde JSON (ver [toJson]).
  factory fromJson(Map<String, dynamic> json) {
    Float64List col(String k) => Float64List.fromList([
      for (final v in json[k] as List)
        if (v == null) double.nan else (v as num).toDouble(),
    ]);
    final albedo = json['albedo'] as List?;
    return WeatherDataset(
      source: WeatherSource.values.byName(json['source'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      elevation: (json['elevation'] as num?)?.toDouble(),
      version: json['version'] as String,
      accessedAt: DateTime.parse(json['accessedAt'] as String),
      radiationDatabase: json['radiationDatabase'] as String?,
      yearStart: json['yearStart'] as int?,
      yearEnd: json['yearEnd'] as int?,
      series: WeatherSeries(
        startEpochSeconds: [for (final v in json['epoch'] as List) v as int],
        ghi: col('ghi'),
        dni: col('dni'),
        dhi: col('dhi'),
        tempAir: col('tempAir'),
        windSpeed: col('windSpeed'),
        albedo: albedo == null ? null : col('albedo'),
      ),
    );
  }

  /// Fuente.
  final WeatherSource source;

  /// Latitud pedida (grados).
  final double latitude;

  /// Longitud pedida (grados).
  final double longitude;

  /// Altitud del punto de la fuente (m), si la informa.
  final double? elevation;

  /// Serie horaria.
  final WeatherSeries series;

  /// Versión de la API o del producto (p. ej. "v2.10.4" o "5.3").
  final String version;

  /// Fecha de descarga (para el texto de referencia de NASA).
  final DateTime accessedAt;

  /// Base de datos de radiación (PVGIS: "PVGIS-SARAH3", "PVGIS-ERA5"...).
  final String? radiationDatabase;

  /// Primer año de los datos.
  final int? yearStart;

  /// Último año de los datos.
  final int? yearEnd;

  /// Serializa a JSON (valores con 2 decimales; `NaN` → null).
  Map<String, dynamic> toJson() {
    List<double?> col(Float64List v) => [
      for (final x in v)
        if (x.isNaN) null else (x * 100).roundToDouble() / 100,
    ];
    final albedo = series.albedo;
    return {
      'source': source.name,
      'latitude': latitude,
      'longitude': longitude,
      'elevation': elevation,
      'version': version,
      'accessedAt': accessedAt.toUtc().toIso8601String(),
      'radiationDatabase': radiationDatabase,
      'yearStart': yearStart,
      'yearEnd': yearEnd,
      'epoch': series.startEpochSeconds,
      'ghi': col(series.ghi),
      'dni': col(series.dni),
      'dhi': col(series.dhi),
      'tempAir': col(series.tempAir),
      'windSpeed': col(series.windSpeed),
      if (albedo != null) 'albedo': col(albedo),
    };
  }

  /// Copia con otra serie (p. ej. tras el control de calidad).
  WeatherDataset withSeries(WeatherSeries newSeries) => WeatherDataset(
    source: source,
    latitude: latitude,
    longitude: longitude,
    elevation: elevation,
    series: newSeries,
    version: version,
    accessedAt: accessedAt,
    radiationDatabase: radiationDatabase,
    yearStart: yearStart,
    yearEnd: yearEnd,
  );
}
