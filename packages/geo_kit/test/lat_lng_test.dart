import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

void main() {
  test('tryCreate valida rangos', () {
    expect(LatLng.tryCreate(25.7, -100.3), const LatLng(25.7, -100.3));
    expect(LatLng.tryCreate(90, 180), isNotNull);
    expect(LatLng.tryCreate(-90.0001, 0), isNull);
    expect(LatLng.tryCreate(0, 180.0001), isNull);
    expect(LatLng.tryCreate(double.nan, 0), isNull);
  });

  test('igualdad por valor', () {
    expect(const LatLng(1, 2), const LatLng(1, 2));
    expect(const LatLng(1, 2).hashCode, const LatLng(1, 2).hashCode);
    expect(const LatLng(1, 2), isNot(const LatLng(2, 1)));
  });
}
