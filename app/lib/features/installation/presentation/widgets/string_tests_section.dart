import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/installation/domain/commissioning_evaluation.dart';
import 'package:panelsolar/features/installation/presentation/installation_labels.dart';
import 'package:panelsolar/features/installation/presentation/installation_providers.dart';
import 'package:panelsolar/features/installation/presentation/widgets/string_test_dialog.dart';
import 'package:persistence/persistence.dart';

/// Lista de strings medidos (Voc/Isc esperados contra medidos) con su
/// veredicto, y botón para agregar.
class StringTestsSection extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  Future<void> _add(BuildContext context, WidgetRef ref, int count) async {
    final data = await showStringTestDialog(
      context,
      defaultLabel: 'S${count + 1}',
    );
    if (data != null) {
      await ref
          .read(commissioningRepositoryProvider)
          .addString(projectId, data);
    }
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, StringTest s) async {
    final data = await showStringTestDialog(context, initial: s);
    if (data != null) {
      await ref.read(commissioningRepositoryProvider).updateString(s.id, data);
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    StringTest s,
  ) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.stringDeleteTitle,
      message: s.label,
    );
    if (ok) {
      await ref.read(commissioningRepositoryProvider).softDeleteString(s.id);
    }
  }

  String _pair(String locale, double? expected, double? measured, String unit) {
    String f(double? v) =>
        v == null ? '—' : Formatters.number(v, locale, decimals: 2);
    final dev = deviationPct(expected, measured);
    final devText = dev == null ? '' : ' (${Formatters.signed(dev, locale)} %)';
    return '${f(measured)} / ${f(expected)} $unit$devText';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final strings = ref.watch(stringTestsProvider(projectId)).value ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l10n.stringsTitle,
          action: TextButton.icon(
            key: const Key('string-add'),
            onPressed: () => _add(context, ref, strings.length),
            icon: const Icon(Icons.add),
            label: Text(l10n.actionAdd),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            l10n.stringsHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Card(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: [
              if (strings.isEmpty) ListTile(title: Text(l10n.stringsEmpty)),
              for (final s in strings)
                ListTile(
                  leading: verdictIcon(context, evaluateString(s)),
                  title: Text(s.label),
                  subtitle: Text(
                    [
                      'Voc ',
                      _pair(locale, s.expectedVocV, s.measuredVocV, 'V'),
                      '\nIsc ',
                      _pair(locale, s.expectedIscA, s.measuredIscA, 'A'),
                    ].join(),
                  ),
                  isThreeLine: true,
                  onTap: () => _edit(context, ref, s),
                  trailing: IconButton(
                    tooltip: l10n.actionDelete,
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _delete(context, ref, s),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
