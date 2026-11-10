import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

void main() {
  test('el paquete expone sus metadatos', () {
    expect(GeoKitInfo.name, 'geo_kit');
    expect(GeoKitInfo.plannedPhase, 'F3');
  });
}
