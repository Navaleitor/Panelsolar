import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/empty_module_view.dart';

/// Pantalla principal del módulo Proyectos (vacía hasta la fase F1).
class ProjectsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyModuleView(
      title: l10n.navProjects,
      description: l10n.projectsDescription,
      icon: Icons.solar_power,
      phase: 'F1',
    );
  }
}
