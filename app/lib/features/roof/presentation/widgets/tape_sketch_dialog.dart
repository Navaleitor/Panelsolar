import 'package:flutter/material.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:panelsolar/features/roof/presentation/widgets/number_input_dialog.dart';

/// Modo sin imagen: el usuario escribe los lados medidos con cinta (y el
/// giro de cada esquina, 90° por defecto) y se arma el croquis a escala.
/// Devuelve el polígono en metros o `null`.
Future<List<Vec2>?> showTapeSketchDialog(BuildContext context) =>
    showDialog<List<Vec2>>(
      context: context,
      builder: (_) => const _TapeDialog(),
    );

class _TapeDialog extends StatefulWidget {
  const new();

  @override
  State<_TapeDialog> createState() => _TapeDialogState();
}

class _TapeDialogState extends State<_TapeDialog> {
  final List<TextEditingController> _lengths = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> _turns = List.generate(
    4,
    (_) => TextEditingController(text: '90'),
  );

  @override
  void dispose() {
    for (final c in [..._lengths, ..._turns]) {
      c.dispose();
    }
    super.dispose();
  }

  TapeSketchResult? get _result {
    final sides = <TapeSide>[];
    for (var i = 0; i < _lengths.length; i++) {
      final l = parseDecimal(_lengths[i].text);
      final t = double.tryParse(_turns[i].text.trim().replaceAll(',', '.'));
      if (l == null || l <= 0 || t == null) return null;
      sides.add((lengthM: l, turnDeg: t));
    }
    return TapeSketch.fromSides(sides);
  }

  void _addSide() => setState(() {
    _lengths.add(TextEditingController());
    _turns.add(TextEditingController(text: '90'));
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final r = _result;
    return AlertDialog(
      title: Text(l10n.roofTapeTitle),
      content: SizedBox(
        width: 360,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.roofTapeHelp),
              for (var i = 0; i < _lengths.length; i++)
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        key: Key('tape-length-$i'),
                        controller: _lengths[i],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: l10n.roofTapeSide(i + 1),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        key: Key('tape-turn-$i'),
                        controller: _turns[i],
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: l10n.roofTapeTurn,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ],
                ),
              TextButton.icon(
                key: const Key('tape-add-side'),
                onPressed: _addSide,
                icon: const Icon(Icons.add),
                label: Text(l10n.roofTapeAddSide),
              ),
              if (r != null)
                Text(
                  l10n.roofTapeResult(
                    RoofFormat.area(PolygonMetrics.area(r.polygon), locale),
                    RoofFormat.meters(r.closureErrorM, locale),
                  ),
                  key: const Key('tape-result'),
                ),
              if (r != null && r.closureErrorM > 0.05)
                Text(
                  l10n.roofTapeNotClosed,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('tape-save'),
          onPressed: r == null || !PolygonMetrics.isSimple(r.polygon)
              ? null
              : () => Navigator.of(context).pop(r.polygon),
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
