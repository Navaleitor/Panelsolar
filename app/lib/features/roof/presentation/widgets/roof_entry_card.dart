import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';

/// Acceso al módulo "Techo" desde la ficha del proyecto.
class RoofEntryCard extends ConsumerWidget {
  /// Crea la tarjeta.
  const new({required this.projectId, super.key});

  /// Proyecto.
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final planes = ref.watch(roofPlanesProvider(projectId)).value ?? const [];
    final area = planes.fold<double>(
      0,
      (a, p) => a + PolygonMetrics.area(p.polygon),
    );
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ListTile(
        key: const Key('project-roof'),
        leading: const Icon(Icons.roofing),
        title: Text(l10n.roofTitle),
        subtitle: Text(
          planes.isEmpty
              ? l10n.roofEntryEmpty
              : l10n.roofEntrySummary(
                  planes.length,
                  RoofFormat.area(area, formatLocale(context)),
                ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(AppRoutes.projectRoof(projectId)),
      ),
    );
  }
}
