import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';

/// Cuando cambia la escala o el norte, lo dibujado sigue pegado a la
/// imagen: cada punto se lleva a píxeles con el marco anterior y vuelve a
/// metros con el nuevo.
abstract final class Reframe {
  /// Punto.
  static Vec2 point(Vec2 p, ImageFrame from, ImageFrame to) =>
      to.toLocal(from.toPixel(p));

  /// Factor de escala entre marcos (m nuevos por m anteriores).
  static double scale(ImageFrame from, ImageFrame to) =>
      to.metersPerPixel / from.metersPerPixel;

  /// Giro (grados, antihorario) que sufren las direcciones locales.
  static double rotation(ImageFrame from, ImageFrame to) =>
      to.northAngleDeg - from.northAngleDeg;

  /// Plano: vértices y pasillos. El azimut se vuelve a calcular desde la
  /// arista elegida o se gira con el norte.
  static RoofPlaneModel plane(
    RoofPlaneModel p,
    ImageFrame from,
    ImageFrame to,
  ) {
    final poly = [for (final v in p.polygon) point(v, from, to)];
    final edge = p.azimuthEdgeIndex;
    final az = edge != null && poly.length >= 3
        ? PlaneOrientation.azimuthFromEdge(poly, edge)
        : _mod360(p.azimuthDeg + rotation(from, to));
    return RoofPlaneModel(
      id: p.id,
      name: p.name,
      polygon: poly,
      tiltDeg: p.tiltDeg,
      tiltSource: p.tiltSource,
      azimuthDeg: az,
      azimuthEdgeIndex: edge,
      edgeSetbackM: p.edgeSetbackM,
      walkways: [
        for (final w in p.walkways)
          Walkway(point(w.start, from, to), point(w.end, from, to), w.widthM),
      ],
    );
  }

  /// Obstáculo: su centro y puntos se mueven con la imagen. Sus medidas
  /// (m) se respetan: son reales, medidas con cinta o del catálogo.
  static ObstacleModel obstacle(
    ObstacleModel o,
    ImageFrame from,
    ImageFrame to,
  ) => ObstacleModel(
    id: o.id,
    type: o.type,
    shape: o.shape,
    center: point(o.center, from, to),
    widthM: o.widthM,
    depthM: o.depthM,
    rotationDeg: o.rotationDeg + rotation(from, to),
    points: [for (final v in o.points) point(v, from, to)],
    heightM: o.heightM,
    heightSource: o.heightSource,
    tankLiters: o.tankLiters,
  );

  static double _mod360(double v) {
    final r = v % 360;
    return r < 0 ? r + 360 : r;
  }
}
