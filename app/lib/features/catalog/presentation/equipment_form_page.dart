import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/catalog/data/catalog_providers.dart';
import 'package:panelsolar/features/catalog/domain/equipment_type.dart';
import 'package:panelsolar/features/catalog/presentation/equipment_form_specs.dart';
import 'package:panelsolar/features/catalog/presentation/equipment_labels.dart';
import 'package:panelsolar/features/catalog/presentation/widgets/spec_form.dart';

/// Alta o edición de un equipo (hoja de datos).
class EquipmentFormPage extends ConsumerWidget {
  /// Crea la pantalla; [id] nulo = equipo nuevo.
  const new({required this.type, this.id, super.key});

  /// Tipo de equipo.
  final EquipmentType type;

  /// Equipo a editar.
  final String? id;

  Object? _find(WidgetRef ref, AppLocalizations l) {
    if (id == null) return null;
    final List<Object>? list = switch (type) {
      EquipmentType.panel => ref.watch(panelModelsProvider).value,
      EquipmentType.inverter => ref.watch(inverterModelsProvider).value,
      EquipmentType.optimizer => ref.watch(optimizerModelsProvider).value,
      EquipmentType.battery => ref.watch(batteryModelsProvider).value,
    };
    return list?.where((e) => equipmentSummary(l, e).id == id).firstOrNull;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final row = _find(ref, l10n);
    final loading = id != null && row == null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          id == null ? equipmentNewTitle(l10n, type) : l10n.catalogEditTitle,
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SpecForm(
              fields: equipmentFields(type, l10n),
              initial: row == null
                  ? equipmentDefaults(type)
                  : equipmentValues(row),
              onSave: (values) async {
                try {
                  await saveEquipment(
                    type,
                    values,
                    id: id,
                    panels: ref.read(panelModelRepositoryProvider),
                    inverters: ref.read(inverterModelRepositoryProvider),
                    optimizers: ref.read(optimizerModelRepositoryProvider),
                    batteries: ref.read(batteryModelRepositoryProvider),
                  );
                  // El repositorio valida y lanza ArgumentError.
                  // ignore: avoid_catching_errors
                } on ArgumentError {
                  return l10n.catalogInvalidData;
                }
                if (context.mounted) context.pop();
                return null;
              },
            ),
    );
  }
}
