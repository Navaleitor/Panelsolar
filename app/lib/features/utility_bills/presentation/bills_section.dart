import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/utility_bills/domain/consumption_summary.dart';
import 'package:panelsolar/features/utility_bills/presentation/bill_list_providers.dart';
import 'package:panelsolar/features/utility_bills/presentation/billing_period_label.dart';
import 'package:panelsolar/features/utility_bills/presentation/widgets/consumption_chart.dart';
import 'package:panelsolar/features/utility_bills/presentation/widgets/consumption_summary_card.dart';
import 'package:persistence/persistence.dart';
import 'package:regional_packs/regional_packs.dart';

/// Recibos de luz del cliente: resumen, gráfica y lista (en la ficha del
/// cliente). La proyección de ahorro llega en F5.
class BillsSection extends ConsumerWidget {
  const new({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final bills = ref.watch(billsProvider(clientId)).value ?? const [];
    final summary = ConsumptionSummary.fromBills(toPeriodData(bills));
    final tariff = bills.isEmpty
        ? null
        : mexicoTariffs.byCode(bills.last.tariffCode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l10n.billsTitle,
          action: TextButton.icon(
            key: const Key('bill-add'),
            onPressed: () => context.push(AppRoutes.billNew(clientId)),
            icon: const Icon(Icons.add),
            label: Text(l10n.actionAdd),
          ),
        ),
        if (summary == null)
          ListTile(title: Text(l10n.billsEmpty))
        else ...[
          ConsumptionSummaryCard(summary: summary, tariff: tariff),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 16, 0),
            child: ConsumptionChart(bills: bills),
          ),
          for (final b in bills.reversed)
            _BillTile(clientId: clientId, bill: b),
        ],
      ],
    );
  }
}

class _BillTile extends StatelessWidget {
  const new({required this.clientId, required this.bill});

  final String clientId;
  final UtilityBill bill;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final tariff = mexicoTariffs.byCode(bill.tariffCode);
    final details = [
      billingPeriodLabel(l10n, bill.billingPeriod),
      ?tariff?.shortName,
      if (bill.amountCents != null)
        Formatters.money(bill.amountCents!, bill.currency, locale),
    ].join(' · ');
    return ListTile(
      leading: const Icon(Icons.receipt),
      title: Text(
        '${Formatters.date(bill.periodStart, locale)} – '
        '${Formatters.date(bill.periodEnd, locale)}',
      ),
      subtitle: Text(details),
      trailing: Text(
        '${Formatters.number(bill.energyKwh, locale)} kWh',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () => context.push(AppRoutes.billEdit(clientId, bill.id)),
    );
  }
}
