import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/backup/data/backup_settings.dart';
import 'package:persistence/persistence.dart';

/// Texto de qué inició un respaldo.
String backupTriggerLabel(AppLocalizations l10n, BackupTrigger t) =>
    switch (t) {
      BackupTrigger.manual => l10n.backupTriggerManual,
      BackupTrigger.daily => l10n.backupTriggerAuto,
      BackupTrigger.projectFinished => l10n.backupTriggerProject,
      BackupTrigger.restore => l10n.backupTriggerRestore,
    };

/// Texto de la frecuencia del respaldo automático.
String backupFrequencyLabel(AppLocalizations l10n, BackupFrequency f) =>
    switch (f) {
      BackupFrequency.daily => l10n.frequencyDaily,
      BackupFrequency.weekly => l10n.frequencyWeekly,
      BackupFrequency.manual => l10n.frequencyManual,
    };

/// Nombres de las tablas de la vista previa.
String previewTableLabel(AppLocalizations l10n, String table) =>
    switch (table) {
      'clients' => l10n.navClients,
      'projects' => l10n.navProjects,
      'photos' => l10n.photosTitle,
      'documents' => l10n.documentsTitle,
      'maintenance_visits' => l10n.visitsTitle,
      'production_readings' => l10n.readingsTitle,
      _ => table,
    };
