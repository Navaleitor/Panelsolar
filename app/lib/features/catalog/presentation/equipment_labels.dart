import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/catalog/domain/equipment_type.dart';
import 'package:persistence/persistence.dart';

/// Nombre de la pestaña.
String equipmentTabLabel(AppLocalizations l, EquipmentType t) => switch (t) {
  EquipmentType.panel => l.catalogPanels,
  EquipmentType.inverter => l.catalogInverters,
  EquipmentType.optimizer => l.catalogOptimizers,
  EquipmentType.battery => l.catalogBatteries,
};

/// Título de alta.
String equipmentNewTitle(AppLocalizations l, EquipmentType t) => switch (t) {
  EquipmentType.panel => l.catalogNewPanel,
  EquipmentType.inverter => l.catalogNewInverter,
  EquipmentType.optimizer => l.catalogNewOptimizer,
  EquipmentType.battery => l.catalogNewBattery,
};

/// Resumen de una fila del catálogo (título, subtítulo, id, de CEC).
({String title, String subtitle, String id, bool cec}) equipmentSummary(
  AppLocalizations l,
  Object row,
) => switch (row) {
  final PanelModel p => (
    title: '${p.manufacturer} ${p.model}',
    subtitle: l.catalogPanelSummary(
      p.pmaxW.round(),
      p.vocV.toStringAsFixed(1),
      p.iscA.toStringAsFixed(1),
    ),
    id: p.id,
    cec: p.source == EquipmentSource.cec,
  ),
  final InverterModel i => (
    title: '${i.manufacturer} ${i.model}',
    subtitle: l.catalogInverterSummary(
      (i.pacW / 1000).toStringAsFixed(1),
      i.mpptCount,
      i.kind == InverterKind.micro ? l.inverterMicro : l.inverterString,
    ),
    id: i.id,
    cec: i.source == EquipmentSource.cec,
  ),
  final OptimizerModel o => (
    title: '${o.manufacturer} ${o.model}',
    subtitle: '${o.pmaxInW.round()} W · ${o.vinMaxV.round()} V',
    id: o.id,
    cec: false,
  ),
  final BatteryModel b => (
    title: '${b.manufacturer} ${b.model}',
    subtitle: '${b.capacityKwh} kWh · ${b.nominalVoltageV.round()} V',
    id: b.id,
    cec: false,
  ),
  _ => (title: '', subtitle: '', id: '', cec: false),
};
