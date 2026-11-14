import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Batería del catálogo (datos básicos).
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('BatteryModel')
class BatteryModels extends Table with BaseColumns {
  /// Fabricante.
  TextColumn get manufacturer => text()();

  /// Modelo.
  TextColumn get model => text()();

  /// Química.
  TextColumn get chemistry => textEnum<BatteryChemistry>().withDefault(
    Constant(BatteryChemistry.lfp.name),
  )();

  /// Capacidad nominal (kWh).
  RealColumn get capacityKwh => real()();

  /// Capacidad útil (kWh).
  RealColumn get usableKwh => real().nullable()();

  /// Tensión nominal (V).
  RealColumn get nominalVoltageV => real()();

  /// Potencia máxima de carga (kW).
  RealColumn get maxChargeKw => real().nullable()();

  /// Potencia máxima de descarga (kW).
  RealColumn get maxDischargeKw => real().nullable()();

  /// Ciclos de vida.
  IntColumn get cycles => integer().nullable()();

  /// Origen.
  TextColumn get source => textEnum<EquipmentSource>().withDefault(
    Constant(EquipmentSource.manual.name),
  )();

  /// Notas.
  TextColumn get notes => text().nullable()();
}
