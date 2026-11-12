import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/features/clients/presentation/client_providers.dart';
import 'package:panelsolar/features/documents/presentation/documents_section.dart';
import 'package:panelsolar/features/photos/presentation/photos_summary_card.dart';
import 'package:panelsolar/features/projects/domain/project_status_flow.dart';
import 'package:panelsolar/features/projects/presentation/project_providers.dart';
import 'package:panelsolar/features/projects/presentation/widgets/project_status_chip.dart';
import 'package:panelsolar/features/projects/presentation/widgets/project_status_label.dart';
import 'package:panelsolar/features/site/presentation/site_summary_card.dart';
import 'package:panelsolar/features/weather/presentation/widgets/weather_entry_card.dart';
import 'package:persistence/persistence.dart';

/// Ficha del proyecto: datos, ubicación, fotos y documentos.
class ProjectDetailPage extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.projectDeleteTitle,
      message: l10n.projectDeleteMessage,
    );
    if (!ok) return;
    await ref.read(projectRepositoryProvider).softDelete(projectId);
    if (context.mounted) context.pop();
  }

  Future<void> _advance(WidgetRef ref, Project p, ProjectStatus next) => ref
      .read(projectRepositoryProvider)
      .update(
        p.id,
        name: p.name,
        status: next,
        projectDate: p.projectDate,
        notes: p.notes,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final project = ref.watch(projectProvider(projectId));
    return Scaffold(
      appBar: AppBar(
        title: Text(project.value?.name ?? l10n.navProjects),
        actions: [
          IconButton(
            tooltip: l10n.actionEdit,
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(AppRoutes.projectEdit(projectId)),
          ),
          PopupMenuButton<void>(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => _delete(context, ref),
                child: Text(l10n.actionDelete),
              ),
            ],
          ),
        ],
      ),
      body: AsyncValueView(
        value: project,
        data: (p) {
          if (p == null || p.deletedAt != null) {
            return Center(child: Text(l10n.projectNotFound));
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              _header(context, ref, p),
              SiteSummaryCard(projectId: projectId),
              WeatherEntryCard(projectId: projectId),
              PhotosSummaryCard(projectId: projectId),
              DocumentsSection(projectId: projectId),
            ],
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context, WidgetRef ref, Project p) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final client = ref.watch(clientProvider(p.clientId)).value;
    final next = ProjectStatusFlow.next(p.status);
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(client?.name ?? '…'),
            subtitle: Text(l10n.fieldClient),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.clientDetail(p.clientId)),
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: Text(Formatters.date(p.projectDate, locale)),
            subtitle: Text(l10n.fieldDate),
          ),
          ListTile(
            leading: const Icon(Icons.flag),
            title: Align(
              alignment: Alignment.centerLeft,
              child: ProjectStatusChip(status: p.status),
            ),
            subtitle: Text(l10n.fieldStatus),
          ),
          if (p.notes != null)
            ListTile(leading: const Icon(Icons.notes), title: Text(p.notes!)),
          if (next != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: OutlinedButton.icon(
                key: const Key('project-advance'),
                onPressed: () => _advance(ref, p, next),
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  l10n.projectAdvanceTo(projectStatusLabel(l10n, next)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
