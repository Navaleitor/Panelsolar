import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/clients.dart';

/// Recibo de luz de un cliente: un periodo con su consumo e importe.
///
/// Historial de esquema:
/// - v3: tabla nueva (F1).
@DataClassName('UtilityBill')
class UtilityBills extends Table with BaseColumns {
  /// Cliente al que pertenece el recibo.
  TextColumn get clientId => text().references(Clients, #id)();

  /// Inicio del periodo facturado (UTC, día completo).
  DateTimeColumn get periodStart => dateTime()();

  /// Fin del periodo facturado (UTC, inclusivo).
  DateTimeColumn get periodEnd => dateTime()();

  /// Mensual o bimestral.
  TextColumn get billingPeriod => textEnum<BillingPeriod>()();

  /// Energía consumida en el periodo, en kWh.
  RealColumn get energyKwh => real()();

  /// Importe total en centavos de la moneda (evita errores de redondeo).
  IntColumn get amountCents => integer().nullable()();

  /// Moneda ISO 4217 (p. ej. `MXN`).
  TextColumn get currency => text().withDefault(const Constant('MXN'))();

  /// Código de tarifa del paquete regional (p. ej. `MX-CFE-1C`).
  TextColumn get tariffCode => text().nullable()();
}
