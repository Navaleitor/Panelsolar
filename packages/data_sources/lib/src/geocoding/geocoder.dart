/// Un resultado de geocodificación: coordenadas y nombre legible.
class GeocodeResult {
  /// Crea un resultado.
  const new({
    required this.latitude,
    required this.longitude,
    required this.displayName,
  });

  /// Lee un resultado guardado con [toJson].
  factory fromJson(Map<String, Object?> json) => GeocodeResult(
    latitude: (json['lat']! as num).toDouble(),
    longitude: (json['lon']! as num).toDouble(),
    displayName: json['name']! as String,
  );

  /// Latitud WGS84 en grados.
  final double latitude;

  /// Longitud WGS84 en grados.
  final double longitude;

  /// Dirección o nombre del lugar tal como lo da el servicio.
  final String displayName;

  /// Forma serializable (para la caché).
  Map<String, Object?> toJson() => {
    'lat': latitude,
    'lon': longitude,
    'name': displayName,
  };
}

/// Por qué falló una búsqueda.
enum GeocodingFailure {
  /// Sin conexión o tiempo agotado.
  network,

  /// El servicio pidió bajar el ritmo (HTTP 429) o bloqueó (HTTP 403).
  rateLimited,

  /// Respuesta inesperada del servicio.
  badResponse,
}

/// Error de geocodificación con su causa.
class GeocodingException implements Exception {
  /// Crea el error.
  const new(this.failure, [this.detail]);

  /// Causa.
  final GeocodingFailure failure;

  /// Detalle técnico (para registro, no para la UI).
  final String? detail;

  @override
  String toString() => 'GeocodingException($failure, $detail)';
}

/// Convierte una dirección en coordenadas. Interfaz intercambiable
/// (ADR-004): hoy Nominatim público; en F7 se decide el servicio comercial
/// sin tocar las pantallas.
abstract interface class Geocoder {
  /// Busca [query] y devuelve hasta [limit] resultados (puede ser vacía).
  /// [languageCode] (p. ej. `es`) pide los nombres en ese idioma.
  ///
  /// Lanza [GeocodingException] si falla.
  Future<List<GeocodeResult>> search(
    String query, {
    String? languageCode,
    int limit = 5,
  });

  /// Texto de atribución que la UI debe mostrar junto a los resultados.
  String get attribution;
}
