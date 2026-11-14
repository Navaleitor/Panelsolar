import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/router/app_shell.dart';
import 'package:panelsolar/core/router/detail_routes.dart';
import 'package:panelsolar/features/catalog/presentation/catalog_page.dart';
import 'package:panelsolar/features/clients/presentation/clients_page.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_page.dart';
import 'package:panelsolar/features/projects/presentation/projects_page.dart';
import 'package:panelsolar/features/settings/presentation/settings_page.dart';
import 'package:panelsolar/features/weather/presentation/weather_page.dart';

/// Navegación de la app. Cada pestaña es una rama con su propia pila, así
/// al cambiar de pestaña no se pierde dónde estaba el usuario. Las
/// pantallas de detalle (`detailRoutes`) se abren encima, sin la barra
/// inferior.
final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.clients,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          _branch(AppRoutes.clients, const ClientsPage()),
          _branch(AppRoutes.projects, const ProjectsPage()),
          _branch(AppRoutes.catalog, const CatalogPage()),
          _branch(AppRoutes.maintenance, const MaintenancePage()),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsPage(),
                routes: [
                  // F2: pantalla mínima de clima y producción.
                  GoRoute(
                    path: AppRoutes.weatherSegment,
                    builder: (context, state) => const WeatherPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      ...detailRoutes,
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

StatefulShellBranch _branch(String path, Widget page) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, state) => page)],
);
