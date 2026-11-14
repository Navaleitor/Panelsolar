import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Equipo instalado en un proyecto: marca, modelo, serie y garantía.
///
/// Historial de esquema:
/// - v6: tabla nueva (F6).
@DataClassName('InstalledEquipmentItem')
class InstalledEquipment extends Table with BaseColumns {
  /// Proyecto al que pertenece.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Tipo de equipo.
  TextColumn get kind => textEnum<EquipmentKind>()();

  /// Marca.
  TextColumn get brand => text().withLength(min: 1, max: 120)();

  /// Modelo.
  TextColumn get model => text().nullable()();

  /// Número de serie.
  TextColumn get serialNumber => text().nullable()();

  /// Fecha de instalación (UTC, día calendario).
  DateTimeColumn get installedAt => dateTime().nullable()();

  /// Fin de la garantía (UTC, día calendario).
  DateTimeColumn get warrantyUntil => dateTime().nullable()();

  /// Notas.
  TextColumn get notes => text().nullable()();
}
