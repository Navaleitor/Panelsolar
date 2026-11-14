import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/date_math.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Datos editables del checklist de puesta en marcha.
typedef CommissioningInput = ({
  CommissioningStatus status,
  DateTime? testedAt,
  String? technician,
  bool? polarityOk,
  double? insulationMohm,
  double? insulationTestVoltageV,
  bool? groundingOk,
  double? groundingOhm,
  bool? labelingOk,
  String? notes,
});

/// Datos editables de la medición de un string.
typedef StringTestInput = ({
  String label,
  double? expectedVocV,
  double? measuredVocV,
  double? expectedIscA,
  double? measuredIscA,
  bool? polarityOk,
});

/// Acceso a `commissioning_records` y `string_tests` (IEC 62446-1).
class CommissioningRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Checklist del proyecto o `null` si aún no se crea.
  Stream<CommissioningRecord?> watchRecord(String projectId) =>
      (_db.select(
            _db.commissioningRecords,
          )..where((c) => c.projectId.equals(projectId) & c.deletedAt.isNull()))
          .watchSingleOrNull();

  /// Crea o reemplaza el checklist del proyecto.
  Future<void> saveRecord(String projectId, CommissioningInput data) async {
    final companion = CommissioningRecordsCompanion(
      status: Value(data.status),
      testedAt: Value(
        data.testedAt == null ? null : calendarDayUtc(data.testedAt!),
      ),
      technician: Value(_clean(data.technician)),
      polarityOk: Value(data.polarityOk),
      insulationMohm: Value(data.insulationMohm),
      insulationTestVoltageV: Value(data.insulationTestVoltageV),
      groundingOk: Value(data.groundingOk),
      groundingOhm: Value(data.groundingOhm),
      labelingOk: Value(data.labelingOk),
      notes: Value(_clean(data.notes)),
      updatedAt: Value(utcNow()),
    );
    await _db.transaction(() async {
      final existing = await (_db.select(
        _db.commissioningRecords,
      )..where((c) => c.projectId.equals(projectId))).getSingleOrNull();
      if (existing == null) {
        await _db
            .into(_db.commissioningRecords)
            .insert(companion.copyWith(projectId: Value(projectId)));
      } else {
        await (_db.update(_db.commissioningRecords)
              ..where((c) => c.id.equals(existing.id)))
            .write(companion.copyWith(deletedAt: const Value(null)));
      }
    });
  }

  /// Strings medidos del proyecto, en orden.
  Stream<List<StringTest>> watchStrings(String projectId) {
    final select = _db.select(_db.stringTests)
      ..where((s) => s.projectId.equals(projectId) & s.deletedAt.isNull())
      ..orderBy([
        (s) => OrderingTerm.asc(s.sortOrder),
        (s) => OrderingTerm.asc(s.createdAt),
      ]);
    return select.watch();
  }

  /// Agrega un string al final de la lista.
  Future<StringTest> addString(String projectId, StringTestInput data) async {
    final count = await (_db.select(
      _db.stringTests,
    )..where((s) => s.projectId.equals(projectId))).get();
    return await _db
        .into(_db.stringTests)
        .insertReturning(
          StringTestsCompanion.insert(
            projectId: projectId,
            label: _label(data.label),
            sortOrder: Value(count.length),
            expectedVocV: Value(data.expectedVocV),
            measuredVocV: Value(data.measuredVocV),
            expectedIscA: Value(data.expectedIscA),
            measuredIscA: Value(data.measuredIscA),
            polarityOk: Value(data.polarityOk),
          ),
        );
  }

  /// Reemplaza las mediciones de un string.
  Future<void> updateString(String id, StringTestInput data) async {
    await (_db.update(_db.stringTests)..where((s) => s.id.equals(id))).write(
      StringTestsCompanion(
        label: Value(_label(data.label)),
        expectedVocV: Value(data.expectedVocV),
        measuredVocV: Value(data.measuredVocV),
        expectedIscA: Value(data.expectedIscA),
        measuredIscA: Value(data.measuredIscA),
        polarityOk: Value(data.polarityOk),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico de un string.
  Future<void> softDeleteString(String id) async {
    final now = utcNow();
    await (_db.update(_db.stringTests)..where((s) => s.id.equals(id))).write(
      StringTestsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  static String _label(String label) {
    final trimmed = label.trim();
    if (trimmed.isEmpty) throw ArgumentError('El nombre es obligatorio');
    return trimmed;
  }
}

String? _clean(String? text) {
  final trimmed = text?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}
