import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Servicio del plan de mantenimiento de un proyecto, con su frecuencia y
/// la fecha de la próxima visita.
///
/// Historial de esquema:
/// - v6: tabla nueva (F6).
@DataClassName('MaintenancePlanItem')
class MaintenancePlanItems extends Table with BaseColumns {
  /// Proyecto al que pertenece.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Tipo de servicio.
  TextColumn get kind => textEnum<MaintenanceServiceKind>()();

  /// Nombre personalizado (vacío = nombre del tipo).
  TextColumn get title => text().nullable()();

  /// Cada cuántos meses se hace.
  IntColumn get intervalMonths => integer()();

  /// Última vez que se hizo (UTC, día calendario).
  DateTimeColumn get lastDoneAt => dateTime().nullable()();

  /// Próxima fecha programada (UTC, día calendario).
  DateTimeColumn get nextDueAt => dateTime()();

  /// Orden en la lista.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
