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

  @override
  String get actionClear => 'Clear';

  @override
  String get dateNotSet => 'No date';

  @override
  String get savedMessage => 'Saved';

  @override
  String get fieldTechnician => 'Technician';

  @override
  String get installationTitle => 'Installation';

  @override
  String get equipmentTitle => 'Installed equipment';

  @override
  String get equipmentEmpty =>
      'No equipment yet. Add panels, inverter and protections with their serial number.';

  @override
  String equipmentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No equipment',
    );
    return '$_temp0';
  }

  @override
  String get equipmentNewTitle => 'New equipment';

  @override
  String get equipmentEditTitle => 'Edit equipment';

  @override
  String get equipmentDeleteTitle => 'Delete this equipment?';

  @override
  String get equipmentKind => 'Type';

  @override
  String get equipmentBrand => 'Brand';

  @override
  String get equipmentModel => 'Model';

  @override
  String get equipmentSerial => 'Serial number';

  @override
  String equipmentSerialShort(String serial) {
    return 'S/N $serial';
  }

  @override
  String get equipmentInstalledAt => 'Installation date';

  @override
  String get equipmentWarrantyUntil => 'Warranty until';

  @override
  String warrantyUntil(String date) {
    return 'Warranty until $date';
  }

  @override
  String warrantyExpired(String date) {
    return 'Warranty expired on $date';
  }

  @override
  String get equipmentPanel => 'Panel';

  @override
  String get equipmentInverter => 'Inverter';

  @override
  String get equipmentMicroinverter => 'Microinverter';

  @override
  String get equipmentOptimizer => 'Optimizer';

  @override
  String get equipmentBattery => 'Battery';

  @override
  String get equipmentMeter => 'Meter';

  @override
  String get equipmentProtection => 'Protection';

  @override
  String get equipmentStructure => 'Mounting structure';

  @override
  String get equipmentOther => 'Other';

  @override
  String get commissioningTitle => 'Commissioning';

  @override
  String get commissioningHint =>
      'IEC 62446-1 checklist: strings, polarity, insulation, earthing and labelling.';

  @override
  String get commissioningPending => 'Pending';

  @override
  String get commissioningApproved => 'Approved';

  @override
  String get commissioningObservations => 'With observations';

  @override
  String get commissioningChecks => 'Checks';

  @override
  String get commissioningDate => 'Test date';

  @override
  String get commissioningNotes => 'Observations';

  @override
  String get commissioningResult => 'Result';

  @override
  String commissioningSuggested(String status) {
    return 'Based on saved data, the app suggests: $status';
  }

  @override
  String get commissioningSaveForPhotos =>
      'Save the checklist to add evidence photos.';

  @override
  String get evidencePhotos => 'Evidence photos';

  @override
  String get checkOk => 'OK';

  @override
  String get checkFail => 'Fault';

  @override
  String get checkNotChecked => 'Not checked';

  @override
  String get checkPolarity => 'Correct polarity';

  @override
  String get checkPolarityAll => 'Polarity of all strings';

  @override
  String get checkGrounding => 'Earthing continuity';

  @override
  String get checkLabeling => 'Labelling and signs';

  @override
  String get insulationMohm => 'Insulation resistance (MΩ)';

  @override
  String get insulationTestVoltage => 'Test voltage (V)';

  @override
  String get insulationHint =>
      'Minimum 1 MΩ (IEC 62446-1). Test at 500 V for 120–500 V systems; 1000 V above that.';

  @override
  String get groundingOhm => 'Earth resistance (Ω), if measured';

  @override
  String get stringsTitle => 'Strings (Voc and Isc)';

  @override
  String get stringsHint =>
      'Enter the expected value (datasheet or design) and the measured one. Tolerance: Voc ±5 %, Isc ±10 %.';

  @override
  String get stringsEmpty => 'No strings measured';

  @override
  String get stringTestTitle => 'String';

  @override
  String get stringLabel => 'Name (e.g. S1)';

  @override
  String get stringDeleteTitle => 'Delete this string?';

  @override
  String get expectedVoc => 'Expected Voc (V)';

  @override
  String get measuredVoc => 'Measured Voc (V)';

  @override
  String get expectedIsc => 'Expected Isc (A)';

  @override
  String get measuredIsc => 'Measured Isc (A)';

  @override
  String get calendarEmpty =>
      'No visits scheduled. Open a project → Maintenance → \"Create plan\".';

  @override
  String get calendarOverdue => 'Overdue';

  @override
  String get calendarSoon => 'Next 30 days';

  @override
  String get calendarLater => 'Later';

  @override
  String get templateTitle => 'Service template';

  @override
  String get templateHint =>
      'These services are copied when you create a project plan. Tap one to change its frequency; long-press to delete it. The switch says whether it is included.';

  @override
  String get serviceTitle => 'Service';

  @override
  String get serviceKind => 'Service type';

  @override
  String get serviceCustomName => 'Custom name (optional)';

  @override
  String get serviceIntervalMonths => 'Every how many months';

  @override
  String get serviceIntervalInvalid => 'Enter 1 to 120 months';

  @override
  String get serviceNextDue => 'Next visit';

  @override
  String get serviceDeleteTitle => 'Delete this service?';

  @override
  String get serviceCleaning => 'Panel cleaning';

  @override
  String get serviceVisualInspection => 'Visual inspection';

  @override
  String get serviceTightening => 'Connection tightening';

  @override
  String get serviceInverter => 'Inverter check';

  @override
  String get serviceProtections => 'Protections check';

  @override
  String get serviceThermography => 'Thermography';

  @override
  String get serviceOther => 'Other service';

  @override
  String everyMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Every $months months',
      one: 'Every month',
    );
    return '$_temp0';
  }

  @override
  String nextOn(String date) {
    return 'Next: $date';
  }

  @override
  String get planTitle => 'Service plan';

  @override
  String get planEmpty => 'This project has no maintenance plan yet.';

  @override
  String get planEmptyShort => 'No maintenance plan';

  @override
  String get planFromTemplate => 'Create plan from template';

  @override
  String get visitsTitle => 'Visit log';

  @override
  String get visitsEmpty => 'No visits logged yet.';

  @override
  String get visitLog => 'Log visit';

  @override
  String get visitTitle => 'Visit';

  @override
  String get visitDate => 'Visit date';

  @override
  String get visitServicesDone => 'Services done';

  @override
  String get visitNoNotes => 'No notes (tap to write)';

  @override
  String get visitPhotos => 'Visit photos';

  @override
  String get visitDeleteTitle => 'Delete this visit?';

  @override
  String get visitDeleteMessage =>
      'It is removed from the log. Next plan dates do not change.';

  @override
  String servicesDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count services',
      one: '1 service',
      zero: 'No services',
    );
    return '$_temp0';
  }

  @override
  String get remindersTitle => 'Maintenance reminders';

  @override
  String get remindersHint => 'Notice 7 days before and on the day, at 9:00.';

  @override
  String reminderTitle(String service) {
    return 'Maintenance: $service';
  }

  @override
  String reminderBodyToday(String project, String client) {
    return 'Due today at $project ($client).';
  }

  @override
  String reminderBodyBefore(int days, String project, String client) {
    return 'In $days days at $project ($client).';
  }

  @override
  String get productionTitle => 'Production';

  @override
  String get productionEmpty =>
      'Enter the kWh shown by the inverter each month to compare them with the expected value.';

  @override
  String get productionEmptyShort => 'No readings';

  @override
  String get productionActual => 'Actual';

  @override
  String get productionExpected => 'Expected';

  @override
  String get productionBelow => 'Below threshold';

  @override
  String get productionLast12 => 'Last 12 months with readings';

  @override
  String get productionSettings => 'Tracking settings';

  @override
  String get productionKwp => 'Installed power (kWp), for PR';

  @override
  String get productionThreshold => 'Alert threshold (% below)';

  @override
  String get productionThresholdHint =>
      'Example: 15 = warn if actual is 15 % or more below expected.';

  @override
  String productionAlertTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months below expected',
      one: '1 month below expected',
    );
    return '$_temp0';
  }

  @override
  String productionAlertBody(String threshold) {
    return 'More than $threshold % below. Check cleaning, shading, strings and inverter.';
  }

  @override
  String get readingsTitle => 'Monthly readings';

  @override
  String get readingAdd => 'Add reading';

  @override
  String get readingTitle => 'Monthly reading';

  @override
  String get readingMonth => 'Month';

  @override
  String get readingYear => 'Year';

  @override
  String get readingActual => 'Actual kWh (from inverter)';

  @override
  String get readingExpected => 'Expected kWh (optional)';

  @override
  String get readingPoa =>
      'Plane-of-array irradiation, kWh/m² (optional, for PR)';

  @override
  String get readingDeleteTitle => 'Delete this reading?';

  @override
  String readingVsExpected(String expected, String deviation) {
    return 'Expected $expected kWh ($deviation %)';
  }

  @override
  String get backupTitle => 'Backup';

  @override
  String get backupExportTitle => 'Export to .zip file';

  @override
  String get backupExportSubtitle =>
      'Database, photos and documents. Save it anywhere.';

  @override
  String get backupExportPasswordHint =>
      'If you set a password, the file is encrypted (AES-256). It cannot be restored without it: keep it safe. Leave empty for no encryption.';

  @override
  String get backupExported => 'Backup saved';

  @override
  String get backupNotSaved => 'The backup was not saved';

  @override
  String get backupError => 'Could not complete. Try again.';

  @override
  String get backupImportTitle => 'Restore from .zip file';

  @override
  String get backupImportSubtitle =>
      'You will see a preview before data is replaced.';

  @override
  String get backupHistoryTitle => 'Recent backups';

  @override
  String get backupHistoryEmpty => 'No backups yet.';

  @override
  String get backupFailed => 'Failed';

  @override
  String get backupTriggerManual => 'Manual';

  @override
  String get backupTriggerAuto => 'Automatic';

  @override
  String get backupTriggerProject => 'Project finished';

  @override
  String get backupTriggerRestore => 'Restore';

  @override
  String get frequencyDaily => 'Daily';

  @override
  String get frequencyWeekly => 'Weekly';

  @override
  String get frequencyManual => 'Manual only';

  @override
  String get driveNotConfigured =>
      'The app Google account is not configured yet (see docs/guias/respaldo-google.md). The .zip backup works without it.';

  @override
  String get driveConnect => 'Back up to Google Drive';

  @override
  String get driveConnectHint =>
      'Sign in with Google. It is saved in a private app folder in your Drive.';

  @override
  String get driveBackupNow => 'Back up now';

  @override
  String driveBackupDone(int count) {
    return 'Drive backup done ($count new files)';
  }

  @override
  String get driveFrequency => 'Automatic backup (on Wi-Fi)';

  @override
  String get drivePasswordTitle => 'Drive backup password';

  @override
  String get drivePasswordHint =>
      'Encrypts Drive backups (AES-256). You will need the password to restore on another phone. Leave empty to remove encryption.';

  @override
  String get driveEncryptedOn => 'Encryption on';

  @override
  String get driveEncryptedOff => 'Not encrypted';

  @override
  String get driveRestore => 'Restore from Google Drive';

  @override
  String get driveChooseBackup => 'Choose a backup';

  @override
  String get driveNoBackups => 'No backups in this account.';

  @override
  String get driveDisconnect => 'Disconnect Google Drive';

  @override
  String get driveDisconnectMessage =>
      'Automatic backup stops. Backups already uploaded stay in your Drive.';

  @override
  String get passwordOptional => 'Password (optional)';

  @override
  String get passwordConfirm => 'Repeat password';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get passwordTooShort => 'Use at least 6 characters';

  @override
  String get passwordWrong => 'Wrong password';

  @override
  String get restoreTitle => 'Restore backup';

  @override
  String get restoreInvalid =>
      'This file is not a Panelsolar backup or is damaged.';

  @override
  String restoreCreatedWith(String version) {
    return 'Made with version $version';
  }

  @override
  String get restoreEncrypted => 'Encrypted: needs password';

  @override
  String get restoreNotEncrypted => 'Not encrypted';

  @override
  String get restoreWarning =>
      'Restoring replaces ALL data on this phone with the backup.';

  @override
  String get restoreAction => 'Restore';

  @override
  String get restoreConfirmTitle => 'Replace all data?';

  @override
  String get restoreConfirmMessage =>
      'Current clients, projects and photos are replaced by the backup. This cannot be undone.';

  @override
  String restoreDone(int restored, int missing) {
    return 'Restored. Files: $restored recovered, $missing missing.';
  }

  @override
  String get restoreNewerApp =>
      'The backup is from a newer app version. Update the app first.';

  @override
  String get restoreUndoTitle => 'Undo last restore';

  @override
  String get restoreUndoSubtitle =>
      'Go back to the data you had before restoring (automatic copy on this phone).';

  @override
  String get restoreSafetyKept =>
      'Your previous data was saved: Settings → \"Undo last restore\".';

  @override
  String get readingExpectedFromEngine =>
      'Suggested by the solar engine (site weather × kWp). You can change it.';
}
