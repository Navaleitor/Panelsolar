import 'package:solar_engine/src/irradiance/atmosphere.dart';

/// Ubicación geográfica del sistema.
class Site {
  /// Crea un sitio.
  ///
  /// - [latitude], [longitude]: grados (norte y este positivos).
  /// - [elevation]: metros sobre el nivel del mar.
  /// - [_utcOffsetHours]: desfase de la hora estándar local (sin horario de
  ///   verano). Si es nulo se estima como round(longitud/15).
  /// - [meanTemperatureC]: temperatura media anual, solo para la refracción.
  const new({
    required this.latitude,
    required this.longitude,
    this.elevation = 0,
    this._utcOffsetHours,
    this.meanTemperatureC = 12,
  });

  /// Latitud (grados).
  final double latitude;

  /// Longitud (grados).
  final double longitude;

  /// Altitud (m).
  final double elevation;

  /// Temperatura media (°C) para la refracción atmosférica.
  final double meanTemperatureC;

  final double? _utcOffsetHours;

  /// Desfase horario estándar (h).
  double get utcOffsetHours =>
      _utcOffsetHours ?? (longitude / 15).roundToDouble();

  /// Presión estándar a la altitud del sitio (hPa).
  double get pressureHpa => altitudeToPressure(elevation) / 100;

  /// Verdadero si el sitio está en el hemisferio sur.
  bool get isSouthernHemisphere => latitude < 0;

  /// Azimut que mira al ecuador: 180° (sur) en el hemisferio norte y 0° en
  /// el sur.
  double get equatorFacingAzimuth => isSouthernHemisphere ? 0 : 180;
}
