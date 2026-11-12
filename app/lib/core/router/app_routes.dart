/// Rutas de primer nivel (una por pestaña de la barra inferior).
abstract final class AppRoutes {
  static const String clients = '/clients';
  static const String projects = '/projects';
  static const String catalog = '/catalog';
  static const String maintenance = '/maintenance';
  static const String settings = '/settings';

  /// Subruta de Ajustes con la pantalla de clima (F2).
  static const String weatherSegment = 'weather';

  /// Ruta completa de la pantalla de clima.
  static const String weather = '/settings/weather';
}
