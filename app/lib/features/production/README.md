# Producción (seguimiento)

Captura mensual de kWh reales leídos del inversor, gráfica real contra esperado, Performance Ratio simple y alerta si lo real queda por debajo de un umbral configurable.

## Estado
**F6 completa.** Lo esperado se escribe a mano; listo para conectarse al motor de F2 (ver abajo).

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| (ficha del proyecto) | `presentation/production_summary_card.dart` | Último mes y "Bajo el umbral" si aplica. |
| `/projects/:id/production` | `presentation/production_page.dart` | Aviso de alerta, gráfica (12 meses), totales, lista de lecturas, ⚙ ajustes. |

## Cálculos (`domain/performance.dart`)
Ficha: [`docs/formulas/performance-ratio.md`](../../../../docs/formulas/performance-ratio.md).
- Índice real/esperado y desviación %.
- PR = kWh / (kWp × irradiación POA kWh/m²). Solo si hay kWp y POA.
- Alerta si la desviación < umbral (por omisión −15 %; en pantalla se escribe "15").

## Conectar el motor de F2
`domain/expected_production_source.dart` define `ExpectedProductionSource`. Hoy `data/production_providers.dart` usa `ManualExpectedSource` (no propone nada). Para F2: crear una clase que calcule kWh y POA del mes con `solar_engine` y cambiar `expectedProductionSourceProvider`. Al guardar una lectura sin "esperado", la pantalla le pide el valor a esa fuente.

## Datos
Tablas (persistence v4): `production_readings` (una activa por mes; guardar el mismo mes la reemplaza), `production_settings` (kWp y umbral por proyecto). Repositorio: `ProductionRepository`.

## Cómo probar
```bash
cd app
flutter test test/features/production
```
Revisión manual: `docs/pruebas/fase-6.md`, sección 3.
