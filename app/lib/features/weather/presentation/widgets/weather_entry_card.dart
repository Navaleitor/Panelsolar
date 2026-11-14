import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';

/// Acceso a "Clima y producción" desde la ficha del proyecto.
class WeatherEntryCard extends StatelessWidget {
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
        key: const Key('project-weather'),
        leading: const Icon(Icons.wb_sunny),
        title: Text(l10n.weatherProjectEntryTitle),
        subtitle: Text(l10n.weatherProjectEntrySubtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(AppRoutes.projectWeather(projectId)),
      ),
    );
  }
}
