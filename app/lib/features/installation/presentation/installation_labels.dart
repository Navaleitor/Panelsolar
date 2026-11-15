import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/installation/domain/commissioning_evaluation.dart';
import 'package:persistence/persistence.dart';

/// Nombre visible de un tipo de equipo.
String equipmentKindLabel(AppLocalizations l10n, EquipmentKind k) =>
    switch (k) {
      EquipmentKind.panel => l10n.equipmentPanel,
      EquipmentKind.inverter => l10n.equipmentInverter,
      EquipmentKind.microinverter => l10n.equipmentMicroinverter,
      EquipmentKind.optimizer => l10n.equipmentOptimizer,
      EquipmentKind.battery => l10n.equipmentBattery,
      EquipmentKind.meter => l10n.equipmentMeter,
      EquipmentKind.protection => l10n.equipmentProtection,
      EquipmentKind.structure => l10n.equipmentStructure,
      EquipmentKind.other => l10n.equipmentOther,
    };

/// Ícono de un tipo de equipo.
IconData equipmentKindIcon(EquipmentKind k) => switch (k) {
  EquipmentKind.panel => Icons.solar_power,
  EquipmentKind.inverter || EquipmentKind.microinverter => Icons.electric_bolt,
  EquipmentKind.optimizer => Icons.tune,
  EquipmentKind.battery => Icons.battery_charging_full,
  EquipmentKind.meter => Icons.speed,
  EquipmentKind.protection => Icons.shield,
  EquipmentKind.structure => Icons.view_module,
  EquipmentKind.other => Icons.devices_other,
};

/// Nombre visible del estado de la puesta en marcha.
String commissioningStatusLabel(AppLocalizations l10n, CommissioningStatus s) =>
    switch (s) {
      CommissioningStatus.pending => l10n.commissioningPending,
      CommissioningStatus.approved => l10n.commissioningApproved,
      CommissioningStatus.observations => l10n.commissioningObservations,
    };

/// Color del estado de la puesta en marcha.
Color commissioningStatusColor(ColorScheme c, CommissioningStatus s) =>
    switch (s) {
      CommissioningStatus.pending => c.outline,
      CommissioningStatus.approved => Colors.green.shade700,
      CommissioningStatus.observations => c.error,
    };

/// Ícono de un veredicto de medición.
Widget verdictIcon(BuildContext context, MeasurementVerdict v) => switch (v) {
  MeasurementVerdict.ok => Icon(
    Icons.check_circle,
    color: Colors.green.shade700,
  ),
  MeasurementVerdict.outOfRange => Icon(
    Icons.error,
    color: Theme.of(context).colorScheme.error,
  ),
  MeasurementVerdict.incomplete => Icon(
    Icons.radio_button_unchecked,
    color: Theme.of(context).colorScheme.outline,
  ),
};
