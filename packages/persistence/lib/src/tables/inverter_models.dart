import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Inversor o microinversor del catálogo.
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('InverterModel')
class InverterModels extends Table with BaseColumns {
  /// Fabricante.
  TextColumn get manufacturer => text()();

  /// Modelo.
  TextColumn get model => text()();

  /// String, micro o híbrido.
  TextColumn get kind => textEnum<InverterKind>().withDefault(
    Constant(InverterKind.string.name),
  )();

  /// Potencia AC nominal (W).
  RealColumn get pacW => real()();

  /// Tensión DC máxima (V).
  RealColumn get vdcMaxV => real()();

  /// Tensión mínima del MPPT (V).
  RealColumn get mpptMinV => real()();

  /// Tensión máxima del MPPT (V).
  RealColumn get mpptMaxV => real()();

  /// Número de MPPT (en micros: entradas de panel).
  IntColumn get mpptCount => integer().withDefault(const Constant(1))();

  /// Corriente máxima de entrada por MPPT (A).
  RealColumn get imaxPerMpptA => real()();

  /// Corriente de cortocircuito máxima por MPPT (A).
  RealColumn get iscMaxPerMpptA => real().nullable()();

  /// Eficiencia (%; CEC o europea).
  RealColumn get efficiencyPct => real().withDefault(const Constant(96))();

  /// Fases de salida (1 o 3).
  IntColumn get phases => integer().withDefault(const Constant(1))();

  /// Tensión AC nominal (V).
  RealColumn get acVoltageV => real().withDefault(const Constant(220))();

  /// Corriente AC máxima de salida (A).
  RealColumn get iacMaxA => real().nullable()();

  /// Origen.
  TextColumn get source => textEnum<EquipmentSource>().withDefault(
    Constant(EquipmentSource.manual.name),
  )();

  /// Notas.
  TextColumn get notes => text().nullable()();
}
