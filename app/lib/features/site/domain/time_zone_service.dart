/// Zonas horarias IANA (p. ej. `America/Monterrey`).
abstract interface class TimeZoneService {
  /// Zona horaria del teléfono, o `null` si no se pudo leer.
  Future<String?> deviceTimeZone();

  /// Todas las zonas válidas, ordenadas.
  List<String> allTimeZones();

  /// `true` si [name] es una zona IANA conocida.
  bool isValid(String name);
}
