import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `documents`: archivos PDF o imagen adjuntos a un proyecto.
class DocumentRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Documentos activos del proyecto, del más nuevo al más antiguo.
  Stream<List<Document>> watchByProject(String projectId) {
    final select = _db.select(_db.documents)
      ..where((d) => d.projectId.equals(projectId) & d.deletedAt.isNull())
      ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]);
    return select.watch();
  }

  /// Registra un documento ya copiado al almacenamiento de la app.
  Future<Document> add({
    required String projectId,
    required String title,
    required DocumentKind kind,
    required String filePath,
    required String mimeType,
    required int sizeBytes,
    required String sha256,
  }) {
    return _db
        .into(_db.documents)
        .insertReturning(
          DocumentsCompanion.insert(
            projectId: projectId,
            title: title.trim(),
            kind: kind,
            filePath: filePath,
            mimeType: mimeType,
            sizeBytes: sizeBytes,
            sha256: sha256,
          ),
        );
  }

  /// Cambia el título visible.
  Future<void> rename(String id, String title) async {
    await (_db.update(_db.documents)..where((d) => d.id.equals(id))).write(
      DocumentsCompanion(
        title: Value(title.trim()),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico (el archivo se conserva para poder restaurar).
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await (_db.update(_db.documents)..where((d) => d.id.equals(id))).write(
      DocumentsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }
}
