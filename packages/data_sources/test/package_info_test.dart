import 'package:data_sources/data_sources.dart';
import 'package:test/test.dart';

void main() {
  test('el paquete expone sus metadatos', () {
    expect(DataSourcesInfo.name, 'data_sources');
    expect(DataSourcesInfo.plannedPhase, 'F2');
  });
}
