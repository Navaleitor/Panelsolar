/// Rutas de la app. Las de primer nivel son pestañas de la barra inferior;
/// las de detalle/edición se abren encima (pantalla completa) con
/// `context.push(...)`.
abstract final class AppRoutes {
  static const String clients = '/clients';
  static const String projects = '/projects';
  static const String catalog = '/catalog';
  static const String maintenance = '/maintenance';
  static const String settings = '/settings';

  // Clientes.
  static const String clientNew = '/clients/new';
  static String clientDetail(String id) => '/clients/$id';
  static String clientEdit(String id) => '/clients/$id/edit';
  static String billNew(String clientId) => '/clients/$clientId/bills/new';
  static String billEdit(String clientId, String billId) =>
      '/clients/$clientId/bills/$billId';

  // Proyectos.
  static String projectNew({String? clientId}) =>
      clientId == null ? '/projects/new' : '/projects/new?clientId=$clientId';
  static String projectDetail(String id) => '/projects/$id';
  static String projectEdit(String id) => '/projects/$id/edit';
  static String projectLocation(String id) => '/projects/$id/location';
  static String projectPhotos(String id) => '/projects/$id/photos';
  static String projectWeather(String id) => '/projects/$id/weather';
  static String projectRoof(String id) => '/projects/$id/roof';
  static String roofEditor(String id, String tool) =>
      '/projects/$id/roof/editor?tool=$tool';
  static String roofShade(String id) => '/projects/$id/roof/shade';
  static String roofHorizon(String id) => '/projects/$id/roof/horizon';
  static String photoView(String projectId, String photoId) =>
      '/projects/$projectId/photos/$photoId';

  // Catálogo (F4).
  static const String catalogCec = '/catalog/cec';
  static String equipmentNew(String type) => '/catalog/$type/new';
  static String equipmentEdit(String type, String id) => '/catalog/$type/$id';

  // Diseño FV (F4).
  static String design(String id) => '/projects/$id/design';
  static String designSection(String id, String section) =>
      '/projects/$id/design/$section';

  /// Subruta de Ajustes con la pantalla de clima (F2).
  static const String weatherSegment = 'weather';

  /// Ruta completa de la pantalla de clima.
  static const String weather = '/settings/weather';
}
