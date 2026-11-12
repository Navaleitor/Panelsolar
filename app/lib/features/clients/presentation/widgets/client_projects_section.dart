import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/projects/presentation/project_providers.dart';
import 'package:panelsolar/features/projects/presentation/widgets/project_status_chip.dart';

/// Proyectos del cliente, con botón para agregar uno nuevo.
class ClientProjectsSection extends ConsumerWidget {
  const new({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final projects = ref.watch(projectsByClientProvider(clientId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l10n.clientProjectsTitle,
          action: TextButton.icon(
            key: const Key('client-add-project'),
            onPressed: () =>
                context.push(AppRoutes.projectNew(clientId: clientId)),
            icon: const Icon(Icons.add),
            label: Text(l10n.actionAdd),
          ),
        ),
        ...switch (projects) {
          AsyncData(:final value) when value.isEmpty => [
            ListTile(title: Text(l10n.clientNoProjects)),
          ],
          AsyncData(:final value) => [
            for (final p in value)
              ListTile(
                leading: const Icon(Icons.solar_power),
                title: Text(p.name),
                subtitle: Text(Formatters.date(p.projectDate, locale)),
                trailing: ProjectStatusChip(status: p.status),
                onTap: () => context.push(AppRoutes.projectDetail(p.id)),
              ),
          ],
          _ => [const LinearProgressIndicator()],
        },
      ],
    );
  }
}
