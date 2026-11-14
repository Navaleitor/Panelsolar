/// Velocidad regional de viento de una ciudad.
typedef RegionalWindSpeed = ({String city, String state, double kmh});

/// Velocidades regionales de referencia en México para un periodo de
/// retorno de 50 años (estructuras del grupo B), en km/h.
///
/// **Son valores de referencia aproximados**: el instalador debe
/// verificarlos en el *Manual de Diseño de Obras Civiles CFE – Diseño por
/// Viento (2020)* y puede editarlos en la app. Ficha 26.
abstract final class MexicoWindSpeeds {
  /// Nombre de la fuente.
  static const String source =
      'Manual de Diseño de Obras Civiles CFE – Diseño por Viento (2020)';

  /// Ciudades con su velocidad de referencia.
  static const List<RegionalWindSpeed> cities = [
    (city: 'Monterrey', state: 'Nuevo León', kmh: 143),
    (city: 'Saltillo', state: 'Coahuila', kmh: 140),
    (city: 'Torreón', state: 'Coahuila', kmh: 140),
    (city: 'Chihuahua', state: 'Chihuahua', kmh: 140),
    (city: 'Hermosillo', state: 'Sonora', kmh: 150),
    (city: 'Tijuana', state: 'Baja California', kmh: 130),
    (city: 'Ciudad de México', state: 'CDMX', kmh: 115),
    (city: 'Guadalajara', state: 'Jalisco', kmh: 125),
    (city: 'Puebla', state: 'Puebla', kmh: 118),
    (city: 'Querétaro', state: 'Querétaro', kmh: 125),
    (city: 'León', state: 'Guanajuato', kmh: 125),
    (city: 'San Luis Potosí', state: 'San Luis Potosí', kmh: 130),
    (city: 'Veracruz', state: 'Veracruz', kmh: 180),
    (city: 'Mérida', state: 'Yucatán', kmh: 160),
    (city: 'Cancún', state: 'Quintana Roo', kmh: 200),
  ];

  /// Velocidad por defecto si no se conoce la ciudad (km/h).
  static const double defaultKmh = 140;

  /// Busca una ciudad (sin distinguir mayúsculas ni acentos).
  static RegionalWindSpeed? find(String city) {
    final q = _plain(city);
    for (final c in cities) {
      if (_plain(c.city) == q) return c;
    }
    return null;
  }

  static String _plain(String s) => s
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ú', 'u')
      .trim();
}
