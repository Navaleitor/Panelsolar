import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/date_math.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Umbral de alerta por omisión (%): avisar si lo real queda 15 % abajo.
const double defaultAlertThresholdPct = -15;

/// Acceso a `production_readings` y `production_settings`: seguimiento de
/// producción real contra esperada.
class ProductionRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Lecturas activas del proyecto en orden cronológico.
  Stream<List<ProductionReading>> watchReadings(String projectId) {
    final select = _db.select(_db.productionReadings)
      ..where((r) => r.projectId.equals(projectId) & r.deletedAt.isNull())
      ..orderBy([(r) => OrderingTerm.asc(r.month)]);
    return select.watch();
  }

  /// Guarda la lectura de un mes: si ya hay una activa de ese mes, la
  /// reemplaza. Lanza [ArgumentError] si algún valor es negativo.
  Future<void> saveReading({
    required String projectId,
    required DateTime month,
    required double actualKwh,
    double? expectedKwh,
    double? poaIrradiationKwhM2,
    String? notes,
  }) async {
    for (final (name, v) in [
      ('actualKwh', actualKwh),
      ('expectedKwh', expectedKwh),
      ('poaIrradiationKwhM2', poaIrradiationKwhM2),
    ]) {
      if (v != null && (v.isNaN || v < 0)) {
        throw ArgumentError.value(v, name, 'no puede ser negativo');
      }
    }
    final start = monthStartUtc(month);
    final trimmed = notes?.trim();
    final companion = ProductionReadingsCompanion(
      actualKwh: Value(actualKwh),
      expectedKwh: Value(expectedKwh),
      poaIrradiationKwhM2: Value(poaIrradiationKwhM2),
      notes: Value((trimmed?.isEmpty ?? true) ? null : trimmed),
      updatedAt: Value(utcNow()),
    );
    await _db.transaction(() async {
      final existing =
          await (_db.select(_db.productionReadings)..where(
                (r) =>
                    r.projectId.equals(projectId) &
                    r.month.equals(start) &
                    r.deletedAt.isNull(),
              ))
              .getSingleOrNull();
      if (existing == null) {
        await _db
            .into(_db.productionReadings)
            .insert(
              companion.copyWith(
                projectId: Value(projectId),
                month: Value(start),
              ),
            );
      } else {
        await (_db.update(
          _db.productionReadings,
        )..where((r) => r.id.equals(existing.id))).write(companion);
      }
    });
  }

  /// Borrado lógico de una lectura.
  Future<void> softDeleteReading(String id) async {
    final now = utcNow();
    await (_db.update(
      _db.productionReadings,
    )..where((r) => r.id.equals(id))).write(
      ProductionReadingsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  /// Ajustes del proyecto o `null` si no se han guardado.
  Stream<ProductionSetting?> watchSettings(String projectId) => (_db.select(
    _db.productionSettings,
  )..where((s) => s.projectId.equals(projectId))).watchSingleOrNull();

  /// Crea o reemplaza los ajustes del proyecto.
  Future<void> saveSettings(
    String projectId, {
    required double? systemKwp,
    required double alertThresholdPct,
  }) async {
    if (systemKwp != null && (systemKwp.isNaN || systemKwp <= 0)) {
      throw ArgumentError.value(systemKwp, 'systemKwp', 'debe ser > 0');
    }
    if (alertThresholdPct > 0 || alertThresholdPct < -100) {
      throw ArgumentError.value(alertThresholdPct, 'alertThresholdPct');
    }
    await _db
        .into(_db.productionSettings)
        .insert(
          ProductionSettingsCompanion.insert(
            projectId: projectId,
            systemKwp: Value(systemKwp),
            alertThresholdPct: Value(alertThresholdPct),
          ),
          onConflict: DoUpdate(
            (_) => ProductionSettingsCompanion(
              systemKwp: Value(systemKwp),
              alertThresholdPct: Value(alertThresholdPct),
              updatedAt: Value(utcNow()),
            ),
            target: [_db.productionSettings.projectId],
          ),
        );
  }
}
