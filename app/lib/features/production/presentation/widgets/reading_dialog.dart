import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panelsolar/core/formatting/decimal_parser.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:persistence/persistence.dart';

/// Datos de una lectura mensual.
typedef ReadingInput = ({
  DateTime month,
  double actualKwh,
  double? expectedKwh,
  double? poaKwhM2,
  String? notes,
});

/// Diálogo de lectura mensual: mes, kWh real (obligatorio), esperado e
/// irradiación POA (opcionales).
/// Propone los kWh esperados de un mes (motor de F2) o `null`.
typedef ExpectedSuggester = Future<double?> Function(DateTime month);

/// Diálogo de lectura. Si el campo "esperado" está vacío, se llena con
/// [suggestExpected] (editable).
Future<ReadingInput?> showReadingDialog(
  BuildContext context, {
  ProductionReading? initial,
  DateTime? suggestedMonth,
  ExpectedSuggester? suggestExpected,
}) => showDialog<ReadingInput>(
  context: context,
  builder: (context) => _ReadingDialog(
    initial: initial,
    month: initial?.month ?? suggestedMonth ?? DateTime.now().toUtc(),
    suggestExpected: suggestExpected,
  ),
);

class _ReadingDialog extends StatefulWidget {
  const new({
    required this.initial,
    required this.month,
    required this.suggestExpected,
  });

  final ProductionReading? initial;
  final DateTime month;
  final ExpectedSuggester? suggestExpected;

  @override
  State<_ReadingDialog> createState() => _ReadingDialogState();
}

class _ReadingDialogState extends State<_ReadingDialog> {
  late int _year = widget.month.year;
  late int _monthNumber = widget.month.month;
  late final _actual = TextEditingController(
    text: decimalText(widget.initial?.actualKwh),
  );
  late final _expected = TextEditingController(
    text: decimalText(widget.initial?.expectedKwh),
  );
  late final _poa = TextEditingController(
    text: decimalText(widget.initial?.poaIrradiationKwhM2),
  );
  late final _notes = TextEditingController(text: widget.initial?.notes ?? '');
  String? _error;

  /// `true` mientras el valor esperado sea el que propuso el motor.
  bool _suggested = false;

  @override
  void initState() {
    super.initState();
    if (_expected.text.isEmpty) unawaited(_suggest());
  }

  Future<void> _suggest() async {
    final suggest = widget.suggestExpected;
    if (suggest == null) return;
    final kwh = await suggest(DateTime.utc(_year, _monthNumber));
    if (!mounted || kwh == null) return;
    if (_expected.text.isNotEmpty && !_suggested) return;
    setState(() {
      _expected.text = kwh.round().toString();
      _suggested = true;
    });
  }

  void _monthChanged() {
    if (_suggested || _expected.text.isEmpty) unawaited(_suggest());
  }

  @override
  void dispose() {
    for (final c in [_actual, _expected, _poa, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    final actual = parseDecimal(_actual.text);
    if (actual == null || actual < 0) {
      setState(() => _error = AppLocalizations.of(context).validationNumber);
      return;
    }
    Navigator.of(context).pop((
      month: DateTime.utc(_year, _monthNumber),
      actualKwh: actual,
      expectedKwh: parseDecimal(_expected.text),
      poaKwhM2: parseDecimal(_poa.text),
      notes: _notes.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final months = DateFormat.MMMM(formatLocale(context));
    final now = DateTime.now().year;
    return AlertDialog(
      title: Text(l10n.readingTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    key: const Key('reading-month'),
                    initialValue: _monthNumber,
                    isExpanded: true,
                    decoration: InputDecoration(labelText: l10n.readingMonth),
                    items: [
                      for (var m = 1; m <= 12; m++)
                        DropdownMenuItem(
                          value: m,
                          child: Text(months.format(DateTime(2000, m))),
                        ),
                    ],
                    onChanged: (m) {
                      setState(() => _monthNumber = m!);
                      _monthChanged();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    key: const Key('reading-year'),
                    initialValue: _year,
                    decoration: InputDecoration(labelText: l10n.readingYear),
                    items: [
                      for (var y = now + 1; y >= 2000; y--)
                        DropdownMenuItem(value: y, child: Text('$y')),
                    ],
                    onChanged: (y) {
                      setState(() => _year = y!);
                      _monthChanged();
                    },
                  ),
                ),
              ],
            ),
            TextField(
              key: const Key('reading-actual'),
              controller: _actual,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.readingActual,
                errorText: _error,
              ),
            ),
            TextField(
              key: const Key('reading-expected'),
              controller: _expected,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => _suggested = false,
              decoration: InputDecoration(
                labelText: l10n.readingExpected,
                helperText: _suggested ? l10n.readingExpectedFromEngine : null,
                helperMaxLines: 2,
              ),
            ),
            TextField(
              key: const Key('reading-poa'),
              controller: _poa,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: l10n.readingPoa),
            ),
            TextField(
              controller: _notes,
              decoration: InputDecoration(labelText: l10n.fieldNotes),
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
          key: const Key('reading-save'),
          onPressed: _save,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
