import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Optimizador de potencia del catálogo (datos básicos).
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('OptimizerModel')
class OptimizerModels extends Table with BaseColumns {
  /// Fabricante.
  TextColumn get manufacturer => text()();

  /// Modelo.
  TextColumn get model => text()();

  /// Potencia de entrada máxima (W).
  RealColumn get pmaxInW => real()();

  /// Tensión de entrada máxima (V).
  RealColumn get vinMaxV => real()();

  /// Corriente de entrada máxima (A).
  RealColumn get imaxInA => real()();

  /// Tensión de salida máxima (V).
  RealColumn get voutMaxV => real().nullable()();

  /// Corriente de salida máxima (A).
  RealColumn get ioutMaxA => real().nullable()();

  /// Eficiencia (%).
  RealColumn get efficiencyPct => real().withDefault(const Constant(99))();

  /// Origen.
  TextColumn get source => textEnum<EquipmentSource>().withDefault(
    Constant(EquipmentSource.manual.name),
  )();

  /// Notas.
  TextColumn get notes => text().nullable()();
}
