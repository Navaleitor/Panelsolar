import 'package:flutter/material.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/utility_bills/domain/consumption_summary.dart';
import 'package:regional_packs/regional_packs.dart';

/// Cifras clave del consumo: anual, mensual, diario, gasto anual y aviso
/// de alto consumo (DAC) si aplica a la tarifa del último recibo.
class ConsumptionSummaryCard extends StatelessWidget {
  const new({required this.summary, this.tariff, super.key});

  final ConsumptionSummary summary;

  /// Tarifa del recibo más reciente (para el aviso DAC).
  final Tariff? tariff;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final theme = Theme.of(context);
    String kwh(double v) => '${Formatters.number(v, locale)} kWh';
    final daily = Formatters.number(summary.avgDailyKwh, locale, decimals: 1);
    final overDac =
        tariff?.exceedsHighConsumptionLimit(summary.avgMonthlyKwh) ?? false;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.consumptionAnnual, style: theme.textTheme.labelLarge),
            Text(
              kwh(summary.annualKwh),
              key: const Key('consumption-annual'),
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.consumptionMonthly}: ${kwh(summary.avgMonthlyKwh)} · '
              '${l10n.consumptionDaily}: $daily kWh',
            ),
            if (summary.annualAmountCents case final cents?)
              Text(
                '${l10n.consumptionAnnualCost}: '
                '${Formatters.money(cents, 'MXN', locale)}',
              ),
            if (!summary.coversFullYear)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  l10n.consumptionPartialYear(summary.coveredDays),
                  style: TextStyle(color: theme.colorScheme.tertiary),
                ),
              ),
            if (overDac)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: theme.colorScheme.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.consumptionDacWarning(
                          tariff!.shortName,
                          Formatters.number(
                            tariff!.highConsumptionLimitKwhPerMonth!,
                            locale,
                          ),
                        ),
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
