import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/installation/domain/warranty.dart';
import 'package:panelsolar/features/installation/presentation/installation_labels.dart';
import 'package:panelsolar/features/installation/presentation/installation_providers.dart';
import 'package:persistence/persistence.dart';

/// Instalación del proyecto: equipos instalados (marca, modelo, serie,
/// garantía) y acceso al checklist de puesta en marcha.
class InstallationPage extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final equipment = ref.watch(equipmentProvider(projectId)).value ?? const [];
    final record = ref.watch(commissioningProvider(projectId)).value;
    final status = record?.status ?? CommissioningStatus.pending;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.installationTitle)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          SectionHeader(title: l10n.commissioningTitle),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              key: const Key('commissioning-open'),
              leading: Icon(
                Icons.fact_check,
                color: commissioningStatusColor(colors, status),
              ),
              title: Text(commissioningStatusLabel(l10n, status)),
              subtitle: Text(l10n.commissioningHint),
              trailing: const Icon(Icons.chevron_right),
              onTap: () =>
                  context.push(AppRoutes.projectCommissioning(projectId)),
            ),
          ),
          SectionHeader(
            title: l10n.equipmentTitle,
            action: TextButton.icon(
              key: const Key('equipment-add'),
              onPressed: () => context.push(AppRoutes.equipmentNew(projectId)),
              icon: const Icon(Icons.add),
              label: Text(l10n.actionAdd),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                if (equipment.isEmpty)
                  ListTile(
                    leading: const Icon(Icons.inventory_2_outlined),
                    title: Text(l10n.equipmentEmpty),
                  ),
                for (final e in equipment) _EquipmentTile(item: e),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EquipmentTile extends StatelessWidget {
  const new({required this.item});

  final InstalledEquipmentItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final state = warrantyState(item.warrantyUntil, DateTime.now());
    final lines = [
      equipmentKindLabel(l10n, item.kind),
      if (item.serialNumber != null)
        l10n.equipmentSerialShort(item.serialNumber!),
      if (item.warrantyUntil != null)
        switch (state) {
          WarrantyState.expired => l10n.warrantyExpired(
            Formatters.date(item.warrantyUntil!, locale),
          ),
          _ => l10n.warrantyUntil(Formatters.date(item.warrantyUntil!, locale)),
        },
    ];
    return ListTile(
      leading: Icon(equipmentKindIcon(item.kind)),
      title: Text([item.brand, ?item.model].join(' ')),
      subtitle: Text(lines.join(' · ')),
      trailing: switch (state) {
        WarrantyState.expired => Icon(
          Icons.warning,
          color: Theme.of(context).colorScheme.error,
        ),
        WarrantyState.expiringSoon => const Icon(Icons.schedule),
        _ => null,
      },
      onTap: () =>
          context.push(AppRoutes.equipmentEdit(item.projectId, item.id)),
    );
  }
}
