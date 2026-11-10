import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

void main() {
  test('el paquete expone sus metadatos', () {
    expect(SolarEngineInfo.name, 'solar_engine');
    expect(SolarEngineInfo.plannedPhase, 'F2');
  });
}
