import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `sites`: la ubicación (una por proyecto).
class SiteRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Observa el sitio activo del proyecto (o `null` si aún no tiene).
  Stream<Site?> watchForProject(String projectId) => (_db.select(
    _db.sites,
  )..where((s) => s.projectId.equals(projectId))).watchSingleOrNull();

  /// Guarda la ubicación del proyecto: crea el sitio o reemplaza el
  /// existente. Lanza [ArgumentError] si las coordenadas están fuera de
  /// rango.
  Future<Site> save({
    required String projectId,
    required double latitude,
    required double longitude,
    required LocationSource source,
    double? altitudeM,
    String? timeZone,
    String? sourceText,
    double? accuracyM,
  }) async {
    if (latitude.isNaN || latitude < -90 || latitude > 90) {
      throw ArgumentError.value(
        latitude,
        'latitude',
        'debe estar en [-90, 90]',
      );
    }
    if (longitude.isNaN || longitude < -180 || longitude > 180) {
      throw ArgumentError.value(
        longitude,
        'longitude',
        'debe estar en [-180, 180]',
      );
    }
    final companion = SitesCompanion(
      projectId: Value(projectId),
      latitude: Value(latitude),
      longitude: Value(longitude),
      altitudeM: Value(altitudeM),
      timeZone: Value(timeZone),
      source: Value(source),
      sourceText: Value(sourceText),
      accuracyM: Value(accuracyM),
      updatedAt: Value(utcNow()),
      deletedAt: const Value(null),
    );
    return await _db.transaction(() async {
      final existing = await (_db.select(
        _db.sites,
      )..where((s) => s.projectId.equals(projectId))).getSingleOrNull();
      if (existing == null) {
        return await _db.into(_db.sites).insertReturning(companion);
      }
      final updated = await (_db.update(
        _db.sites,
      )..where((s) => s.id.equals(existing.id))).writeReturning(companion);
      return updated.single;
    });
  }
}
