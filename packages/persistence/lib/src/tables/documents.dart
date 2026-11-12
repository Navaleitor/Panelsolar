import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Documento adjunto a un proyecto (contrato, trámite, garantía...) en PDF o
/// imagen.
///
/// Historial de esquema:
/// - v3: tabla nueva (F1).
@DataClassName('Document')
class Documents extends Table with BaseColumns {
  /// Proyecto al que pertenece.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Título visible (por defecto, el nombre del archivo).
  TextColumn get title => text().withLength(min: 1, max: 200)();

  /// PDF o imagen.
  TextColumn get kind => textEnum<DocumentKind>()();

  /// Ruta relativa al directorio de archivos de la app.
  TextColumn get filePath => text()();

  /// Tipo MIME (p. ej. `application/pdf`).
  TextColumn get mimeType => text()();

  /// Tamaño en bytes.
  IntColumn get sizeBytes => integer()();

  /// SHA-256 (hex) del archivo.
  TextColumn get sha256 => text()();
}
