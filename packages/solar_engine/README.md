# solar_engine

Motor de cálculo solar en Dart puro (posición solar, irradiancia, potencia, sombras, strings, eléctrico, viento, economía).

> Regla: Dart puro, **sin Flutter**. No depende de la app ni de otros paquetes con UI.

## Estado
Paquete vacío creado en F0 (solo `SolarEngineInfo`). Su contenido se implementa en **F2**.

## Alcance previsto
Posición solar, irradiancia, temperatura de celda, potencia, pérdidas, sombras, strings, caída de tensión, viento y economía (plan B.6).

## Archivos clave
- `lib/solar_engine.dart` — API pública (solo exporta lo de `lib/src/`).
- `lib/src/` — implementación, un archivo por responsabilidad.
- `test/` — pruebas unitarias.

## Cómo probar
```bash
cd packages/solar_engine
dart test
```
