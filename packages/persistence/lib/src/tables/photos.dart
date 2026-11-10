import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Foto de un proyecto, ya comprimida (≈1600 px, JPEG 80 %, plan A.4).
///
/// Historial de esquema:
/// - v3: tabla nueva (F1).
@DataClassName('Photo')
class Photos extends Table with BaseColumns {
  /// Proyecto al que pertenece.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Etapa: levantamiento, instalación o mantenimiento.
  TextColumn get stage => textEnum<PhotoStage>()();

  /// Ruta relativa al directorio de archivos de la app.
  TextColumn get filePath => text()();

  /// SHA-256 (hex) del archivo guardado: detecta duplicados y sirve al
  /// respaldo incremental.
  TextColumn get sha256 => text()();

  /// Ancho en píxeles.
  IntColumn get widthPx => integer()();

  /// Alto en píxeles.
  IntColumn get heightPx => integer()();

  /// Latitud donde se tomó (EXIF o GPS del teléfono), si existe.
  RealColumn get latitude => real().nullable()();

  /// Longitud donde se tomó, si existe.
  RealColumn get longitude => real().nullable()();

  /// Momento de la toma (UTC), si se conoce.
  DateTimeColumn get takenAt => dateTime().nullable()();

  /// Descripción opcional.
  TextColumn get caption => text().nullable()();
}
