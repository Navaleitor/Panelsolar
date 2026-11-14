import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:solar_engine/solar_engine.dart';

/// Datos del sitio para el sombreado.
typedef ShadeSite = ({
  double latitude,
  double longitude,
  double elevation,
  double utcOffsetHours,
});

/// Resultado del mapa de calor de un plano.
typedef PlaneShade = ({String planeId, ShadeHeatmap map});

/// Obstáculos del techo como prismas para el motor.
List<ShadingObstacle> toShadingObstacles(List<ObstacleModel> obstacles) => [
  for (final o in obstacles)
    ShadingObstacle(
      footprint: [for (final p in o.footprint) (x: p.x, y: p.y)],
      heightM: o.heightM,
    ),
];

/// Horizonte combinado (terreno PVGIS + obstáculos lejanos), o `null` si
/// no hay ninguno.
HorizonProfile? combinedHorizon(
  List<HorizonPoint> terrain,
  List<FarObstacle> far,
) {
  if (terrain.isEmpty && far.isEmpty) return null;
  return HorizonBuilder.combine(
    terrain: terrain.isEmpty ? null : HorizonProfile(terrain),
    spans: [for (final f in far) f.points],
  );
}

/// Superficie del motor para un plano: su inclinación y azimut, con z = 0
/// en el centroide (la altura de los obstáculos se mide desde su base).
RoofSurface surfaceOf(RoofPlaneModel p) {
  var sx = 0.0;
  var sy = 0.0;
  for (final v in p.polygon) {
    sx += v.x;
    sy += v.y;
  }
  final n = p.polygon.isEmpty ? 1 : p.polygon.length;
  return RoofSurface(
    tiltDeg: p.tiltDeg,
    azimuthDeg: p.azimuthDeg,
    origin: (x: sx / n, y: sy / n),
  );
}

/// Mapa de calor anual de cada plano (B.7.1 paso 6). Función pura: se
/// ejecuta en un isolate.
List<PlaneShade> computeShadeMaps({
  required ShadeSite site,
  required List<RoofPlaneModel> planes,
  required List<ObstacleModel> obstacles,
  required List<HorizonPoint> terrain,
  required List<FarObstacle> far,
  int dayStep = 7,
  int minuteStep = 30,
}) {
  final s = Site(
    latitude: site.latitude,
    longitude: site.longitude,
    elevation: site.elevation,
    utcOffsetHours: site.utcOffsetHours,
  );
  final horizon = combinedHorizon(terrain, far);
  final shading = toShadingObstacles(obstacles);
  return [
    for (final p in planes)
      if (p.polygon.length >= 3)
        (
          planeId: p.id,
          map: ShadeHeatmapCalculator.compute(
            plane: [for (final v in p.polygon) (x: v.x, y: v.y)],
            obstacles: shading,
            samples: SunSamples.year(
              s,
              year: DateTime.now().year,
              dayStep: dayStep,
              minuteStep: minuteStep,
              tiltDeg: p.tiltDeg,
              azimuthDeg: p.azimuthDeg,
            ),
            horizon: horizon,
            surface: surfaceOf(p),
            maxCells: 2500,
          ),
        ),
  ];
}
