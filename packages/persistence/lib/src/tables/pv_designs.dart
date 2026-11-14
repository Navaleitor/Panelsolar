import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Diseño FV de un proyecto (uno por proyecto): equipos elegidos y
/// ajustes. Los ids de equipos apuntan al catálogo.
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('PvDesign')
class PvDesigns extends Table with BaseColumns {
  /// Proyecto (único).
  TextColumn get projectId => text().unique().references(Projects, #id)();

  /// Panel elegido (`panel_models.id`).
  TextColumn get panelModelId => text().nullable()();

  /// Inversor elegido (`inverter_models.id`).
  TextColumn get inverterModelId => text().nullable()();

  /// Número de inversores (o de microinversores).
  IntColumn get inverterCount => integer().withDefault(const Constant(1))();

  /// Optimizador elegido (`optimizer_models.id`), si hay.
  TextColumn get optimizerModelId => text().nullable()();

  /// Batería elegida (`battery_models.id`), si hay.
  TextColumn get batteryModelId => text().nullable()();

  /// Tensión máxima del sistema por norma (V).
  RealColumn get systemVoltageLimitV =>
      real().withDefault(const Constant(600))();

  /// Pérdidas editables en JSON (`{"soiling":2,...}`, %).
  TextColumn get losses => text().withDefault(const Constant('{}'))();

  /// Umbral de sombra para excluir paneles (%).
  RealColumn get shadeThresholdPct => real().withDefault(const Constant(10))();

  /// Tensión de la red (V).
  RealColumn get gridVoltageV => real().withDefault(const Constant(220))();

  /// Ajustes de viento en JSON (velocidad, exposición, GCrn...).
  TextColumn get wind => text().withDefault(const Constant('{}'))();
}
