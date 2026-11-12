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

  @override
  String get weatherTitle => 'Weather and yield';

  @override
  String get weatherEntryTitle => 'Weather and yield (F2 test)';

  @override
  String get weatherEntrySubtitle =>
      'Downloads weather for a coordinate and estimates yield.';

  @override
  String get weatherIntro =>
      'Estimated yield of a 1 kWp system at the optimal orientation. Data: NASA POWER (5 years) and PVGIS.';

  @override
  String get weatherLatitude => 'Latitude (°)';

  @override
  String get weatherLongitude => 'Longitude (°)';

  @override
  String get weatherInvalidCoordinate => 'Enter a valid number';

  @override
  String get weatherAnalyze => 'Download weather and calculate';

  @override
  String get weatherRefresh => 'Download again';

  @override
  String get weatherLoading => 'Downloading weather and simulating…';

  @override
  String weatherError(String message) {
    return 'Could not get the weather: $message';
  }

  @override
  String weatherSource(String source) {
    return 'Series: $source';
  }

  @override
  String get weatherAnnualTitle => 'Annual yield';

  @override
  String weatherAnnualValue(String value) {
    return '$value kWh per kWp per year';
  }

  @override
  String weatherPerformanceRatio(String value) {
    return 'Performance ratio: $value';
  }

  @override
  String get weatherMonthlyTitle => 'Monthly yield (kWh per kWp)';

  @override
  String get weatherOptimalTitle => 'Optimal orientation';

  @override
  String weatherOptimalValue(String tilt, String azimuth) {
    return 'Tilt $tilt° · azimuth $azimuth°';
  }

  @override
  String weatherLatitudeRule(String value, String diff) {
    return 'With tilt = latitude: $value kWh/kWp ($diff %)';
  }

  @override
  String get weatherTemperaturesTitle => 'Site temperatures';

  @override
  String weatherTemperaturesValue(String min, String max) {
    return 'Recorded minimum $min °C · recorded maximum $max °C';
  }

  @override
  String get weatherSunPathTitle => 'Sun path';

  @override
  String get weatherSunPathAxis => 'Azimuth (°) vs. solar elevation (°)';

  @override
  String get weatherJuneSolstice => 'June solstice';

  @override
  String get weatherEquinox => 'Equinoxes';

  @override
  String get weatherDecemberSolstice => 'December solstice';

  @override
  String get weatherWarningsTitle => 'Warnings';

  @override
  String get weatherAttributionsTitle => 'Data sources';
}
