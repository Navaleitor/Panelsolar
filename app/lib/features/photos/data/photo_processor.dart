import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:panelsolar/features/photos/domain/processed_photo.dart';

/// Lado mayor máximo de las fotos guardadas (plan A.4).
const int maxPhotoSidePx = 1600;

/// Calidad JPEG de las fotos guardadas (plan A.4).
const int photoJpegQuality = 80;

/// Comprime una foto: lee GPS y fecha del EXIF, endereza según la
/// orientación EXIF, reduce el lado mayor a [maxSide] y codifica en JPEG
/// [quality] %. El JPEG resultante **no** lleva EXIF (el GPS queda en la
/// base de datos). Es una función pura: se ejecuta en otro *isolate* con
/// `compute` para no congelar la pantalla.
///
/// Lanza [FormatException] si los bytes no son una imagen.
ProcessedPhoto processPhoto(
  Uint8List bytes, {
  int maxSide = maxPhotoSidePx,
  int quality = photoJpegQuality,
}) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw const FormatException('El archivo no es una imagen válida');
  }
  final exif = decoded.exif;
  final gps = readExifGps(exif);
  final takenAt = readExifDate(exif);

  var image = img.bakeOrientation(decoded);
  final longest = image.width > image.height ? image.width : image.height;
  if (longest > maxSide) {
    image = image.width >= image.height
        ? img.copyResize(image, width: maxSide)
        : img.copyResize(image, height: maxSide);
  }
  image.exif = img.ExifData();
  final jpeg = img.encodeJpg(image, quality: quality);
  return ProcessedPhoto(
    jpegBytes: jpeg,
    widthPx: image.width,
    heightPx: image.height,
    latitude: gps?.$1,
    longitude: gps?.$2,
    takenAt: takenAt,
  );
}

/// Latitud y longitud del bloque GPS del EXIF (grados, minutos, segundos
/// + hemisferio), o `null` si no hay.
(double, double)? readExifGps(img.ExifData exif) {
  final gps = exif.gpsIfd;
  final lat = _dmsToDegrees(gps[0x0002]);
  final lon = _dmsToDegrees(gps[0x0004]);
  if (lat == null || lon == null) return null;
  final latRef = gps[0x0001]?.toString().trim().toUpperCase() ?? 'N';
  final lonRef = gps[0x0003]?.toString().trim().toUpperCase() ?? 'E';
  final latitude = latRef.startsWith('S') ? -lat : lat;
  final longitude = lonRef.startsWith('W') ? -lon : lon;
  if (latitude.abs() > 90 || longitude.abs() > 180) return null;
  // 0,0 suele significar "sin dato" en cámaras que llenan el bloque vacío.
  if (latitude == 0 && longitude == 0) return null;
  return (latitude, longitude);
}

/// Fecha `DateTimeOriginal` (o `DateTime`) del EXIF, o `null`.
DateTime? readExifDate(img.ExifData exif) {
  final raw =
      exif.exifIfd[0x9003]?.toString() ?? exif.imageIfd[0x0132]?.toString();
  if (raw == null) return null;
  final match = RegExp(r'(\d{4}):(\d{2}):(\d{2}) (\d{2}):(\d{2}):(\d{2})')
      .firstMatch(raw);
  if (match == null) return null;
  final parts = [for (var i = 1; i <= 6; i++) int.parse(match.group(i)!)];
  if (parts[0] < 1900) return null;
  return DateTime.utc(
    parts[0],
    parts[1],
    parts[2],
    parts[3],
    parts[4],
    parts[5],
  );
}

double? _dmsToDegrees(img.IfdValue? value) {
  if (value == null || value.length == 0) return null;
  final d = value.toDouble();
  final m = value.length > 1 ? value.toDouble(1) : 0.0;
  final s = value.length > 2 ? value.toDouble(2) : 0.0;
  final result = d + m / 60 + s / 3600;
  return result.isFinite ? result : null;
}
