import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Plantilla de servicios de mantenimiento (editable). Al crear el plan de
/// un proyecto se copian estos servicios.
///
/// Historial de esquema:
/// - v6: tabla nueva (F6).
@DataClassName('MaintenanceTemplateItem')
class MaintenanceTemplateItems extends Table with BaseColumns {
  /// Tipo de servicio.
  TextColumn get kind => textEnum<MaintenanceServiceKind>()();

  /// Nombre personalizado (vacío = nombre del tipo).
  TextColumn get title => text().nullable()();

  /// Cada cuántos meses se hace.
  IntColumn get intervalMonths => integer()();

  /// Si se incluye al crear un plan.
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  /// Orden en la lista.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
