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

  // Instalación (F6).
  static String projectInstallation(String id) => '/projects/$id/installation';
  static String projectCommissioning(String id) =>
      '/projects/$id/commissioning';
  static String equipmentNew(String projectId) =>
      '/projects/$projectId/equipment/new';
  static String equipmentEdit(String projectId, String equipmentId) =>
      '/projects/$projectId/equipment/$equipmentId';

  // Mantenimiento (F6).
  static const String maintenanceTemplate = '/maintenance/template';
  static String projectMaintenance(String id) => '/projects/$id/maintenance';
  static String visitNew(String projectId) => '/projects/$projectId/visits/new';
  static String visitDetail(String projectId, String visitId) =>
      '/projects/$projectId/visits/$visitId';

  // Producción (F6).
  static String projectProduction(String id) => '/projects/$id/production';

  // Respaldo (F6). Recibe un `RestoreRequest` en `extra`.
  static const String restorePreview = '/settings/restore';
}
