import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `photos`: fotos de un proyecto por etapa.
class PhotoRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Fotos activas del proyecto, de la más nueva a la más antigua.
  /// Si se da [stage], solo las de esa etapa.
  Stream<List<Photo>> watchByProject(String projectId, {PhotoStage? stage}) {
    final select = _db.select(_db.photos)
      ..where((f) => f.projectId.equals(projectId) & f.deletedAt.isNull())
      ..orderBy([(f) => OrderingTerm.desc(f.createdAt)]);
    if (stage != null) {
      select.where((f) => f.stage.equalsValue(stage));
    }
    return select.watch();
  }

  /// `true` si el proyecto ya tiene una foto activa con ese hash.
  Future<bool> existsHash(String projectId, String sha256) async {
    final query = _db.select(_db.photos)
      ..where(
        (f) =>
            f.projectId.equals(projectId) &
            f.sha256.equals(sha256) &
            f.deletedAt.isNull(),
      )
      ..limit(1);
    return (await query.getSingleOrNull()) != null;
  }

  /// Registra una foto ya comprimida y guardada en disco.
  Future<Photo> add({
    required String projectId,
    required PhotoStage stage,
    required String filePath,
    required String sha256,
    required int widthPx,
    required int heightPx,
    double? latitude,
    double? longitude,
    DateTime? takenAt,
    String? caption,
  }) {
    return _db
        .into(_db.photos)
        .insertReturning(
          PhotosCompanion.insert(
            projectId: projectId,
            stage: stage,
            filePath: filePath,
            sha256: sha256,
            widthPx: widthPx,
            heightPx: heightPx,
            latitude: Value(latitude),
            longitude: Value(longitude),
            takenAt: Value(takenAt?.toUtc()),
            caption: Value(caption),
          ),
        );
  }

  /// Cambia la descripción de la foto.
  Future<void> updateCaption(String id, String? caption) async {
    final trimmed = caption?.trim();
    await (_db.update(_db.photos)..where((f) => f.id.equals(id))).write(
      PhotosCompanion(
        caption: Value((trimmed?.isEmpty ?? true) ? null : trimmed),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico (el archivo se conserva para poder restaurar).
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await (_db.update(_db.photos)..where((f) => f.id.equals(id))).write(
      PhotosCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }
}
