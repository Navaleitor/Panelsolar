import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/maintenance/data/maintenance_providers.dart';
import 'package:panelsolar/features/maintenance/domain/due_status.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_labels.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_list_providers.dart';
import 'package:panelsolar/features/maintenance/presentation/widgets/service_dialog.dart';
import 'package:persistence/persistence.dart';

/// Mantenimiento de un proyecto: plan de servicios (frecuencia y próxima
/// fecha) y bitácora de visitas.
class ProjectMaintenancePage extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  Future<void> _createPlan(WidgetRef ref) async {
    await ref.read(templateSeedProvider.future);
    await ref
        .read(maintenanceRepositoryProvider)
        .createPlanFromTemplate(projectId, DateTime.now().toUtc());
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final r = await showServiceDialog(context, askNextDue: true);
    if (r != null) {
      await ref
          .read(maintenanceRepositoryProvider)
          .addPlanItem(projectId, r.service, nextDueAt: r.nextDueAt!);
    }
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    MaintenancePlanItem p,
  ) async {
    final r = await showServiceDialog(
      context,
      kind: p.kind,
      title: p.title,
      intervalMonths: p.intervalMonths,
      nextDueAt: p.nextDueAt,
      askNextDue: true,
    );
    if (r != null) {
      await ref
          .read(maintenanceRepositoryProvider)
          .updatePlanItem(p.id, r.service, nextDueAt: r.nextDueAt!);
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    MaintenancePlanItem p,
  ) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.serviceDeleteTitle,
      message: serviceLabel(l10n, p.kind, p.title),
    );
    if (ok) {
      await ref.read(maintenanceRepositoryProvider).softDeletePlanItem(p.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final plan = ref.watch(planProvider(projectId)).value ?? const [];
    final visits = ref.watch(visitsProvider(projectId)).value ?? const [];
    final today = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMaintenance)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('visit-new'),
        onPressed: () => context.push(AppRoutes.visitNew(projectId)),
        icon: const Icon(Icons.assignment_add),
        label: Text(l10n.visitLog),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          SectionHeader(
            title: l10n.planTitle,
            action: TextButton.icon(
              key: const Key('plan-add'),
              onPressed: () => _add(context, ref),
              icon: const Icon(Icons.add),
              label: Text(l10n.actionAdd),
            ),
          ),
          if (plan.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.planEmpty),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    key: const Key('plan-from-template'),
                    onPressed: () => _createPlan(ref),
                    icon: const Icon(Icons.playlist_add),
                    label: Text(l10n.planFromTemplate),
                  ),
                ],
              ),
            ),
          for (final p in plan)
            ListTile(
              leading: Icon(
                dueStatus(p.nextDueAt, today) == DueStatus.overdue
                    ? Icons.warning
                    : Icons.event_repeat,
                color: dueStatus(p.nextDueAt, today) == DueStatus.overdue
                    ? Theme.of(context).colorScheme.error
                    : null,
              ),
              title: Text(serviceLabel(l10n, p.kind, p.title)),
              subtitle: Text(
                '${l10n.everyMonths(p.intervalMonths)} · '
                '${l10n.nextOn(Formatters.date(p.nextDueAt, locale))}',
              ),
              onTap: () => _edit(context, ref, p),
              trailing: IconButton(
                tooltip: l10n.actionDelete,
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _delete(context, ref, p),
              ),
            ),
          SectionHeader(title: l10n.visitsTitle),
          if (visits.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(l10n.visitsEmpty),
            ),
          for (final v in visits)
            ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: Text(Formatters.date(v.visitDate, locale)),
              subtitle: Text(
                [
                  ?v.technician,
                  l10n.servicesDone(
                    v.doneItemIds.isEmpty ? 0 : v.doneItemIds.split(',').length,
                  ),
                  ?v.notes,
                ].join(' · '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoutes.visitDetail(projectId, v.id)),
            ),
        ],
      ),
    );
  }
}
