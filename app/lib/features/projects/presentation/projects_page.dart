import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/core/widgets/empty_state.dart';
import 'package:panelsolar/features/projects/domain/project_status_flow.dart';
import 'package:panelsolar/features/projects/presentation/project_providers.dart';
import 'package:panelsolar/features/projects/presentation/widgets/project_status_chip.dart';
import 'package:panelsolar/features/projects/presentation/widgets/project_status_label.dart';
import 'package:persistence/persistence.dart';

/// Lista de todos los proyectos, con búsqueda y filtro por estado.
class ProjectsPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends ConsumerState<ProjectsPage> {
  String _query = '';
  ProjectStatus? _status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final projects = ref.watch(
      projectListProvider((status: _status, query: _query)),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProjects)),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'projects-fab',
        onPressed: () => context.push(AppRoutes.projectNew()),
        icon: const Icon(Icons.add),
        label: Text(l10n.projectNew),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              key: const Key('projects-search'),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: l10n.projectsSearchHint,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _chip(l10n.filterAll, null),
                for (final s in ProjectStatusFlow.ordered)
                  _chip(projectStatusLabel(l10n, s), s),
              ],
            ),
          ),
          Expanded(
            child: AsyncValueView(
              value: projects,
              data: (list) => list.isEmpty
                  ? EmptyState(
                      icon: Icons.solar_power_outlined,
                      message: l10n.projectsEmpty,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 96),
                      itemCount: list.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = list[index];
                        final date = Formatters.date(
                          item.project.projectDate,
                          locale,
                        );
                        return ListTile(
                          leading: const Icon(Icons.solar_power),
                          title: Text(item.project.name),
                          subtitle: Text('${item.client.name} · $date'),
                          trailing: ProjectStatusChip(
                            status: item.project.status,
                          ),
                          onTap: () => context.push(
                            AppRoutes.projectDetail(item.project.id),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, ProjectStatus? status) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: _status == status,
        onSelected: (_) => setState(() => _status = status),
      ),
    );
  }
}
