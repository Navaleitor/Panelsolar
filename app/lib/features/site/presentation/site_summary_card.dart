import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/site/domain/coordinate_format.dart';
import 'package:panelsolar/features/site/presentation/location_source_label.dart';
import 'package:panelsolar/features/site/presentation/site_providers.dart';

/// Resumen de la ubicación del proyecto en su ficha.
class SiteSummaryCard extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final site = ref.watch(siteProvider(projectId)).value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l10n.locationTitle,
          action: TextButton.icon(
            key: const Key('project-set-location'),
            onPressed: () => context.push(AppRoutes.projectLocation(projectId)),
            icon: Icon(site == null ? Icons.add_location_alt : Icons.edit),
            label: Text(site == null ? l10n.actionAdd : l10n.actionChange),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: site == null
              ? ListTile(
                  leading: const Icon(Icons.location_off),
                  title: Text(l10n.locationNone),
                )
              : ListTile(
                  leading: const Icon(Icons.place),
                  title: SelectableText(
                    CoordinateFormat.decimal(site.latitude, site.longitude),
                  ),
                  subtitle: Text(
                    [
                      locationSourceLabel(l10n, site.source),
                      if (site.altitudeM != null)
                        l10n.altitudeValue(
                          Formatters.number(site.altitudeM!, locale),
                        ),
                      ?site.timeZone,
                    ].join(' · '),
                  ),
                ),
        ),
      ],
    );
  }
}
