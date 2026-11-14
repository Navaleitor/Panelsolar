/// Zonas horarias IANA (p. ej. `America/Monterrey`).
abstract interface class TimeZoneService {
  /// Zona horaria del teléfono, o `null` si no se pudo leer.
  Future<String?> deviceTimeZone();

  /// Zona horaria deducida de las coordenadas, sin conexión (F2), o `null`
  /// si no se pudo deducir una zona válida.
  Future<String?> timeZoneAt(double latitude, double longitude);

  /// Desfase horario **estándar** (sin horario de verano) de [name] en
  /// horas, p. ej. −6 para `America/Monterrey`. `null` si no es válida.
  double? standardUtcOffsetHours(String name);

  /// Todas las zonas válidas, ordenadas.
  List<String> allTimeZones();

  /// `true` si [name] es una zona IANA conocida.
  bool isValid(String name);
}
