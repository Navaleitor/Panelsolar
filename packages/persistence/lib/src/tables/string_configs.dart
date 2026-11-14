import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Grupo de strings iguales en una entrada MPPT.
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('StringConfig')
class StringConfigs extends Table with BaseColumns {
  /// Proyecto.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Inversor (0 = el primero).
  IntColumn get inverterIndex => integer().withDefault(const Constant(0))();

  /// Entrada MPPT (0 = la primera).
  IntColumn get mpptIndex => integer().withDefault(const Constant(0))();

  /// Paneles en serie.
  IntColumn get series => integer()();

  /// Strings en paralelo.
  IntColumn get parallel => integer().withDefault(const Constant(1))();

  /// `true` si el usuario lo cambió a mano.
  BoolColumn get edited => boolean().withDefault(const Constant(false))();

  /// Orden.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
