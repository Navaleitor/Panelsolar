import 'package:flutter/material.dart';
import 'package:panelsolar/core/formatting/decimal_parser.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/installation/presentation/widgets/tri_state_check_tile.dart';
import 'package:persistence/persistence.dart';

/// Diálogo para capturar un string: nombre, Voc e Isc esperados y medidos
/// y polaridad. Devuelve `null` si se cancela.
Future<StringTestInput?> showStringTestDialog(
  BuildContext context, {
  StringTest? initial,
  String defaultLabel = 'S1',
}) => showDialog<StringTestInput>(
  context: context,
  builder: (context) =>
      _StringTestDialog(initial: initial, defaultLabel: defaultLabel),
);

class _StringTestDialog extends StatefulWidget {
  const new({required this.initial, required this.defaultLabel});

  final StringTest? initial;
  final String defaultLabel;

  @override
  State<_StringTestDialog> createState() => _StringTestDialogState();
}

class _StringTestDialogState extends State<_StringTestDialog> {
  late final _label = TextEditingController(
    text: widget.initial?.label ?? widget.defaultLabel,
  );
  late final _expVoc = TextEditingController(
    text: decimalText(widget.initial?.expectedVocV),
  );
  late final _measVoc = TextEditingController(
    text: decimalText(widget.initial?.measuredVocV),
  );
  late final _expIsc = TextEditingController(
    text: decimalText(widget.initial?.expectedIscA),
  );
  late final _measIsc = TextEditingController(
    text: decimalText(widget.initial?.measuredIscA),
  );
  late bool? _polarity = widget.initial?.polarityOk;

  @override
  void dispose() {
    for (final c in [_label, _expVoc, _measVoc, _expIsc, _measIsc]) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _number(Key key, TextEditingController c, String label) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: TextField(
      key: key,
      controller: c,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.stringTestTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: const Key('string-label'),
              controller: _label,
              decoration: InputDecoration(labelText: l10n.stringLabel),
            ),
            _number(const Key('string-exp-voc'), _expVoc, l10n.expectedVoc),
            _number(const Key('string-meas-voc'), _measVoc, l10n.measuredVoc),
            _number(const Key('string-exp-isc'), _expIsc, l10n.expectedIsc),
            _number(const Key('string-meas-isc'), _measIsc, l10n.measuredIsc),
            TriStateCheckTile(
              label: l10n.checkPolarity,
              value: _polarity,
              onChanged: (v) => setState(() => _polarity = v),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('string-save'),
          onPressed: () {
            final label = _label.text.trim();
            Navigator.of(context).pop((
              label: label.isEmpty ? widget.defaultLabel : label,
              expectedVocV: parseDecimal(_expVoc.text),
              measuredVocV: parseDecimal(_measVoc.text),
              expectedIscA: parseDecimal(_expIsc.text),
              measuredIscA: parseDecimal(_measIsc.text),
              polarityOk: _polarity,
            ));
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
