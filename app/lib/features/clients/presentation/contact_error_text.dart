import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/clients/domain/contact_validators.dart';

/// Texto traducido de un [ContactFieldError] (o `null` si no hay error).
String? contactErrorText(AppLocalizations l10n, ContactFieldError? error) =>
    switch (error) {
      null => null,
      ContactFieldError.required => l10n.validationRequired,
      ContactFieldError.invalidEmail => l10n.validationEmail,
      ContactFieldError.invalidPhone => l10n.validationPhone,
    };
