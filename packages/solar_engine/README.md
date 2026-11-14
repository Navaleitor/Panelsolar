# solar_engine

Motor de cálculo solar en Dart puro: posición solar, irradiancia en el plano, temperatura de celda, potencia DC/AC, pérdidas, simulación horaria, orientación óptima, estadísticas climáticas y carta solar.

> Regla: Dart puro, **sin Flutter**. No depende de la app ni de otros paquetes.

## Estado
**F2 completa** (plan B.6 puntos 1–10). **F3:** sombras de obstáculos y mapa de calor (punto 12, B.7.1). **F4:** diseño FV (`src/design/`): strings, separación entre filas, sombra por panel con diodos y vista de cielo, producción del sistema real, caída de tensión, calibre, protecciones y viento (puntos 8, 9, 11, 12, 14–17). Economía en F5.

## Fórmulas (una ficha por fórmula en `docs/formulas/`)
| Archivo | Qué hace | Ficha |
|---|---|---|
| `position/spa.dart` (+ tablas, `delta_t.dart`) | Posición solar NREL SPA | 01 |
| `irradiance/incidence.dart` | Ángulo de incidencia | 02 |
| `irradiance/atmosphere.dart` | Extraterrestre, masa de aire, presión | 03 |
| `irradiance/erbs.dart` | Descomposición GHI → DNI + DHI | 04 |
| `irradiance/sky_diffuse.dart`, `poa.dart` | POA con Perez 1990 / Hay-Davies | 05 |
| `optics/iam.dart` | IAM ASHRAE | 06 |
| `thermal/cell_temperature.dart` | Faiman y NOCT | 07 |
| `power/pvwatts_dc.dart` | Potencia DC PVWatts | 08 |
| `power/losses.dart` | Pérdidas editables y degradación | 09 |
| `power/pvwatts_inverter.dart` | Inversor PVWatts con recorte | 10 |
| `optimization/orientation_optimizer.dart` | Inclinación y azimut óptimos | 11 |
| `simulation/` | Serie de clima, sitio, sistema, simulación horaria y agregación mensual | 12 |
| `statistics/climate_statistics.dart` | Estadísticas mensuales, por estación y temperaturas de diseño | 13 |
| `sunpath/sun_path.dart` | Carta solar (solsticios y equinoccios) | 01 |
| `shading/shadow_caster.dart` | Sombra de obstáculos (L = h / tan α) en techo plano o inclinado | 19 |
| `shading/horizon_builder.dart` | Horizonte del terreno + obstáculos lejanos | 19 |
| `shading/sun_samples.dart` | Sol a una hora local y muestras del año con peso de cielo despejado | 19 |
| `shading/shade_heatmap.dart` | Mapa de calor anual de sombra por plano | 19 |
| `design/strings/` | Límites, propuesta y validación de strings | 22 |
| `design/layout/row_spacing.dart` | Separación entre filas (solsticio, 9–15 h solar) | 23 |
| `design/electrical/voltage_drop.dart`, `conductor_selection.dart` | Caída de tensión y calibre mínimo | 24 |
| `design/electrical/protections.dart` | Fusibles, desconectador, DPS, interruptor y tierra | 25 |
| `design/wind/wind_pressure.dart` | Viento ASCE 7-22 (indicativo) | 26 |
| `design/shading/` | Sombra por panel, diodos bypass, vista de cielo | 27 |
| `design/production/design_production.dart` | Producción del sistema real (año 1 y 25 años, DC/AC) | 28 |

Convenciones: ángulos en grados; azimut desde el norte en sentido horario (180 = sur); irradiancias en W/m²; energías en kWh; temperaturas en °C.

## Uso típico
```dart
final inputs = SimulationInputs.prepare(site: site, weather: series); // una vez
final result = Simulator.run(inputs, PvSystem.reference(tilt: 26, azimuth: 180));
final best = OrientationOptimizer(inputs: inputs, system: system).optimize();
```

## Cómo probar
```bash
cd packages/solar_engine
dart analyze --fatal-infos
dart test                                   # 159 pruebas, incluye golden contra pvlib
dart test --coverage-path=coverage/lcov.info && python3 ../../tools/ci/check_coverage.py coverage/lcov.info 90
dart run tool/golden_report.dart            # tabla de errores contra pvlib
```
Datos golden: `test/golden/` (generados con `tools/golden_data/`). Validación: `docs/pruebas/validacion-motor.md`.

## Notas
- `SimulationInputs.prepare` hace lo costoso (posición solar); después cada `Simulator.run` tarda milisegundos. 5 años ≈ 0.3 s en CI.
- El tiempo de cada dato: se evalúa el Sol en `startEpochSeconds + sampleOffsetMinutes` (centro del intervalo).
