import 'package:flutter/foundation.dart' show immutable;
import 'package:geo_kit/geo_kit.dart';
import 'package:persistence/persistence.dart';

/// Lienzo del editor: tamaño en píxeles y relación con los metros locales.
///
/// - Con imagen: el lienzo es la imagen y el marco sale de la calibración.
/// - Sin imagen (croquis): una cuadrícula virtual de [sketchSizePx] px a
///   [sketchMetersPerPixel] m/px (40 × 40 m) con el origen al centro.
@immutable
class RoofSpace {
  /// Crea el lienzo.
  const new({
    required this.mode,
    required this.widthPx,
    required this.heightPx,
    required this.frame,
    this.imagePath,
  });

  /// Lienzo a partir de la fila guardada (o croquis si no hay fila).
  factory fromRecord(RoofImage? r) {
    if (r == null || r.mode == RoofMode.sketch || r.filePath == null) {
      return RoofSpace(
        mode: RoofMode.sketch,
        widthPx: sketchSizePx,
        heightPx: sketchSizePx,
        frame: ImageFrame(
          metersPerPixel: sketchMetersPerPixel,
          northAngleDeg: r?.northAngleDeg ?? 0,
          origin: const Vec2(sketchSizePx / 2, sketchSizePx / 2),
        ),
      );
    }
    final w = (r.widthPx ?? 1).toDouble();
    final h = (r.heightPx ?? 1).toDouble();
    return RoofSpace(
      mode: RoofMode.image,
      widthPx: w,
      heightPx: h,
      imagePath: r.filePath,
      frame: r.metersPerPixel == null
          ? null
          : ImageFrame(
              metersPerPixel: r.metersPerPixel!,
              northAngleDeg: r.northAngleDeg,
              origin: Vec2(w / 2, h / 2),
            ),
    );
  }

  /// Lado del lienzo virtual del croquis (px).
  static const double sketchSizePx = 2000;

  /// Escala del croquis (m/px): 2 cm por píxel.
  static const double sketchMetersPerPixel = 0.02;

  /// Imagen o croquis.
  final RoofMode mode;

  /// Ancho (px).
  final double widthPx;

  /// Alto (px).
  final double heightPx;

  /// Marco píxel ↔ metros (`null` = imagen aún sin calibrar).
  final ImageFrame? frame;

  /// Ruta relativa de la imagen.
  final String? imagePath;

  /// `true` si ya se puede trazar en metros.
  bool get isCalibrated => frame != null;
}
