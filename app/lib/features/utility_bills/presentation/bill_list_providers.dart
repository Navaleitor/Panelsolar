import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/features/utility_bills/domain/consumption_summary.dart';
import 'package:persistence/persistence.dart';

/// Recibos activos del cliente en orden cronológico.
final StreamProviderFamily<List<UtilityBill>, String> billsProvider =
    StreamProvider.autoDispose.family<List<UtilityBill>, String>(
      (ref, clientId) =>
          ref.watch(utilityBillRepositoryProvider).watchByClient(clientId),
    );

/// Convierte filas de la base al modelo del cálculo de consumo.
List<BillPeriodData> toPeriodData(List<UtilityBill> bills) => [
  for (final b in bills)
    BillPeriodData(
      start: b.periodStart,
      end: b.periodEnd,
      energyKwh: b.energyKwh,
      amountCents: b.amountCents,
    ),
];
