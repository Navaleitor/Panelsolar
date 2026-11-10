import 'package:regional_packs/regional_packs.dart';
import 'package:test/test.dart';

void main() {
  test('el paquete expone sus metadatos', () {
    expect(RegionalPacksInfo.name, 'regional_packs');
    expect(RegionalPacksInfo.plannedPhase, 'F5');
  });
}
