import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/domain/shade_job.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';

/// Controles de la pantalla de sombras: fecha, hora, posición del Sol y
/// mapa de calor anual.
class ShadeControls extends StatelessWidget {
  /// Crea los controles.
  const new({
    required this.day,
    required this.hour,
    required this.sunElevation,
    required this.sunAzimuth,
    required this.sunHidden,
    required this.maps,
    required this.planes,
    required this.computing,
    required this.showHeat,
    required this.onDay,
    required this.onHour,
    required this.onToggleHeat,
    required this.onCompute,
    super.key,
  });

  /// Día elegido.
  final DateTime day;

  /// Hora estándar local (decimal).
  final double hour;

  /// Elevación del Sol (grados).
  final double sunElevation;

  /// Azimut del Sol (grados).
  final double sunAzimuth;

  /// Sol abajo o tapado por el horizonte.
  final bool sunHidden;

  /// Mapas calculados.
  final List<PlaneShade>? maps;

  /// Planos (para nombres).
  final List<RoofPlaneModel> planes;

  /// Calculando.
  final bool computing;

  /// Mostrar el mapa de calor.
  final bool showHeat;

  /// Cambio de día.
  final ValueChanged<DateTime> onDay;

  /// Cambio de hora.
  final ValueChanged<double> onHour;

  /// Mostrar/ocultar mapa.
  final ValueChanged<bool> onToggleHeat;

  /// Calcular mapa.
  final VoidCallback onCompute;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final dayOfYear = day.difference(DateTime(day.year)).inDays + 1;
    final hh = hour.floor();
    final mm = ((hour - hh) * 60).round();
    final time =
        '${hh.toString().padLeft(2, '0')}:${mm.toString().padLeft(2, '0')}';
    return Material(
      elevation: 4,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                sunHidden
                    ? l10n.roofSunHidden
                    : l10n.roofSunPosition(
                        RoofFormat.degrees(sunElevation, locale, decimals: 1),
                        RoofFormat.degrees(sunAzimuth, locale),
                      ),
                key: const Key('sun-position'),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 96,
                    child: Text(DateFormat.MMMd(locale).format(day)),
                  ),
                  Expanded(
                    child: Slider(
                      key: const Key('shade-day'),
                      min: 1,
                      max: 365,
                      value: dayOfYear.clamp(1, 365).toDouble(),
                      onChanged: (v) => onDay(
                        DateTime(day.year).add(Duration(days: v.round() - 1)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 96, child: Text(l10n.roofShadeTime(time))),
                  Expanded(
                    child: Slider(
                      key: const Key('shade-hour'),
                      min: 5,
                      max: 20,
                      divisions: 60,
                      value: hour.clamp(5, 20),
                      onChanged: onHour,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (maps != null)
                    FilterChip(
                      key: const Key('shade-heat-toggle'),
                      label: Text(l10n.roofShadeHeatmap),
                      selected: showHeat,
                      onSelected: onToggleHeat,
                    ),
                  const Spacer(),
                  FilledButton.icon(
                    key: const Key('shade-compute'),
                    onPressed: computing ? null : onCompute,
                    icon: computing
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.grid_on),
                    label: Text(l10n.roofShadeCompute),
                  ),
                ],
              ),
              if (maps != null)
                for (final m in maps!)
                  Text(
                    l10n.roofShadePlaneLoss(
                      planes
                              .where((p) => p.id == m.planeId)
                              .firstOrNull
                              ?.name ??
                          '',
                      RoofFormat.percent(m.map.averageLoss, locale),
                      RoofFormat.percent(
                        m.map.monthlyLoss[11].isNaN ? 0 : m.map.monthlyLoss[11],
                        locale,
                      ),
                      RoofFormat.percent(
                        m.map.monthlyLoss[5].isNaN ? 0 : m.map.monthlyLoss[5],
                        locale,
                      ),
                    ),
                    key: Key('shade-loss-${m.planeId}'),
                  ),
              if (maps != null)
                Text(
                  l10n.roofShadeLegend,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
