import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Resultado de la simulación del sistema diseñado. La clase no se llama
/// `SimulationResult` para no chocar con la del motor.
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('SimulationResultRecord')
class SimulationResults extends Table with BaseColumns {
  /// Proyecto.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Potencia DC (W).
  RealColumn get pdcW => real()();

  /// Potencia AC (W).
  RealColumn get pacW => real()();

  /// Energía del primer año (kWh).
  RealColumn get firstYearKwh => real()();

  /// Energía de toda la vida útil (kWh).
  RealColumn get lifetimeKwh => real()();

  /// Años de vida útil simulados.
  IntColumn get years => integer().withDefault(const Constant(25))();

  /// Energía mensual del primer año en JSON (12 valores, kWh).
  TextColumn get monthlyKwh => text()();

  /// Energía por año en JSON (kWh).
  TextColumn get yearlyKwh => text()();

  /// Recorte anual (kWh).
  RealColumn get clippedKwh => real().withDefault(const Constant(0))();

  /// Pérdida por sombra (%).
  RealColumn get shadingLossPct => real().withDefault(const Constant(0))();

  /// Rendimiento específico (kWh/kWp).
  RealColumn get specificYield => real()();

  /// Performance ratio.
  RealColumn get performanceRatio => real()();

  /// Pérdidas usadas en JSON (%).
  TextColumn get losses => text().withDefault(const Constant('{}'))();

  /// Fuente del clima ("NASA POWER 2021–2025").
  TextColumn get weatherLabel => text().nullable()();
}
