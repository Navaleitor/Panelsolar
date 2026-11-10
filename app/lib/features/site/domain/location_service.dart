import 'package:panelsolar/features/site/domain/location_candidate.dart';

/// Por qué no se pudo leer el GPS.
enum LocationFailure {
  /// La ubicación del teléfono está apagada.
  serviceDisabled,

  /// El usuario negó el permiso (se puede volver a pedir).
  permissionDenied,

  /// El permiso se negó para siempre: hay que ir a Ajustes del sistema.
  permissionDeniedForever,

  /// No hubo lectura a tiempo.
  timeout,
}

/// Error al leer el GPS.
class LocationException implements Exception {
  const new(this.failure);

  final LocationFailure failure;

  @override
  String toString() => 'LocationException($failure)';
}

/// Acceso al GPS del teléfono (interfaz para poder probar sin hardware).
abstract interface class LocationService {
  /// Lectura actual con alta precisión. Lanza [LocationException].
  Future<LocationCandidate> currentPosition();

  /// Última posición conocida (rápida, puede ser `null`). No pide permiso
  /// ni lanza errores: se usa para etiquetar fotos.
  Future<LocationCandidate?> lastKnownPosition();
}
