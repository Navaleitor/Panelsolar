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
  static String photoView(String projectId, String photoId) =>
      '/projects/$projectId/photos/$photoId';
}
