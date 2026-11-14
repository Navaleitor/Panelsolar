import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/presentation/editor/roof_editor_page.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:persistence/persistence.dart';

/// Panel de orientación: girar la flecha a mano o confirmar con brújula.
class EditorNorthPanel extends ConsumerStatefulWidget {
  /// Crea el panel.
  const new({required this.state, required this.layout, super.key});

  /// Estado del editor.
  final RoofEditorPageState state;

  /// Techo.
  final RoofLayout layout;

  @override
  ConsumerState<EditorNorthPanel> createState() => _EditorNorthPanelState();
}

class _EditorNorthPanelState extends ConsumerState<EditorNorthPanel> {
  double? _dragging;

  Future<void> _save(double angle) async {
    await ref
        .read(roofEditingServiceProvider)
        .saveNorth(
          projectId: widget.state.projectId,
          northAngleDeg: angle,
          source: NorthSource.manual,
        );
    if (mounted) setState(() => _dragging = null);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final r = widget.layout.record;
    final angle = _dragging ?? r?.northAngleDeg ?? 0;
    final source = switch (r?.northSource ?? NorthSource.imageUp) {
      NorthSource.imageUp => l10n.roofNorthSourceDefault,
      NorthSource.manual => l10n.roofNorthSourceManual,
      NorthSource.compass => l10n.roofNorthSourceCompass,
    };
    final hasLine = widget.state.linePts.length == 2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.roofNorthHelp),
        Text(
          l10n.roofNorthValue(RoofFormat.degrees(angle, locale), source),
          key: const Key('north-value'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Slider(
          key: const Key('north-slider'),
          max: 359,
          divisions: 359,
          value: angle.clamp(0, 359).toDouble(),
          label: RoofFormat.degrees(angle, locale),
          onChanged: (v) => setState(() => _dragging = v),
          onChangeEnd: _save,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.icon(
            key: const Key('north-compass'),
            onPressed: hasLine ? widget.state.confirmNorthWithCompass : null,
            icon: const Icon(Icons.explore),
            label: Text(
              hasLine ? l10n.roofNorthCompass : l10n.roofNorthCompassNeedsLine,
            ),
          ),
        ),
      ],
    );
  }
}
