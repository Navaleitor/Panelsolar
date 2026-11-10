import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/empty_module_view.dart';

/// Pantalla principal del módulo Mantenimiento (vacía hasta la fase F6).
class MaintenancePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyModuleView(
      title: l10n.navMaintenance,
      description: l10n.maintenanceDescription,
      icon: Icons.build,
      phase: 'F6',
    );
  }
}
