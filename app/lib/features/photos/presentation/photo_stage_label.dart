import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:persistence/persistence.dart';

/// Nombre traducido de una etapa de fotos.
String photoStageLabel(AppLocalizations l10n, PhotoStage stage) =>
    switch (stage) {
      PhotoStage.survey => l10n.stageSurvey,
      PhotoStage.installation => l10n.stageInstallation,
      PhotoStage.maintenance => l10n.stageMaintenance,
    };
