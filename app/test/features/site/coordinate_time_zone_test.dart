import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/site/data/device_time_zone_service.dart';

/// Zona horaria deducida de las coordenadas, sin conexión (decisión del
/// dueño 2026-11-14). Usa el índice real empaquetado como asset.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final service = DeviceTimeZoneService();

  const cases = {
    // Sonora: sin horario de verano, UTC−7 todo el año.
    'Hermosillo': (29.0729, -110.9559, 'America/Hermosillo', -7.0),
    // Quintana Roo: UTC−5 todo el año.
    'Cancún': (21.1619, -86.8515, 'America/Cancun', -5.0),
    // Baja California: UTC−8 en invierno (−7 con horario de verano).
    'Tijuana': (32.5149, -117.0382, 'America/Tijuana', -8.0),
    'Monterrey': (25.6866, -100.3161, 'America/Monterrey', -6.0),
    'Madrid': (40.4168, -3.7038, 'Europe/Madrid', 1.0),
  };

  for (final e in cases.entries) {
    test('${e.key} → ${e.value.$3} (UTC${e.value.$4})', () async {
      final (lat, lon, zone, offset) = e.value;
      expect(await service.timeZoneAt(lat, lon), zone);
      expect(service.standardUtcOffsetHours(zone), offset);
    });
  }

  test('zona inválida no tiene desfase', () {
    expect(service.standardUtcOffsetHours('Marte/Olympus'), isNull);
  });

  test('si el índice no carga, no se deduce nada (sin error)', () async {
    final broken = DeviceTimeZoneService(
      loadLocator: () async => throw StateError('sin datos'),
    );
    expect(await broken.timeZoneAt(29, -110), isNull);
  });
}
