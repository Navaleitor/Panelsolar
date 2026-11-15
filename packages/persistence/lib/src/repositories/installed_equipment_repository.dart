import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/date_math.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Datos editables de un equipo instalado.
typedef EquipmentInput = ({
  EquipmentKind kind,
  String brand,
  String? model,
  String? serialNumber,
  DateTime? installedAt,
  DateTime? warrantyUntil,
  String? notes,
});

/// Acceso a `installed_equipment`: equipos instalados por proyecto.
class InstalledEquipmentRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Equipos activos del proyecto, por tipo y luego por fecha de alta.
  Stream<List<InstalledEquipmentItem>> watchByProject(String projectId) {
    final select = _db.select(_db.installedEquipment)
      ..where((e) => e.projectId.equals(projectId) & e.deletedAt.isNull())
      ..orderBy([
        (e) => OrderingTerm.asc(e.kind),
        (e) => OrderingTerm.asc(e.createdAt),
      ]);
    return select.watch();
  }

  /// Busca un equipo por `id`.
  Future<InstalledEquipmentItem?> findById(String id) => (_db.select(
    _db.installedEquipment,
  )..where((e) => e.id.equals(id))).getSingleOrNull();

  /// Registra un equipo. Lanza [ArgumentError] si la marca está vacía.
  Future<InstalledEquipmentItem> create(String projectId, EquipmentInput data) {
    return _db
        .into(_db.installedEquipment)
        .insertReturning(
          InstalledEquipmentCompanion.insert(
            projectId: projectId,
            kind: data.kind,
            brand: _brand(data.brand),
            model: Value(_clean(data.model)),
            serialNumber: Value(_clean(data.serialNumber)),
            installedAt: Value(_day(data.installedAt)),
            warrantyUntil: Value(_day(data.warrantyUntil)),
            notes: Value(_clean(data.notes)),
          ),
        );
  }

  /// Reemplaza los datos del equipo.
  Future<void> update(String id, EquipmentInput data) async {
    await (_db.update(
      _db.installedEquipment,
    )..where((e) => e.id.equals(id))).write(
      InstalledEquipmentCompanion(
        kind: Value(data.kind),
        brand: Value(_brand(data.brand)),
        model: Value(_clean(data.model)),
        serialNumber: Value(_clean(data.serialNumber)),
        installedAt: Value(_day(data.installedAt)),
        warrantyUntil: Value(_day(data.warrantyUntil)),
        notes: Value(_clean(data.notes)),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await (_db.update(
      _db.installedEquipment,
    )..where((e) => e.id.equals(id))).write(
      InstalledEquipmentCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  static String _brand(String brand) {
    final trimmed = brand.trim();
    if (trimmed.isEmpty) throw ArgumentError('La marca es obligatoria');
    return trimmed;
  }

  static DateTime? _day(DateTime? d) => d == null ? null : calendarDayUtc(d);
}

/// Texto recortado o `null` si queda vacío.
String? _clean(String? text) {
  final trimmed = text?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}
