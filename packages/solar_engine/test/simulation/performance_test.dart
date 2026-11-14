import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import '../helpers/golden.dart';

/// Requisito no funcional (plan A.4): simulación horaria de 5 años en < 3 s.
/// Aquí se mide en la máquina de CI (más rápida que un teléfono gama media);
/// por eso se exige < 1.5 s como margen.
void main() {
  test('5 años horarios (43 800 h) en menos de 1.5 s', () {
    final weather = loadTmy('monterrey', repeatYears: 5);
    expect(weather.length, 43800);
    final sw = Stopwatch()..start();
    final inputs = SimulationInputs.prepare(
      site: goldenSites['monterrey']!,
      weather: weather,
    );
    final r = Simulator.run(inputs, PvSystem.reference(tilt: 26, azimuth: 180));
    sw.stop();
    // Se imprime el tiempo para verlo en el registro del CI.
    // ignore: avoid_print
    print('Simulación de 5 años: ${sw.elapsedMilliseconds} ms');
    expect(r.totalAcEnergy, greaterThan(5 * 1500));
    expect(sw.elapsedMilliseconds, lessThan(1500));
  });
}
