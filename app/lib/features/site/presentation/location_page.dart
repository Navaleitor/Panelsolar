import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/site/data/site_data_providers.dart';
import 'package:panelsolar/features/site/domain/location_candidate.dart';
import 'package:panelsolar/features/site/domain/location_service.dart';
import 'package:panelsolar/features/site/presentation/widgets/address_search_sheet.dart';
import 'package:panelsolar/features/site/presentation/widgets/location_confirm_view.dart';
import 'package:panelsolar/features/site/presentation/widgets/manual_coordinates_dialog.dart';
import 'package:panelsolar/features/site/presentation/widgets/map_link_dialog.dart';

/// Elegir la ubicación del proyecto: GPS, dirección, enlace de mapa o
/// coordenadas a mano. Siempre termina en una pantalla de confirmación.
/// No hay mapa ni imagen de proveedores (ADR-005).
class LocationPage extends ConsumerStatefulWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  LocationCandidate? _candidate;
  bool _busy = false;
  String? _error;

  Future<void> _fromGps() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final candidate = await ref
          .read(locationServiceProvider)
          .currentPosition();
      if (mounted) setState(() => _candidate = candidate);
    } on LocationException catch (e) {
      if (mounted) {
        setState(
          () => _error = switch (e.failure) {
            LocationFailure.serviceDisabled => l10n.gpsErrorDisabled,
            LocationFailure.permissionDenied => l10n.gpsErrorDenied,
            LocationFailure.permissionDeniedForever =>
              l10n.gpsErrorDeniedForever,
            LocationFailure.timeout => l10n.gpsErrorTimeout,
          },
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _fromAddress([String initialQuery = '']) async {
    final candidate = await showAddressSearchSheet(context, initialQuery);
    if (candidate != null && mounted) setState(() => _candidate = candidate);
  }

  Future<void> _fromLink() async {
    final result = await showMapLinkDialog(context);
    if (!mounted || result == null) return;
    switch (result) {
      case MapLinkDialogCoordinates(:final candidate):
        setState(() => _candidate = candidate);
      case MapLinkDialogPlace(:final query):
        await _fromAddress(query);
    }
  }

  Future<void> _fromManual() async {
    final candidate = await showManualCoordinatesDialog(context);
    if (candidate != null && mounted) setState(() => _candidate = candidate);
  }

  Future<void> _save(LocationCandidate c, double? altitude, String? tz) async {
    await ref
        .read(siteRepositoryProvider)
        .save(
          projectId: widget.projectId,
          latitude: c.latitude,
          longitude: c.longitude,
          source: c.source,
          altitudeM: altitude,
          timeZone: tz,
          sourceText: c.sourceText,
          accuracyM: c.accuracyM,
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).locationSaved)),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final candidate = _candidate;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.locationTitle)),
      body: candidate != null
          ? LocationConfirmView(
              candidate: candidate,
              onCancel: () => setState(() => _candidate = null),
              onConfirm: (altitude, tz) => _save(candidate, altitude, tz),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(l10n.locationIntro),
                const SizedBox(height: 16),
                if (_busy) const LinearProgressIndicator(),
                if (_error != null)
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: ListTile(
                      leading: const Icon(Icons.error_outline),
                      title: Text(_error!),
                    ),
                  ),
                _option(
                  key: 'location-gps',
                  icon: Icons.my_location,
                  title: l10n.locationOptionGps,
                  subtitle: l10n.locationOptionGpsHint,
                  onTap: _busy ? null : _fromGps,
                ),
                _option(
                  key: 'location-address',
                  icon: Icons.search,
                  title: l10n.locationOptionAddress,
                  subtitle: l10n.locationOptionAddressHint,
                  onTap: _busy ? null : _fromAddress,
                ),
                _option(
                  key: 'location-link',
                  icon: Icons.link,
                  title: l10n.locationOptionLink,
                  subtitle: l10n.locationOptionLinkHint,
                  onTap: _busy ? null : _fromLink,
                ),
                _option(
                  key: 'location-manual',
                  icon: Icons.edit_location_alt,
                  title: l10n.locationOptionManual,
                  subtitle: l10n.locationOptionManualHint,
                  onTap: _busy ? null : _fromManual,
                ),
              ],
            ),
    );
  }

  Widget _option({
    required String key,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    return Card(
      child: ListTile(
        key: Key(key),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
