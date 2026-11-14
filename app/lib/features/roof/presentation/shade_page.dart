import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/domain/shade_job.dart';
import 'package:panelsolar/features/roof/presentation/editor/roof_canvas.dart';
import 'package:panelsolar/features/roof/presentation/editor/roof_painter.dart';
import 'package:panelsolar/features/roof/presentation/widgets/shade_controls.dart';
import 'package:panelsolar/features/site/data/site_data_providers.dart';
import 'package:panelsolar/features/site/presentation/site_providers.dart';
import 'package:solar_engine/solar_engine.dart';

/// Sombras: deslizador de fecha y hora que dibuja la sombra de cada
/// obstáculo (L = h / tan α, en dirección opuesta al Sol) y mapa de calor
/// anual (B.7.1 pasos 3 y 6).
class ShadePage extends ConsumerStatefulWidget {
  /// Crea la pantalla.
  const new({required this.projectId, super.key});

  /// Proyecto.
  final String projectId;

  @override
  ConsumerState<ShadePage> createState() => _ShadePageState();
}

class _ShadePageState extends ConsumerState<ShadePage> {
  late DateTime _day = DateTime.now();
  double _hour = 10;
  List<PlaneShade>? _maps;
  bool _computing = false;
  bool _showHeat = true;

  ShadeSite? _shadeSite() {
    final site = ref.read(siteProvider(widget.projectId)).value;
    if (site == null) return null;
    final zones = ref.read(timeZoneServiceProvider);
    final offset = site.timeZone == null
        ? null
        : zones.standardUtcOffsetHours(site.timeZone!);
    return (
      latitude: site.latitude,
      longitude: site.longitude,
      elevation: site.altitudeM ?? 0,
      utcOffsetHours: offset ?? (site.longitude / 15).roundToDouble(),
    );
  }

  Future<void> _computeMaps(RoofLayout layout) async {
    final site = _shadeSite();
    if (site == null) return;
    setState(() => _computing = true);
    final maps = await ref.read(shadeRunnerProvider)(
      site: site,
      planes: layout.planes,
      obstacles: layout.obstacles,
      terrain: layout.terrain,
      far: layout.far,
    );
    if (!mounted) return;
    setState(() {
      _maps = maps;
      _computing = false;
      _showHeat = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final value = ref.watch(roofLayoutProvider(widget.projectId));
    final siteValue = ref.watch(siteProvider(widget.projectId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.roofShadeTitle)),
      body: AsyncValueView(
        value: value,
        data: (layout) {
          if (siteValue.value == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  l10n.roofShadeNeedsLocation,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final s = _shadeSite()!;
          final site = Site(
            latitude: s.latitude,
            longitude: s.longitude,
            elevation: s.elevation,
            utcOffsetHours: s.utcOffsetHours,
          );
          final sun = SunSamples.at(
            site,
            _day.year,
            _day.month,
            _day.day,
            _hour,
          );
          final horizon = combinedHorizon(layout.terrain, layout.far);
          final hidden =
              sun.elevation <= 0 ||
              (horizon?.blocks(sun.elevation, sun.azimuth) ?? false);
          final shadows = <List<Vec2>>[];
          if (!hidden) {
            for (final o in layout.obstacles) {
              final plane = layout.planes
                  .where((p) => PolygonMetrics.contains(p.polygon, o.center))
                  .firstOrNull;
              final poly = ShadowCaster.shadowPolygon(
                toShadingObstacles([o]).single,
                sunAzimuthDeg: sun.azimuth,
                sunElevationDeg: sun.elevation,
                surface: plane == null ? RoofSurface.flat : surfaceOf(plane),
              );
              if (poly != null) {
                shadows.add([for (final p in poly) Vec2(p.x, p.y)]);
              }
            }
          }
          final storage = ref.watch(appStorageProvider);
          return Column(
            children: [
              Expanded(
                child: RoofCanvas(
                  space: layout.space,
                  imageFile: layout.space.imagePath == null
                      ? null
                      : storage.file(layout.space.imagePath!),
                  painterBuilder: (zoom) => RoofPainter(
                    space: layout.space,
                    zoom: zoom,
                    locale: formatLocale(context),
                    layers: RoofLayers(
                      planes: layout.planes,
                      obstacles: layout.obstacles,
                      shadows: _showHeat && _maps != null ? const [] : shadows,
                      heatmaps: _showHeat && _maps != null
                          ? [for (final m in _maps!) m.map]
                          : const [],
                    ),
                  ),
                ),
              ),
              ShadeControls(
                day: _day,
                hour: _hour,
                sunElevation: sun.elevation,
                sunAzimuth: sun.azimuth,
                sunHidden: hidden,
                maps: _maps,
                planes: layout.planes,
                computing: _computing,
                showHeat: _showHeat,
                onDay: (d) => setState(() {
                  _day = d;
                  _showHeat = false;
                }),
                onHour: (h) => setState(() {
                  _hour = h;
                  _showHeat = false;
                }),
                onToggleHeat: (v) => setState(() => _showHeat = v),
                onCompute: () => _computeMaps(layout),
              ),
            ],
          );
        },
      ),
    );
  }
}
