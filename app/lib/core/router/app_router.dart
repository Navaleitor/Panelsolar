import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/router/app_shell.dart';
import 'package:panelsolar/features/catalog/presentation/catalog_page.dart';
import 'package:panelsolar/features/clients/presentation/clients_page.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_page.dart';
import 'package:panelsolar/features/projects/presentation/projects_page.dart';
import 'package:panelsolar/features/settings/presentation/settings_page.dart';

/// Navegación de la app. Cada pestaña es una rama con su propia pila, así
/// al cambiar de pestaña no se pierde dónde estaba el usuario.
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
          _branch(AppRoutes.settings, const SettingsPage()),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

StatefulShellBranch _branch(String path, Widget page) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, state) => page)],
);
