// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Panelsolar';

  @override
  String get navClients => 'Clients';

  @override
  String get navProjects => 'Projects';

  @override
  String get navCatalog => 'Catalog';

  @override
  String get navMaintenance => 'Maintenance';

  @override
  String get navSettings => 'Settings';

  @override
  String get clientsDescription =>
      'Contact details, utility bills and consumption for each client.';

  @override
  String get projectsDescription =>
      'Site, roof, weather, design and reports for each installation.';

  @override
  String get catalogDescription =>
      'Panels, inverters, batteries and mounting structures.';

  @override
  String get maintenanceDescription =>
      'Service plans, reminders and visit log.';

  @override
  String get settingsDescription =>
      'Company profile, language, units and backup.';

  @override
  String comingInPhase(String phase) {
    return 'Available in phase $phase.';
  }

  @override
  String get settingsDatabaseTitle => 'Database';

  @override
  String settingsDatabaseOk(int version) {
    return 'Working · schema v$version';
  }

  @override
  String get settingsDatabaseError => 'Could not open the database';
}
