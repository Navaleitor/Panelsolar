# Panelsolar

App móvil (Android primero, iOS después) para instaladores fotovoltaicos: levantamiento de techo sobre imagen satelital, análisis solar/meteorológico, diseño del arreglo, unifilar, cotización y gestión de clientes con mantenimiento. Todo el cálculo se hace en el dispositivo.

- Plan maestro: [`docs/producto/plan-maestro.md`](docs/producto/plan-maestro.md)
- Fases y estado: [`docs/producto/fases.md`](docs/producto/fases.md)
- Reglas para desarrollar (IA y humanos): [`CLAUDE.md`](CLAUDE.md)

## Estructura
- `app/` — aplicación Flutter (UI). Ver [`app/README.md`](app/README.md).
- `packages/` — `solar_engine`, `geo_kit`, `data_sources`, `regional_packs`, `persistence` (cada uno con su README).
- `docs/` — producto, ADRs, fuentes de datos, fórmulas, pruebas de aceptación.
- `tools/golden_data/` — datos de referencia (pvlib).

## Comandos
```bash
flutter pub get                       # en la raíz: resuelve todo el workspace
(cd app && flutter analyze && flutter test)
(cd packages/persistence && dart test)  # igual para cada paquete
dart format app packages
```
CI: `.github/workflows/ci.yml` (el APK debug queda como artefacto de cada ejecución).
