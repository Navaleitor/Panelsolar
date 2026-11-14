import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/features/installation/presentation/installation_labels.dart';
import 'package:panelsolar/features/installation/presentation/installation_providers.dart';
import 'package:persistence/persistence.dart';

/// Tarjeta en la ficha del proyecto: equipos y estado de la puesta en
/// marcha. Al tocarla abre la pantalla de Instalación.
class InstallationSummaryCard extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final equipment = ref.watch(equipmentProvider(projectId)).value ?? const [];
    final record = ref.watch(commissioningProvider(projectId)).value;
    final status = record?.status ?? CommissioningStatus.pending;
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ListTile(
        key: const Key('installation-card'),
        leading: const Icon(Icons.construction),
        title: Text(l10n.installationTitle),
        subtitle: Text(
          '${l10n.equipmentCount(equipment.length)} · '
          '${l10n.commissioningTitle}: '
          '${commissioningStatusLabel(l10n, status)}',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(AppRoutes.projectInstallation(projectId)),
      ),
    );
  }
}
