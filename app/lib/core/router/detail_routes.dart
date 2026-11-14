import 'package:go_router/go_router.dart';
import 'package:panelsolar/features/clients/presentation/client_detail_page.dart';
import 'package:panelsolar/features/clients/presentation/client_form_page.dart';
import 'package:panelsolar/features/photos/presentation/photo_view_page.dart';
import 'package:panelsolar/features/photos/presentation/photos_page.dart';
import 'package:panelsolar/features/projects/presentation/project_detail_page.dart';
import 'package:panelsolar/features/projects/presentation/project_form_page.dart';
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
  GoRoute(
    path: '/projects/:projectId',
    builder: (context, state) =>
        ProjectDetailPage(projectId: state.pathParameters['projectId']!),
  ),
];
