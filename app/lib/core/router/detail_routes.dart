import 'package:go_router/go_router.dart';
import 'package:panelsolar/features/backup/presentation/restore_preview_page.dart';
import 'package:panelsolar/features/clients/presentation/client_detail_page.dart';
import 'package:panelsolar/features/clients/presentation/client_form_page.dart';
import 'package:panelsolar/features/installation/presentation/commissioning_page.dart';
import 'package:panelsolar/features/installation/presentation/equipment_form_page.dart';
import 'package:panelsolar/features/installation/presentation/installation_page.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_template_page.dart';
import 'package:panelsolar/features/maintenance/presentation/project_maintenance_page.dart';
import 'package:panelsolar/features/maintenance/presentation/visit_detail_page.dart';
import 'package:panelsolar/features/maintenance/presentation/visit_form_page.dart';
import 'package:panelsolar/features/photos/presentation/photo_view_page.dart';
import 'package:panelsolar/features/photos/presentation/photos_page.dart';
import 'package:panelsolar/features/production/presentation/production_page.dart';
import 'package:panelsolar/features/projects/presentation/project_detail_page.dart';
import 'package:panelsolar/features/projects/presentation/project_form_page.dart';
import 'package:panelsolar/features/roof/presentation/editor/editor_tool.dart';
import 'package:panelsolar/features/roof/presentation/editor/roof_editor_page.dart';
import 'package:panelsolar/features/roof/presentation/horizon_page.dart';
import 'package:panelsolar/features/roof/presentation/roof_page.dart';
import 'package:panelsolar/features/roof/presentation/shade_page.dart';
import 'package:panelsolar/features/site/presentation/location_page.dart';
import 'package:panelsolar/features/utility_bills/presentation/bill_form_page.dart';
import 'package:panelsolar/features/weather/presentation/weather_page.dart';

/// Pantallas de detalle y edición (pantalla completa, sin barra inferior).
/// Rutas planas: las específicas (`/new`) van antes que las de `:id`.
/// Los textos de ruta coinciden con los de `AppRoutes`.
final List<RouteBase> detailRoutes = [
  // Clientes.
  GoRoute(
    path: '/clients/new',
    builder: (context, state) => const ClientFormPage(),
  ),
  GoRoute(
    path: '/clients/:clientId/edit',
    builder: (context, state) =>
        ClientFormPage(clientId: state.pathParameters['clientId']),
  ),
  GoRoute(
    path: '/clients/:clientId/bills/new',
    builder: (context, state) =>
        BillFormPage(clientId: state.pathParameters['clientId']!),
  ),
  GoRoute(
    path: '/clients/:clientId/bills/:billId',
    builder: (context, state) => BillFormPage(
      clientId: state.pathParameters['clientId']!,
      billId: state.pathParameters['billId'],
    ),
  ),
  GoRoute(
    path: '/clients/:clientId',
    builder: (context, state) =>
        ClientDetailPage(clientId: state.pathParameters['clientId']!),
  ),
  // Proyectos.
  GoRoute(
    path: '/projects/new',
    builder: (context, state) =>
        ProjectFormPage(clientId: state.uri.queryParameters['clientId']),
  ),
  GoRoute(
    path: '/projects/:projectId/edit',
    builder: (context, state) =>
        ProjectFormPage(projectId: state.pathParameters['projectId']),
  ),
  GoRoute(
    path: '/projects/:projectId/location',
    builder: (context, state) =>
        LocationPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/weather',
    builder: (context, state) =>
        WeatherPage(projectId: state.pathParameters['projectId']),
  ),
  // Techo (F3).
  GoRoute(
    path: '/projects/:projectId/roof',
    builder: (context, state) =>
        RoofPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/roof/editor',
    builder: (context, state) => RoofEditorPage(
      projectId: state.pathParameters['projectId']!,
      initialTool:
          EditorTool.values.asNameMap()[state.uri.queryParameters['tool']] ??
          EditorTool.draw,
    ),
  ),
  GoRoute(
    path: '/projects/:projectId/roof/shade',
    builder: (context, state) =>
        ShadePage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/roof/horizon',
    builder: (context, state) =>
        HorizonPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/photos',
    builder: (context, state) =>
        PhotosPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/photos/:photoId',
    builder: (context, state) => PhotoViewPage(
      projectId: state.pathParameters['projectId']!,
      photoId: state.pathParameters['photoId']!,
    ),
  ),
  // Instalación, mantenimiento y producción (F6).
  GoRoute(
    path: '/projects/:projectId/installation',
    builder: (context, state) =>
        InstallationPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/commissioning',
    builder: (context, state) =>
        CommissioningPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/equipment/new',
    builder: (context, state) =>
        EquipmentFormPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/equipment/:equipmentId',
    builder: (context, state) => EquipmentFormPage(
      projectId: state.pathParameters['projectId']!,
      equipmentId: state.pathParameters['equipmentId'],
    ),
  ),
  GoRoute(
    path: '/projects/:projectId/maintenance',
    builder: (context, state) =>
        ProjectMaintenancePage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/visits/new',
    builder: (context, state) =>
        VisitFormPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/projects/:projectId/visits/:visitId',
    builder: (context, state) => VisitDetailPage(
      projectId: state.pathParameters['projectId']!,
      visitId: state.pathParameters['visitId']!,
    ),
  ),
  GoRoute(
    path: '/projects/:projectId/production',
    builder: (context, state) =>
        ProductionPage(projectId: state.pathParameters['projectId']!),
  ),
  GoRoute(
    path: '/maintenance/template',
    builder: (context, state) => const MaintenanceTemplatePage(),
  ),
  GoRoute(
    path: '/settings/restore',
    builder: (context, state) =>
        RestorePreviewPage(request: state.extra! as RestoreRequest),
  ),
  GoRoute(
    path: '/projects/:projectId',
    builder: (context, state) =>
        ProjectDetailPage(projectId: state.pathParameters['projectId']!),
  ),
];
