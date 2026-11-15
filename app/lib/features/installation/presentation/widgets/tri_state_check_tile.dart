import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Revisión de tres estados: correcto, con falla o sin revisar (`null`).
class TriStateCheckTile extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          SegmentedButton<int>(
            segments: [
              ButtonSegment(
                value: 1,
                icon: const Icon(Icons.check),
                label: Text(l10n.checkOk),
              ),
              ButtonSegment(
                value: 0,
                icon: const Icon(Icons.close),
                label: Text(l10n.checkFail),
              ),
              ButtonSegment(value: -1, label: Text(l10n.checkNotChecked)),
            ],
            selected: {
              switch (value) {
                null => -1,
                true => 1,
                false => 0,
              },
            },
            onSelectionChanged: (s) => onChanged(switch (s.first) {
              1 => true,
              0 => false,
              _ => null,
            }),
          ),
        ],
      ),
    );
  }
}
