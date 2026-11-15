import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/features/production/data/production_providers.dart';
import 'package:panelsolar/features/production/domain/performance.dart';
import 'package:persistence/persistence.dart';

/// Tarjeta en la ficha del proyecto: última lectura y alerta.
class ProductionSummaryCard extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final readings = ref.watch(readingsProvider(projectId)).value ?? const [];
    final settings = ref.watch(productionSettingsProvider(projectId)).value;
    final summary = ProductionSummary.of(
      readings,
      thresholdPct: settings?.alertThresholdPct ?? defaultAlertThresholdPct,
    );
    final latest = summary.latest;
    final locale = formatLocale(context);
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ListTile(
        key: const Key('production-card'),
        leading: Icon(
          summary.latestInAlert ? Icons.trending_down : Icons.bar_chart,
          color: summary.latestInAlert
              ? Theme.of(context).colorScheme.error
              : null,
        ),
        title: Text(l10n.productionTitle),
        subtitle: Text(
          latest == null
              ? l10n.productionEmptyShort
              : [
                  Formatters.monthYear(latest.month, locale),
                  '${Formatters.number(latest.actualKwh, locale)} kWh',
                  if (summary.latestInAlert) l10n.productionBelow,
                ].join(' · '),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(AppRoutes.projectProduction(projectId)),
      ),
    );
  }
}
