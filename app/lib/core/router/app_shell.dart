import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Marco común: contenido de la pestaña + barra de navegación inferior.
class AppShell extends StatelessWidget {
  const new({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) =>
            shell.goBranch(index, initialLocation: index == shell.currentIndex),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.people_outline),
            selectedIcon: const Icon(Icons.people),
            label: l10n.navClients,
          ),
          NavigationDestination(
            icon: const Icon(Icons.solar_power_outlined),
            selectedIcon: const Icon(Icons.solar_power),
            label: l10n.navProjects,
          ),
          NavigationDestination(
            icon: const Icon(Icons.inventory_2_outlined),
            selectedIcon: const Icon(Icons.inventory_2),
            label: l10n.navCatalog,
          ),
          NavigationDestination(
            icon: const Icon(Icons.build_outlined),
            selectedIcon: const Icon(Icons.build),
            label: l10n.navMaintenance,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
