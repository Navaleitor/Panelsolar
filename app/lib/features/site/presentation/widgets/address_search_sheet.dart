import 'package:data_sources/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/site/data/site_data_providers.dart';
import 'package:panelsolar/features/site/domain/location_candidate.dart';
import 'package:persistence/persistence.dart';

/// Busca una dirección (solo al tocar "Buscar": sin autocompletar, por la
/// política de Nominatim) y devuelve el resultado elegido.
Future<LocationCandidate?> showAddressSearchSheet(
  BuildContext context,
  String initialQuery,
) {
  return showModalBottomSheet<LocationCandidate>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _AddressSearchSheet(initialQuery: initialQuery),
  );
}

class _AddressSearchSheet extends ConsumerStatefulWidget {
  const new({required this.initialQuery});

  final String initialQuery;

  @override
  ConsumerState<_AddressSearchSheet> createState() =>
      _AddressSearchSheetState();
}

class _AddressSearchSheetState extends ConsumerState<_AddressSearchSheet> {
  late final _controller = TextEditingController(text: widget.initialQuery);
  List<GeocodeResult>? _results;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _search());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final l10n = AppLocalizations.of(context);
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final results = await ref
          .read(geocoderProvider)
          .search(
            query,
            languageCode: Localizations.localeOf(context).languageCode,
          );
      if (mounted) setState(() => _results = results);
    } on GeocodingException catch (e) {
      if (mounted) {
        setState(
          () => _error = switch (e.failure) {
            GeocodingFailure.network => l10n.geocodeErrorNetwork,
            GeocodingFailure.rateLimited => l10n.geocodeErrorBusy,
            GeocodingFailure.badResponse => l10n.geocodeErrorService,
          },
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final results = _results;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.locationOptionAddress,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('address-query'),
            controller: _controller,
            autofocus: widget.initialQuery.isEmpty,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: l10n.addressHint,
              errorText: _error,
              errorMaxLines: 3,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (_) => _search(),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            key: const Key('address-search'),
            onPressed: _busy ? null : _search,
            icon: const Icon(Icons.search),
            label: Text(l10n.actionSearch),
          ),
          if (_busy) const LinearProgressIndicator(),
          if (results != null && results.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l10n.addressNoResults),
            ),
          if (results != null && results.isNotEmpty)
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final r in results)
                    ListTile(
                      leading: const Icon(Icons.place),
                      title: Text(r.displayName),
                      onTap: () => Navigator.of(context).pop(
                        LocationCandidate(
                          latitude: r.latitude,
                          longitude: r.longitude,
                          source: LocationSource.address,
                          sourceText: _controller.text.trim(),
                          label: r.displayName,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Text(
            ref.read(geocoderProvider).attribution,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
