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
  String get actionAdd => 'Add';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionChange => 'Change';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionCopy => 'Copy';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionOpen => 'Open';

  @override
  String get actionPaste => 'Paste';

  @override
  String get actionRename => 'Rename';

  @override
  String get actionSave => 'Save';

  @override
  String get actionSearch => 'Search';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get copied => 'Copied';

  @override
  String get filterAll => 'All';

  @override
  String get validationRequired => 'Required';

  @override
  String get validationEmail => 'Invalid email';

  @override
  String get validationPhone => 'Invalid phone (at least 7 digits)';

  @override
  String get validationNumber => 'Invalid number';

  @override
  String get validationPeriod => 'The period end cannot be before the start';

  @override
  String get validationTimeZone => 'Unknown time zone (e.g. America/Monterrey)';

  @override
  String get fieldName => 'Name';

  @override
  String get fieldPhone => 'Phone';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldAddress => 'Address';

  @override
  String get fieldNotes => 'Notes';

  @override
  String get fieldClient => 'Client';

  @override
  String get fieldProjectName => 'Project name';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldDate => 'Date';

  @override
  String get fieldAltitude => 'Altitude (optional)';

  @override
  String get fieldTimeZone => 'Time zone';

  @override
  String get fieldTariff => 'Tariff';

  @override
  String get fieldPeriodStart => 'Period start';

  @override
  String get fieldPeriodEnd => 'Period end';

  @override
  String get fieldEnergyKwh => 'Consumption';

  @override
  String get fieldAmount => 'Amount (optional)';

  @override
  String get clientsSearchHint => 'Search by name, phone, email or address';

  @override
  String get clientsEmpty => 'No clients yet. Tap “New client”.';

  @override
  String get clientsNoMatches => 'No client matches the search.';

  @override
  String get clientNew => 'New client';

  @override
  String get clientEdit => 'Edit client';

  @override
  String get clientNotFound => 'This client no longer exists.';

  @override
  String get clientNoContact => 'No contact details';

  @override
  String get clientProjectsTitle => 'Projects';

  @override
  String get clientNoProjects => 'No projects';

  @override
  String get clientDeleteTitle => 'Delete client?';

  @override
  String get clientDeleteMessage =>
      'Their projects and bills will be hidden too. It can be recovered from a backup.';

  @override
  String get projectsSearchHint => 'Search by project or client';

  @override
  String get projectsEmpty => 'No projects.';

  @override
  String get projectNew => 'New project';

  @override
  String get projectEdit => 'Edit project';

  @override
  String get projectNotFound => 'This project no longer exists.';

  @override
  String get projectNeedsClient => 'Add a client first.';

  @override
  String get projectDeleteTitle => 'Delete project?';

  @override
  String get projectDeleteMessage =>
      'It will be hidden with its photos and documents. It can be recovered from a backup.';

  @override
  String get statusProspect => 'Prospect';

  @override
  String get statusDesign => 'Design';

  @override
  String get statusQuoted => 'Quoted';

  @override
  String get statusInstalled => 'Installed';

  @override
  String get statusMaintenance => 'Maintenance';

  @override
  String get locationTitle => 'Location';

  @override
  String get locationNone => 'No location';

  @override
  String get locationIntro =>
      'Choose how to get the site coordinates. Only latitude and longitude are stored; the app shows no maps.';

  @override
  String get locationOptionGps => 'Use the phone GPS';

  @override
  String get locationOptionGpsHint => 'While at the site';

  @override
  String get locationOptionAddress => 'Search an address';

  @override
  String get locationOptionAddressHint => 'Street, number, area and city';

  @override
  String get locationOptionLink => 'Paste a map link';

  @override
  String get locationOptionLinkHint => 'Shared from Google Maps or Apple Maps';

  @override
  String get locationOptionManual => 'Type coordinates';

  @override
  String get locationOptionManualHint =>
      'Decimal or degrees, minutes and seconds';

  @override
  String get locationSourceGps => 'GPS';

  @override
  String get locationSourceAddress => 'Address';

  @override
  String get locationSourceLink => 'Map link';

  @override
  String get locationSourceManual => 'Typed by hand';

  @override
  String get locationConfirmTitle => 'Is this location correct?';

  @override
  String get locationConfirmHint =>
      'Check the coordinates. You can copy them and verify them in your map app before saving.';

  @override
  String get locationConfirmAction => 'Yes, save location';

  @override
  String get locationChooseAnother => 'No, choose another';

  @override
  String get locationSaved => 'Location saved';

  @override
  String get timeZoneHelp =>
      'Defaults to the phone\'s. IANA format, e.g. America/Monterrey or America/Hermosillo.';

  @override
  String get coordinatesHelp =>
      'E.g.: 25.6866, -100.3161  or  25°41\'11.8\"N 100°18\'58.0\"W';

  @override
  String get coordinatesInvalid => 'Coordinates not recognized.';

  @override
  String get addressHint => 'E.g.: 100 Main St, Springfield';

  @override
  String get addressNoResults => 'No results. Try less detail or add the city.';

  @override
  String get geocodeErrorNetwork =>
      'No connection. Check the internet and try again.';

  @override
  String get geocodeErrorBusy => 'The search service is busy. Wait a moment.';

  @override
  String get geocodeErrorService => 'The search service returned an error.';

  @override
  String get mapLinkInstructions =>
      'In Google Maps or Apple Maps tap “Share” → “Copy”, then paste it here.';

  @override
  String get mapLinkErrorShort =>
      'Couldn\'t open the short link. Check the connection or use the full link.';

  @override
  String get mapLinkErrorUnrecognized => 'No coordinates found in that text.';

  @override
  String get gpsErrorDisabled =>
      'Phone location is off. Turn it on and try again.';

  @override
  String get gpsErrorDenied => 'Location permission is needed.';

  @override
  String get gpsErrorDeniedForever =>
      'Location permission is blocked. Enable it in phone Settings → Apps → Panelsolar.';

  @override
  String get gpsErrorTimeout =>
      'GPS did not respond in time. Go outdoors and try again.';

  @override
  String get photosTitle => 'Photos';

  @override
  String get photosEmpty => 'No photos in this stage';

  @override
  String get photoAdd => 'Add photo';

  @override
  String get photoFromCamera => 'Take with camera';

  @override
  String get photoFromGallery => 'Choose from gallery';

  @override
  String get photoCaption => 'Caption';

  @override
  String get photoNoGps => 'No GPS location';

  @override
  String get photoDeleteTitle => 'Delete photo?';

  @override
  String get photoDeleteMessage => 'It will be hidden from the project.';

  @override
  String get stageSurvey => 'Survey';

  @override
  String get stageInstallation => 'Installation';

  @override
  String get stageMaintenance => 'Maintenance';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get documentsEmpty => 'No documents (PDF or image)';

  @override
  String get documentAdded => 'Document added';

  @override
  String get documentUnsupported =>
      'Only PDF or images (JPG, PNG, WEBP) are accepted.';

  @override
  String get documentCannotOpen => 'No app can open this file.';

  @override
  String get documentDeleteTitle => 'Delete document?';

  @override
  String get billsTitle => 'Electricity bills';

  @override
  String get billsEmpty => 'No bills. Add at least the last year\'s.';

  @override
  String get billNew => 'New bill';

  @override
  String get billEdit => 'Edit bill';

  @override
  String get billDeleteTitle => 'Delete bill?';

  @override
  String get billDeleteMessage => 'It will no longer count toward consumption.';

  @override
  String get tariffNone => 'Not specified';

  @override
  String get periodMonthly => 'Monthly';

  @override
  String get periodBimonthly => 'Bimonthly';

  @override
  String get consumptionAnnual => 'Estimated annual consumption';

  @override
  String get consumptionMonthly => 'Monthly average';

  @override
  String get consumptionDaily => 'daily';

  @override
  String get consumptionAnnualCost => 'Estimated annual cost';

  @override
  String altitudeValue(String meters) {
    return '$meters m a.s.l.';
  }

  @override
  String gpsAccuracy(String meters) {
    return 'Accuracy: ±$meters m';
  }

  @override
  String projectAdvanceTo(String status) {
    return 'Move to “$status”';
  }

  @override
  String photosImported(int saved, int duplicates, int invalid) {
    String _temp0 = intl.Intl.pluralLogic(
      saved,
      locale: localeName,
      other: '$saved photos saved',
      one: '1 photo saved',
      zero: 'No new photos',
    );
    String _temp1 = intl.Intl.pluralLogic(
      duplicates,
      locale: localeName,
      other: ' · $duplicates duplicates',
      one: ' · 1 duplicate',
      zero: '',
    );
    String _temp2 = intl.Intl.pluralLogic(
      invalid,
      locale: localeName,
      other: ' · $invalid invalid',
      one: ' · 1 invalid',
      zero: '',
    );
    return '$_temp0$_temp1$_temp2';
  }

  @override
  String consumptionPartialYear(int days) {
    return 'Based on $days days of bills: the annual figure is an estimate. Add the full year.';
  }

  @override
  String consumptionDacWarning(String tariff, String limit) {
    return 'The monthly average exceeds the $tariff tariff limit ($limit kWh/month): risk of moving to DAC.';
  }

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

  @override
  String get weatherProjectLocation => 'Saved project location:';

  @override
  String get weatherNoProjectLocation =>
      'This project has no location yet. Type the coordinates here, or add it on the project page.';

  @override
  String get weatherProjectEntryTitle => 'Weather and yield';

  @override
  String get weatherProjectEntrySubtitle =>
      'How much energy 1 kWp would give here and the best tilt';

  @override
  String weatherTimeZone(String zone, String offset) {
    return 'Time zone: $zone ($offset)';
  }

  @override
  String weatherDesignMin(String value, String source) {
    return 'Design minimum: $value °C ($source)';
  }

  @override
  String weatherDesignMax(String value, String source) {
    return 'Design maximum: $value °C ($source)';
  }

  @override
  String get weatherDesignHint =>
      'String design uses the most extreme value of the two sources.';

  @override
  String weatherTemperaturesBySource(String source, String min, String max) {
    return '$source: minimum $min °C · maximum $max °C';
  }
}
