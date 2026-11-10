import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:persistence/persistence.dart';

/// Nombre traducido de un estado de proyecto.
String projectStatusLabel(AppLocalizations l10n, ProjectStatus status) =>
    switch (status) {
      ProjectStatus.prospect => l10n.statusProspect,
      ProjectStatus.design => l10n.statusDesign,
      ProjectStatus.quoted => l10n.statusQuoted,
      ProjectStatus.installed => l10n.statusInstalled,
      ProjectStatus.maintenance => l10n.statusMaintenance,
    };
