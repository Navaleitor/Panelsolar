import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Visita de mantenimiento hecha (bitácora). Las fotos de la visita están
/// en `photos` con `linkedRecordId` = id de la visita.
///
/// Historial de esquema:
/// - v4: tabla nueva (F6).
@DataClassName('MaintenanceVisit')
class MaintenanceVisits extends Table with BaseColumns {
  /// Proyecto al que pertenece.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Fecha de la visita (UTC, día calendario).
  DateTimeColumn get visitDate => dateTime()();

  /// Quién la hizo.
  TextColumn get technician => text().nullable()();

  /// Ids de los servicios del plan hechos en la visita, separados por coma.
  TextColumn get doneItemIds => text().withDefault(const Constant(''))();

  /// Notas.
  TextColumn get notes => text().nullable()();
}
