import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_list_providers.dart';

/// Tarjeta en la ficha del proyecto: próximo servicio de mantenimiento.
class MaintenanceSummaryCard extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final plan = ref.watch(planProvider(projectId)).value ?? const [];
    final next = plan.isEmpty
        ? null
        : plan.reduce((a, b) => a.nextDueAt.isBefore(b.nextDueAt) ? a : b);
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ListTile(
        key: const Key('maintenance-card'),
        leading: const Icon(Icons.build),
        title: Text(l10n.navMaintenance),
        subtitle: Text(
          next == null
              ? l10n.planEmptyShort
              : l10n.nextOn(
                  Formatters.date(next.nextDueAt, formatLocale(context)),
                ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(AppRoutes.projectMaintenance(projectId)),
      ),
    );
  }
}
