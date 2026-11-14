import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Historial de respaldos y restauraciones.
///
/// Historial de esquema:
/// - v4: tabla nueva (F6).
@DataClassName('BackupLog')
class BackupLogs extends Table with BaseColumns {
  /// .zip o Google Drive.
  TextColumn get target => textEnum<BackupTarget>()();

  /// Qué lo inició.
  TextColumn get trigger => textEnum<BackupTrigger>()();

  /// Resultado.
  TextColumn get status => textEnum<BackupStatus>()();

  /// Nombre del archivo (zip) o del respaldo en Drive.
  TextColumn get fileName => text().nullable()();

  /// Tamaño en bytes.
  IntColumn get sizeBytes => integer().nullable()();

  /// Archivos (fotos y documentos) incluidos o subidos.
  IntColumn get fileCount => integer().nullable()();

  /// Mensaje de error, si falló.
  TextColumn get message => text().nullable()();
}
