import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/clients.dart';

/// Proyecto (una instalación) de un cliente.
///
/// Historial de esquema:
/// - v3: tabla nueva (F1).
@DataClassName('Project')
class Projects extends Table with BaseColumns {
  /// Cliente dueño del proyecto.
  TextColumn get clientId => text().references(Clients, #id)();

  /// Nombre corto del proyecto (p. ej. "Casa Cumbres").
  TextColumn get name => text().withLength(min: 1, max: 200)();

  /// Estado actual.
  TextColumn get status => textEnum<ProjectStatus>().withDefault(
    Constant(ProjectStatus.prospect.name),
  )();

  /// Fecha de referencia del proyecto (visita, cotización...), en UTC.
  DateTimeColumn get projectDate => dateTime()();

  /// Notas libres.
  TextColumn get notes => text().nullable()();
}
