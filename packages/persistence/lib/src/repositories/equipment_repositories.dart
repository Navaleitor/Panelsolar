import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Revisa que un valor sea positivo.
void _positive(String name, double? v) {
  if (v != null && !(v > 0)) {
    throw ArgumentError.value(v, name, 'debe ser mayor que 0');
  }
}

/// Acceso a `panel_models` (catálogo de paneles).
class PanelModelRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  /// Paneles activos por fabricante y modelo.
  Stream<List<PanelModel>> watchAll() =>
      (_db.select(_db.panelModels)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([
              (t) => OrderingTerm.asc(t.manufacturer),
              (t) => OrderingTerm.asc(t.model),
            ]))
          .watch();

  /// Un panel por id (también borrado, para diseños viejos).
  Future<PanelModel?> find(String id) => (_db.select(
    _db.panelModels,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Guarda un panel nuevo (o lo reemplaza si [row] ya existe).
  Future<PanelModel> save(PanelModelsCompanion row) async {
    for (final (n, v) in [
      ('pmaxW', row.pmaxW.value),
      ('vocV', row.vocV.value),
      ('iscA', row.iscA.value),
      ('vmpV', row.vmpV.value),
      ('impA', row.impA.value),
      ('lengthM', row.lengthM.value),
      ('widthM', row.widthM.value),
    ]) {
      _positive(n, v);
    }
    if (row.vmpV.value >= row.vocV.value) {
      throw ArgumentError.value(row.vmpV.value, 'vmpV', 'debe ser < Voc');
    }
    return await _db
        .into(_db.panelModels)
        .insertReturning(
          row.copyWith(updatedAt: Value(utcNow())),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) =>
      (_db.update(_db.panelModels)..where((t) => t.id.equals(id))).write(
        PanelModelsCompanion(
          deletedAt: Value(utcNow()),
          updatedAt: Value(utcNow()),
        ),
      );
}

/// Acceso a `inverter_models`.
class InverterModelRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  /// Inversores activos.
  Stream<List<InverterModel>> watchAll() =>
      (_db.select(_db.inverterModels)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([
              (t) => OrderingTerm.asc(t.manufacturer),
              (t) => OrderingTerm.asc(t.model),
            ]))
          .watch();

  /// Un inversor por id.
  Future<InverterModel?> find(String id) => (_db.select(
    _db.inverterModels,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Guarda un inversor.
  Future<InverterModel> save(InverterModelsCompanion row) async {
    for (final (n, v) in [
      ('pacW', row.pacW.value),
      ('vdcMaxV', row.vdcMaxV.value),
      ('mpptMinV', row.mpptMinV.value),
      ('mpptMaxV', row.mpptMaxV.value),
      ('imaxPerMpptA', row.imaxPerMpptA.value),
    ]) {
      _positive(n, v);
    }
    if (row.mpptMinV.value >= row.mpptMaxV.value ||
        row.mpptMaxV.value > row.vdcMaxV.value) {
      throw ArgumentError('Rango MPPT inválido');
    }
    return await _db
        .into(_db.inverterModels)
        .insertReturning(
          row.copyWith(updatedAt: Value(utcNow())),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) =>
      (_db.update(_db.inverterModels)..where((t) => t.id.equals(id))).write(
        InverterModelsCompanion(
          deletedAt: Value(utcNow()),
          updatedAt: Value(utcNow()),
        ),
      );
}

/// Acceso a `optimizer_models`.
class OptimizerModelRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  /// Optimizadores activos.
  Stream<List<OptimizerModel>> watchAll() =>
      (_db.select(_db.optimizerModels)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.manufacturer)]))
          .watch();

  /// Guarda un optimizador.
  Future<OptimizerModel> save(OptimizerModelsCompanion row) async {
    _positive('pmaxInW', row.pmaxInW.value);
    _positive('vinMaxV', row.vinMaxV.value);
    _positive('imaxInA', row.imaxInA.value);
    return await _db
        .into(_db.optimizerModels)
        .insertReturning(
          row.copyWith(updatedAt: Value(utcNow())),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) =>
      (_db.update(_db.optimizerModels)..where((t) => t.id.equals(id))).write(
        OptimizerModelsCompanion(
          deletedAt: Value(utcNow()),
          updatedAt: Value(utcNow()),
        ),
      );
}

/// Acceso a `battery_models`.
class BatteryModelRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  /// Baterías activas.
  Stream<List<BatteryModel>> watchAll() =>
      (_db.select(_db.batteryModels)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.manufacturer)]))
          .watch();

  /// Guarda una batería.
  Future<BatteryModel> save(BatteryModelsCompanion row) async {
    _positive('capacityKwh', row.capacityKwh.value);
    _positive('nominalVoltageV', row.nominalVoltageV.value);
    return await _db
        .into(_db.batteryModels)
        .insertReturning(
          row.copyWith(updatedAt: Value(utcNow())),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) =>
      (_db.update(_db.batteryModels)..where((t) => t.id.equals(id))).write(
        BatteryModelsCompanion(
          deletedAt: Value(utcNow()),
          updatedAt: Value(utcNow()),
        ),
      );
}
