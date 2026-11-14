import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Ajustes del seguimiento de producción de un proyecto.
///
/// Historial de esquema:
/// - v4: tabla nueva (F6).
@DataClassName('ProductionSetting')
class ProductionSettings extends Table with BaseColumns {
  /// Proyecto (único).
  TextColumn get projectId => text().unique().references(Projects, #id)();

  /// Potencia pico instalada (kWp), para el Performance Ratio.
  RealColumn get systemKwp => real().nullable()();

  /// Umbral de alerta en % (negativo): −15 = avisar si lo real queda 15 %
  /// por debajo de lo esperado.
  RealColumn get alertThresholdPct => real().withDefault(const Constant(-15))();
}
