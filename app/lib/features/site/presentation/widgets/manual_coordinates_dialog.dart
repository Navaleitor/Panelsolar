import 'package:flutter/material.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/site/domain/location_candidate.dart';
import 'package:persistence/persistence.dart';

/// Pide coordenadas escritas a mano (`25.6866, -100.3161` o grados,
/// minutos y segundos).
Future<LocationCandidate?> showManualCoordinatesDialog(BuildContext context) {
  return showDialog<LocationCandidate>(
    context: context,
    builder: (context) => const _ManualCoordinatesDialog(),
  );
}

class _ManualCoordinatesDialog extends StatefulWidget {
  const new();

  @override
  State<_ManualCoordinatesDialog> createState() =>
      _ManualCoordinatesDialogState();
}

class _ManualCoordinatesDialogState extends State<_ManualCoordinatesDialog> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text;
    final point = parseCoordinateText(text);
    if (point == null) {
      setState(() => _error = AppLocalizations.of(context).coordinatesInvalid);
      return;
    }
    Navigator.of(context).pop(
      LocationCandidate(
        latitude: point.latitude,
        longitude: point.longitude,
        source: LocationSource.manual,
        sourceText: text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.locationOptionManual),
      content: TextField(
        key: const Key('manual-coordinates'),
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: '25.6866, -100.3161',
          helperText: l10n.coordinatesHelp,
          helperMaxLines: 2,
          errorText: _error,
          border: const OutlineInputBorder(),
        ),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('manual-coordinates-ok'),
          onPressed: _submit,
          child: Text(l10n.actionContinue),
        ),
      ],
    );
  }
}
