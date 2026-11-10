# geo_kit

Geometría: polígonos, proyección ENU, empaquetado de paneles y parseo de enlaces de mapas.

## Estado
Paquete vacío creado en F0 (solo `GeoKitInfo`). Su contenido se implementa en **F3**.

## Alcance previsto
Polígonos, proyección local ENU en metros, empaquetado de paneles y lectura de enlaces de Google/Apple Maps (plan B.4).

## Archivos clave
- `lib/geo_kit.dart` — API pública (solo exporta lo de `lib/src/`).
- `lib/src/` — implementación, un archivo por responsabilidad.
- `test/` — pruebas unitarias.

## Cómo probar
```bash
cd packages/geo_kit
dart test
```
