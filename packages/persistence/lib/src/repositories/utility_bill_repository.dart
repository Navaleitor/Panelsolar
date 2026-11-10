import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `utility_bills`: recibos de luz de un cliente.
class UtilityBillRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Recibos activos del cliente en orden cronológico (más antiguo primero).
  Stream<List<UtilityBill>> watchByClient(String clientId) {
    final select = _db.select(_db.utilityBills)
      ..where((b) => b.clientId.equals(clientId) & b.deletedAt.isNull())
      ..orderBy([(b) => OrderingTerm.asc(b.periodStart)]);
    return select.watch();
  }

  /// Recibos activos del cliente en orden cronológico (lectura única).
  Future<List<UtilityBill>> listByClient(String clientId) {
    final select = _db.select(_db.utilityBills)
      ..where((b) => b.clientId.equals(clientId) & b.deletedAt.isNull())
      ..orderBy([(b) => OrderingTerm.asc(b.periodStart)]);
    return select.get();
  }

  /// Busca un recibo por `id`.
  Future<UtilityBill?> findById(String id) => (_db.select(
    _db.utilityBills,
  )..where((b) => b.id.equals(id))).getSingleOrNull();

  /// Registra un recibo. Lanza [ArgumentError] si el periodo o los kWh no
  /// son válidos.
  Future<UtilityBill> create({
    required String clientId,
    required DateTime periodStart,
    required DateTime periodEnd,
    required BillingPeriod billingPeriod,
    required double energyKwh,
    int? amountCents,
    String currency = 'MXN',
    String? tariffCode,
  }) {
    _validate(periodStart, periodEnd, energyKwh);
    return _db
        .into(_db.utilityBills)
        .insertReturning(
          UtilityBillsCompanion.insert(
            clientId: clientId,
            periodStart: periodStart.toUtc(),
            periodEnd: periodEnd.toUtc(),
            billingPeriod: billingPeriod,
            energyKwh: energyKwh,
            amountCents: Value(amountCents),
            currency: Value(currency),
            tariffCode: Value(tariffCode),
          ),
        );
  }

  /// Reemplaza los datos del recibo y renueva `updatedAt`.
  Future<void> update(
    String id, {
    required DateTime periodStart,
    required DateTime periodEnd,
    required BillingPeriod billingPeriod,
    required double energyKwh,
    int? amountCents,
    String currency = 'MXN',
    String? tariffCode,
  }) async {
    _validate(periodStart, periodEnd, energyKwh);
    await (_db.update(_db.utilityBills)..where((b) => b.id.equals(id))).write(
      UtilityBillsCompanion(
        periodStart: Value(periodStart.toUtc()),
        periodEnd: Value(periodEnd.toUtc()),
        billingPeriod: Value(billingPeriod),
        energyKwh: Value(energyKwh),
        amountCents: Value(amountCents),
        currency: Value(currency),
        tariffCode: Value(tariffCode),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico del recibo.
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await (_db.update(_db.utilityBills)..where((b) => b.id.equals(id))).write(
      UtilityBillsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  void _validate(DateTime start, DateTime end, double kwh) {
    if (end.isBefore(start)) {
      throw ArgumentError('El fin del periodo es anterior al inicio');
    }
    if (kwh.isNaN || kwh < 0) {
      throw ArgumentError.value(kwh, 'energyKwh', 'no puede ser negativo');
    }
  }
}
