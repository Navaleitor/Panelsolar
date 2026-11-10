import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/database_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/empty_module_view.dart';

/// Ajustes. En F0 solo muestra el estado de la base de datos, para que el
/// dueño confirme en su teléfono que SQLite y las migraciones funcionan.
class SettingsPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final health = ref.watch(databaseHealthProvider);
    return EmptyModuleView(
      title: l10n.navSettings,
      description: l10n.settingsDescription,
      icon: Icons.settings,
      phase: 'F1',
      children: [
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const Icon(Icons.storage),
            title: Text(l10n.settingsDatabaseTitle),
            subtitle: health.when(
              data: (version) => Text(l10n.settingsDatabaseOk(version)),
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => Text(l10n.settingsDatabaseError),
            ),
          ),
        ),
      ],
    );
  }
}
