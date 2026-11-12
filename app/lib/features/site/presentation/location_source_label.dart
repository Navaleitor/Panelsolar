import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:persistence/persistence.dart';

/// Nombre traducido del origen de una ubicación.
String locationSourceLabel(AppLocalizations l10n, LocationSource source) =>
    switch (source) {
      LocationSource.gps => l10n.locationSourceGps,
      LocationSource.address => l10n.locationSourceAddress,
      LocationSource.mapLink => l10n.locationSourceLink,
      LocationSource.manual => l10n.locationSourceManual,
    };
