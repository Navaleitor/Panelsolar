import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `roof_images`: la base del techo de cada proyecto (imagen
/// calibrada o croquis), una por proyecto.
class RoofImageRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  SimpleSelectStatement<$RoofImagesTable, RoofImage> _byProject(String id) =>
      _db.select(_db.roofImages)
        ..where((r) => r.projectId.equals(id) & r.deletedAt.isNull());

  /// Observa la base del techo del proyecto (o `null`).
  Stream<RoofImage?> watchForProject(String projectId) =>
      _byProject(projectId).watchSingleOrNull();

  /// Lee la base del techo del proyecto (o `null`).
  Future<RoofImage?> getForProject(String projectId) =>
      _byProject(projectId).getSingleOrNull();

  /// Guarda una imagen nueva. Borra la calibración y el norte anteriores
  /// porque ya no corresponden a esta imagen.
  Future<RoofImage> saveImage({
    required String projectId,
    required String filePath,
    required String sha256,
    required int widthPx,
    required int heightPx,
  }) => _upsert(
    projectId,
    RoofImagesCompanion(
      mode: const Value(RoofMode.image),
      filePath: Value(filePath),
      sha256: Value(sha256),
      widthPx: Value(widthPx),
      heightPx: Value(heightPx),
      metersPerPixel: const Value(null),
      calibrationLine: const Value(null),
      verificationLine: const Value(null),
      northAngleDeg: const Value(0),
      northSource: const Value(NorthSource.imageUp),
      magneticDeclinationDeg: const Value(null),
    ),
  );

  /// Cambia al modo croquis con cinta (sin imagen): las medidas ya están en
  /// metros, así que no hay escala; el norte queda arriba.
  Future<RoofImage> startSketch(String projectId) => _upsert(
    projectId,
    const RoofImagesCompanion(
      mode: Value(RoofMode.sketch),
      filePath: Value(null),
      sha256: Value(null),
      widthPx: Value(null),
      heightPx: Value(null),
      metersPerPixel: Value(null),
      calibrationLine: Value(null),
      verificationLine: Value(null),
    ),
  );

  /// Guarda la escala y las líneas (JSON) de calibración y verificación.
  Future<RoofImage> saveCalibration({
    required String projectId,
    required double metersPerPixel,
    required String calibrationLine,
    String? verificationLine,
  }) {
    if (!(metersPerPixel > 0) || !metersPerPixel.isFinite) {
      throw ArgumentError.value(
        metersPerPixel,
        'metersPerPixel',
        'debe ser > 0',
      );
    }
    return _upsert(
      projectId,
      RoofImagesCompanion(
        metersPerPixel: Value(metersPerPixel),
        calibrationLine: Value(calibrationLine),
        verificationLine: Value(verificationLine),
      ),
    );
  }

  /// Guarda la orientación al norte.
  Future<RoofImage> saveNorth({
    required String projectId,
    required double northAngleDeg,
    required NorthSource source,
    double? magneticDeclinationDeg,
  }) => _upsert(
    projectId,
    RoofImagesCompanion(
      northAngleDeg: Value(northAngleDeg % 360),
      northSource: Value(source),
      magneticDeclinationDeg: Value(magneticDeclinationDeg),
    ),
  );

  Future<RoofImage> _upsert(String projectId, RoofImagesCompanion changes) =>
      _db.transaction(() async {
        final existing = await (_db.select(
          _db.roofImages,
        )..where((r) => r.projectId.equals(projectId))).getSingleOrNull();
        final c = changes.copyWith(
          updatedAt: Value(utcNow()),
          deletedAt: const Value(null),
        );
        if (existing == null) {
          return await _db
              .into(_db.roofImages)
              .insertReturning(
                c.copyWith(
                  projectId: Value(projectId),
                  mode: c.mode.present ? c.mode : const Value(RoofMode.image),
                ),
              );
        }
        final updated = await (_db.update(
          _db.roofImages,
        )..where((r) => r.id.equals(existing.id))).writeReturning(c);
        return updated.single;
      });
}
