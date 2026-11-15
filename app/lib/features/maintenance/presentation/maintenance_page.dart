import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/core/widgets/empty_state.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/maintenance/domain/due_status.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_labels.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_list_providers.dart';
import 'package:persistence/persistence.dart';

/// Pestaña Mantenimiento: calendario de próximas visitas de todos los
/// proyectos, agrupado en vencidas, próximos 30 días y después.
class MaintenancePage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final upcoming = ref.watch(upcomingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navMaintenance),
        actions: [
          IconButton(
            key: const Key('maintenance-template'),
            tooltip: l10n.templateTitle,
            icon: const Icon(Icons.playlist_add_check),
            onPressed: () => context.push(AppRoutes.maintenanceTemplate),
          ),
        ],
      ),
      body: AsyncValueView(
        value: upcoming,
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.event_available,
              message: l10n.calendarEmpty,
            );
          }
          final today = DateTime.now();
          List<UpcomingService> group(DueStatus s) => [
            for (final u in list)
              if (dueStatus(u.item.nextDueAt, today) == s) u,
          ];
          return ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              for (final (status, title) in [
                (DueStatus.overdue, l10n.calendarOverdue),
                (DueStatus.soon, l10n.calendarSoon),
                (DueStatus.later, l10n.calendarLater),
              ])
                if (group(status).isNotEmpty) ...[
                  SectionHeader(title: title),
                  for (final u in group(status))
                    _UpcomingTile(service: u, status: status),
                ],
            ],
          );
        },
      ),
    );
  }
}

class _UpcomingTile extends StatelessWidget {
  const new({required this.service, required this.status});

  final UpcomingService service;
  final DueStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final item = service.item;
    return ListTile(
      leading: Icon(
        status == DueStatus.overdue ? Icons.warning : Icons.event,
        color: status == DueStatus.overdue
            ? Theme.of(context).colorScheme.error
            : null,
      ),
      title: Text(serviceLabel(l10n, item.kind, item.title)),
      subtitle: Text('${service.projectName} · ${service.clientName}'),
      trailing: Text(Formatters.date(item.nextDueAt, formatLocale(context))),
      onTap: () => context.push(AppRoutes.projectMaintenance(item.projectId)),
    );
  }
}
