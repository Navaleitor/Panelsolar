import 'package:persistence/persistence.dart';

/// Ubicación propuesta, pendiente de que el usuario la confirme.
class LocationCandidate {
  const new({
    required this.latitude,
    required this.longitude,
    required this.source,
    this.altitudeM,
    this.accuracyM,
    this.sourceText,
    this.label,
  });

  /// Latitud WGS84 (grados).
  final double latitude;

  /// Longitud WGS84 (grados).
  final double longitude;

  /// De dónde salió.
  final LocationSource source;

  /// Altitud en metros, si se conoce (solo GPS).
  final double? altitudeM;

  /// Precisión horizontal del GPS en metros.
  final double? accuracyM;

  /// Texto original: dirección buscada o enlace pegado.
  final String? sourceText;

  /// Nombre legible (p. ej. la dirección que devolvió el geocodificador).
  final String? label;
}
