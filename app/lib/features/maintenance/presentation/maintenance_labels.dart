import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:persistence/persistence.dart';

/// Nombre visible de un servicio: el personalizado o el del tipo.
String serviceLabel(
  AppLocalizations l10n,
  MaintenanceServiceKind kind,
  String? title,
) {
  if (title != null && title.trim().isNotEmpty) return title;
  return switch (kind) {
    MaintenanceServiceKind.cleaning => l10n.serviceCleaning,
    MaintenanceServiceKind.visualInspection => l10n.serviceVisualInspection,
    MaintenanceServiceKind.connectionTightening => l10n.serviceTightening,
    MaintenanceServiceKind.inverterCheck => l10n.serviceInverter,
    MaintenanceServiceKind.protectionsCheck => l10n.serviceProtections,
    MaintenanceServiceKind.thermography => l10n.serviceThermography,
    MaintenanceServiceKind.other => l10n.serviceOther,
  };
}
