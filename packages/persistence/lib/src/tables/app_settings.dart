import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Ajustes de la app como pares clave → valor (texto).
///
/// Historial de esquema:
/// - v6: tabla nueva (F6).
@DataClassName('AppSetting')
class AppSettings extends Table with BaseColumns {
  /// Clave única (p. ej. `backup.drive.enabled`).
  TextColumn get key => text().unique()();

  /// Valor en texto.
  TextColumn get value => text()();
}
