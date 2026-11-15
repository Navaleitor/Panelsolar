import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/empty_state.dart';
import 'package:panelsolar/features/catalog/data/catalog_providers.dart';
import 'package:panelsolar/features/catalog/domain/equipment_type.dart';
import 'package:panelsolar/features/catalog/presentation/equipment_labels.dart';

/// Catálogo de equipos: paneles, inversores, optimizadores y baterías
/// capturados por el instalador o importados de CEC.
class CatalogPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends ConsumerState<CatalogPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(
    length: EquipmentType.values.length,
    vsync: this,
  );

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  EquipmentType get _type => EquipmentType.values[_tabs.index];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navCatalog),
        actions: [
          IconButton(
            key: const Key('catalog-cec'),
            tooltip: l10n.cecTitle,
            icon: const Icon(Icons.cloud_download),
            onPressed: () => context.push(AppRoutes.catalogCec),
          ),
        ],
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: [
            for (final t in EquipmentType.values)
              Tab(
                key: Key('catalog-tab-${t.name}'),
                text: equipmentTabLabel(l10n, t),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('catalog-add'),
        onPressed: () => context.push(AppRoutes.equipmentNew(_type.name)),
        icon: const Icon(Icons.add),
        label: Text(l10n.actionAdd),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _list(ref.watch(panelModelsProvider), EquipmentType.panel),
          _list(ref.watch(inverterModelsProvider), EquipmentType.inverter),
          _list(ref.watch(optimizerModelsProvider), EquipmentType.optimizer),
          _list(ref.watch(batteryModelsProvider), EquipmentType.battery),
        ],
      ),
    );
  }

  Widget _list(AsyncValue<List<Object>> value, EquipmentType type) {
    final l10n = AppLocalizations.of(context);
    return AsyncValueView(
      value: value,
      data: (rows) {
        if (rows.isEmpty) {
          return EmptyState(
            icon: Icons.inventory_2,
            message: l10n.catalogEmpty,
          );
        }
        return ListView(
          padding: const EdgeInsets.only(bottom: 96),
          children: [
            for (final r in rows)
              Builder(
                builder: (context) {
                  final s = equipmentSummary(l10n, r);
                  return ListTile(
                    key: Key('equipment-${s.id}'),
                    title: Text(s.title),
                    subtitle: Text(s.subtitle),
                    leading: Icon(s.cec ? Icons.public : Icons.edit_note),
                    trailing: IconButton(
                      tooltip: l10n.actionDelete,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _delete(type, s.id),
                    ),
                    onTap: () =>
                        context.push(AppRoutes.equipmentEdit(type.name, s.id)),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  Future<void> _delete(EquipmentType type, String id) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.catalogDeleteTitle,
      message: l10n.catalogDeleteMessage,
    );
    if (!ok) return;
    switch (type) {
      case EquipmentType.panel:
        await ref.read(panelModelRepositoryProvider).softDelete(id);
      case EquipmentType.inverter:
        await ref.read(inverterModelRepositoryProvider).softDelete(id);
      case EquipmentType.optimizer:
        await ref.read(optimizerModelRepositoryProvider).softDelete(id);
      case EquipmentType.battery:
        await ref.read(batteryModelRepositoryProvider).softDelete(id);
    }
  }
}
