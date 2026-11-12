/// Datos fijos de la app.
abstract final class AppInfo {
  /// Versión visible (debe coincidir con `version:` de `app/pubspec.yaml`;
  /// lo comprueba `test/core/app_info_test.dart`).
  static const String version = '0.1.0';

  /// User-Agent para servicios externos (política de Nominatim, ADR-004).
  static const String userAgent = 'Panelsolar/$version';
}
