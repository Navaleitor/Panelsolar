import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';

/// Acceso a "Diseño FV" desde la ficha del proyecto.
class DesignEntryCard extends StatelessWidget {
  /// Crea la tarjeta.
  const new({required this.projectId, super.key});

  /// Proyecto.
  final String projectId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ListTile(
        key: const Key('project-design'),
        leading: const Icon(Icons.solar_power),
        title: Text(l10n.designTitle),
        subtitle: Text(l10n.designEntrySubtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(AppRoutes.design(projectId)),
      ),
    );
  }
}
