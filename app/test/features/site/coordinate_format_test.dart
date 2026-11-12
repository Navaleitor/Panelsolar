import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/site/domain/coordinate_format.dart';

void main() {
  test('decimal con 6 decimales', () {
    expect(
      CoordinateFormat.decimal(25.6866142, -100.3161126),
      '25.686614, -100.316113',
    );
  });

  test('grados, minutos y segundos con hemisferio', () {
    expect(
      CoordinateFormat.dms(25.686611, -100.316111),
      '25°41\'11.8" N, 100°18\'58.0" W',
    );
    expect(CoordinateFormat.dms(-33.45, 70), '33°27\'00.0" S, 70°00\'00.0" E');
  });

  test('no produce 60 segundos al redondear', () {
    expect(CoordinateFormat.dms(10.99999999, 0), startsWith("11°00'00.0\" N"));
  });
}
