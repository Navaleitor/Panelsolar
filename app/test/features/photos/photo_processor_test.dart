import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
// El EXIF real guarda grados, minutos y segundos como 3 fracciones; la
// clase Rational no se exporta en la API pública de `image`.
import 'package:image/src/util/rational.dart';
import 'package:panelsolar/features/photos/data/photo_processor.dart';

/// JPEG de prueba de [w]×[h] con GPS y fecha opcionales en el EXIF.
Uint8List makeJpeg(int w, int h, {(double, double)? gps, String? date}) {
  final image = img.Image(width: w, height: h)
    ..clear(img.ColorRgb8(200, 120, 40));
  if (gps != null) {
    final (lat, lon) = gps;
    image.exif.gpsIfd
      ..[0x0001] = img.IfdValueAscii(lat < 0 ? 'S' : 'N')
      ..[0x0002] = _dms(lat.abs())
      ..[0x0003] = img.IfdValueAscii(lon < 0 ? 'W' : 'E')
      ..[0x0004] = _dms(lon.abs());
  }
  if (date != null) image.exif.exifIfd[0x9003] = img.IfdValueAscii(date);
  return img.encodeJpg(image);
}

img.IfdValueRational _dms(double value) {
  final d = value.floor();
  final mFull = (value - d) * 60;
  final m = mFull.floor();
  final s = ((mFull - m) * 60 * 1000).round();
  return img.IfdValueRational.list([
    Rational(d, 1),
    Rational(m, 1),
    Rational(s, 1000),
  ]);
}

void main() {
  test('reduce el lado mayor a 1600 px y conserva la proporción', () {
    final out = processPhoto(makeJpeg(4000, 3000));
    expect(out.widthPx, 1600);
    expect(out.heightPx, 1200);
    final decoded = img.decodeJpg(out.jpegBytes)!;
    expect(decoded.width, 1600);
  });

  test('fotos verticales y pequeñas', () {
    final tall = processPhoto(makeJpeg(1000, 2000));
    expect((tall.widthPx, tall.heightPx), (800, 1600));
    final small = processPhoto(makeJpeg(640, 480));
    expect((small.widthPx, small.heightPx), (640, 480));
  });

  test('lee el GPS (hemisferios S/W) y la fecha del EXIF', () {
    final out = processPhoto(
      makeJpeg(
        200,
        100,
        gps: (-25.686611, -100.316111),
        date: '2026:11:10 09:30:00',
      ),
    );
    expect(out.latitude, closeTo(-25.686611, 1e-5));
    expect(out.longitude, closeTo(-100.316111, 1e-5));
    expect(out.takenAt, DateTime.utc(2026, 11, 10, 9, 30));
  });

  test('sin EXIF no inventa GPS ni fecha y no deja EXIF en la salida', () {
    final out = processPhoto(makeJpeg(200, 100));
    expect(out.latitude, isNull);
    expect(out.takenAt, isNull);
    final decoded = img.decodeJpg(out.jpegBytes)!;
    expect(decoded.exif.gpsIfd.isEmpty, isTrue);
  });

  test('bytes que no son imagen → FormatException', () {
    expect(
      () => processPhoto(Uint8List.fromList([1, 2, 3, 4])),
      throwsFormatException,
    );
  });
}
