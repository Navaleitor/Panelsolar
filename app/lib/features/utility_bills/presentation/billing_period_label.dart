import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:persistence/persistence.dart';
import 'package:regional_packs/regional_packs.dart';

/// Nombre traducido del periodo de facturación.
String billingPeriodLabel(AppLocalizations l10n, BillingPeriod period) =>
    switch (period) {
      BillingPeriod.monthly => l10n.periodMonthly,
      BillingPeriod.bimonthly => l10n.periodBimonthly,
    };

/// Periodo de la base equivalente al habitual de una tarifa.
BillingPeriod billingPeriodOf(Tariff tariff) => switch (tariff.billingPeriod) {
  TariffBillingPeriod.monthly => BillingPeriod.monthly,
  TariffBillingPeriod.bimonthly => BillingPeriod.bimonthly,
};
