import 'dart:typed_data';

/// Foto ya comprimida, lista para guardar.
class ProcessedPhoto {
  const new({
    required this.jpegBytes,
    required this.widthPx,
    required this.heightPx,
    this.latitude,
    this.longitude,
    this.takenAt,
  });

  /// JPEG final (≈1600 px de lado mayor, calidad 80 %, sin EXIF).
  final Uint8List jpegBytes;

  /// Ancho final en píxeles.
  final int widthPx;

  /// Alto final en píxeles.
  final int heightPx;

  /// Latitud leída del EXIF, si venía.
  final double? latitude;

  /// Longitud leída del EXIF, si venía.
  final double? longitude;

  /// Fecha de toma leída del EXIF (hora local del teléfono, como UTC
  /// "flotante"), si venía.
  final DateTime? takenAt;
}
