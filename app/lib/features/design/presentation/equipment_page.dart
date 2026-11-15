import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/features/catalog/data/catalog_providers.dart';
import 'package:panelsolar/features/design/data/design_providers.dart';
import 'package:panelsolar/features/design/data/design_service.dart';
import 'package:persistence/persistence.dart';

/// Elegir panel, inversor (y cuántos), optimizador y batería del catálogo.
class EquipmentPage extends ConsumerWidget {
  /// Crea la pantalla.
  const new({required this.projectId, super.key});

  /// Proyecto.
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final design = ref.watch(pvDesignProvider(projectId)).value;
    final panels = ref.watch(panelModelsProvider).value ?? const [];
    final inverters = ref.watch(inverterModelsProvider).value ?? const [];
    final optimizers = ref.watch(optimizerModelsProvider).value ?? const [];
    final batteries = ref.watch(batteryModelsProvider).value ?? const [];
    final service = ref.read(designServiceProvider);
    Future<void> save(PvDesignsCompanion c) => service.update(projectId, c);

    Widget picker<T>({
      required String key,
      required String label,
      required List<T> items,
      required String Function(T) id,
      required String Function(T) name,
      required String? selected,
      required void Function(String?) onChanged,
      bool optional = false,
    }) {
      final valid = items.any((e) => id(e) == selected) ? selected : null;
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: DropdownButtonFormField<String?>(
          key: Key(key),
          initialValue: valid,
          isExpanded: true,
          decoration: InputDecoration(labelText: label),
          items: [
            if (optional)
              DropdownMenuItem<String?>(child: Text(l10n.designNone)),
            for (final e in items)
              DropdownMenuItem(value: id(e), child: Text(name(e))),
          ],
          onChanged: onChanged,
        ),
      );
    }

    final count = design?.inverterCount ?? 1;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.designEquipment)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          if (panels.isEmpty || inverters.isEmpty)
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(l10n.designCatalogEmpty),
              trailing: TextButton(
                onPressed: () => context.go(AppRoutes.catalog),
                child: Text(l10n.navCatalog),
              ),
            ),
          picker<PanelModel>(
            key: 'design-panel',
            label: l10n.designPanel,
            items: panels,
            id: (p) => p.id,
            name: (p) => '${p.manufacturer} ${p.model} · ${p.pmaxW.round()} W',
            selected: design?.panelModelId,
            onChanged: (v) => save(PvDesignsCompanion(panelModelId: Value(v))),
          ),
          picker<InverterModel>(
            key: 'design-inverter',
            label: l10n.designInverter,
            items: inverters,
            id: (i) => i.id,
            name: (i) =>
                '${i.manufacturer} ${i.model} · '
                '${(i.pacW / 1000).toStringAsFixed(1)} kW',
            selected: design?.inverterModelId,
            onChanged: (v) =>
                save(PvDesignsCompanion(inverterModelId: Value(v))),
          ),
          ListTile(
            title: Text(l10n.designInverterCount),
            subtitle: Text(l10n.designInverterCountHelp),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  key: const Key('design-count-minus'),
                  onPressed: count <= 1
                      ? null
                      : () => save(
                          PvDesignsCompanion(inverterCount: Value(count - 1)),
                        ),
                  icon: const Icon(Icons.remove),
                ),
                Text('$count', key: const Key('design-count')),
                IconButton(
                  key: const Key('design-count-plus'),
                  onPressed: () =>
                      save(PvDesignsCompanion(inverterCount: Value(count + 1))),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          picker<OptimizerModel>(
            key: 'design-optimizer',
            label: l10n.designOptimizer,
            items: optimizers,
            id: (o) => o.id,
            name: (o) => '${o.manufacturer} ${o.model}',
            selected: design?.optimizerModelId,
            optional: true,
            onChanged: (v) =>
                save(PvDesignsCompanion(optimizerModelId: Value(v))),
          ),
          picker<BatteryModel>(
            key: 'design-battery',
            label: l10n.designBattery,
            items: batteries,
            id: (b) => b.id,
            name: (b) => '${b.manufacturer} ${b.model} · ${b.capacityKwh} kWh',
            selected: design?.batteryModelId,
            optional: true,
            onChanged: (v) =>
                save(PvDesignsCompanion(batteryModelId: Value(v))),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.designOptimizerHelp),
          ),
        ],
      ),
    );
  }
}
