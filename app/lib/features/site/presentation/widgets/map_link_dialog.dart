import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/site/data/site_data_providers.dart';
import 'package:panelsolar/features/site/domain/location_candidate.dart';
import 'package:persistence/persistence.dart';

/// Lo que devuelve el diálogo de enlace.
sealed class MapLinkDialogResult {
  const new();
}

/// El enlace traía coordenadas.
final class MapLinkDialogCoordinates extends MapLinkDialogResult {
  const new(this.candidate);
  final LocationCandidate candidate;
}

/// El enlace solo traía un lugar en texto: hay que buscarlo.
final class MapLinkDialogPlace extends MapLinkDialogResult {
  const new(this.query);
  final String query;
}

/// Pide al usuario pegar un enlace compartido de Google Maps o Apple Maps.
Future<MapLinkDialogResult?> showMapLinkDialog(BuildContext context) {
  return showDialog<MapLinkDialogResult>(
    context: context,
    builder: (context) => const _MapLinkDialog(),
  );
}

class _MapLinkDialog extends ConsumerStatefulWidget {
  const new();

  @override
  ConsumerState<_MapLinkDialog> createState() => _MapLinkDialogState();
}

class _MapLinkDialogState extends ConsumerState<_MapLinkDialog> {
  final _controller = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text != null) _controller.text = text;
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final text = _controller.text.trim();
    setState(() {
      _busy = true;
      _error = null;
    });
    MapLinkResult result;
    try {
      result = await ref.read(mapLinkResolverProvider).resolve(text);
    } on Object {
      // Sin red o el servidor no respondió al expandir un enlace corto.
      if (mounted) {
        setState(() {
          _busy = false;
          _error = l10n.mapLinkErrorShort;
        });
      }
      return;
    }
    if (!mounted) return;
    switch (result) {
      case MapLinkCoordinates(:final point):
        Navigator.of(context).pop(
          MapLinkDialogCoordinates(
            LocationCandidate(
              latitude: point.latitude,
              longitude: point.longitude,
              source: LocationSource.mapLink,
              sourceText: text,
            ),
          ),
        );
      case MapLinkPlaceQuery(:final query):
        Navigator.of(context).pop(MapLinkDialogPlace(query));
      case MapLinkNeedsExpansion():
        setState(() {
          _busy = false;
          _error = l10n.mapLinkErrorShort;
        });
      case MapLinkUnrecognized():
        setState(() {
          _busy = false;
          _error = l10n.mapLinkErrorUnrecognized;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.locationOptionLink),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.mapLinkInstructions),
          const SizedBox(height: 12),
          TextField(
            key: const Key('map-link'),
            controller: _controller,
            minLines: 1,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'https://maps.app.goo.gl/…',
              errorText: _error,
              errorMaxLines: 3,
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                tooltip: l10n.actionPaste,
                icon: const Icon(Icons.content_paste),
                onPressed: _paste,
              ),
            ),
          ),
          if (_busy) ...[
            const SizedBox(height: 12),
            const LinearProgressIndicator(),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('map-link-ok'),
          onPressed: _busy ? null : _submit,
          child: Text(l10n.actionContinue),
        ),
      ],
    );
  }
}
