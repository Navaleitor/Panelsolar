# Producción (seguimiento)

Captura mensual de kWh reales leídos del inversor, gráfica real contra esperado, Performance Ratio simple y alerta si lo real queda por debajo de un umbral configurable.

## Estado
**F6 completa.** Lo esperado se precarga con el motor de F2 (editable).

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

## Valor esperado desde el motor de F2
`domain/expected_production_source.dart` define `ExpectedProductionSource`. `data/production_providers.dart` usa `EngineExpectedSource` (`data/engine_expected_source.dart`): energía mensual típica de **1 kWp** en la orientación óptima del sitio (análisis de clima de F2, `features/weather`) × **kWp del proyecto** (⚙ ajustes). Al abrir "Agregar lectura" con el campo vacío lo precarga y avisa "Propuesto por el motor…"; el usuario lo puede cambiar. Sin kWp, sin ubicación o sin red (y sin caché de clima) no propone nada. Cuando F4 tenga el arreglo real (inclinación, orientación, pérdidas) se cambia aquí sin tocar pantallas. La POA para el PR aún se escribe a mano.

## Datos
Tablas (persistence v4): `production_readings` (una activa por mes; guardar el mismo mes la reemplaza), `production_settings` (kWp y umbral por proyecto). Repositorio: `ProductionRepository`.

## Cómo probar
```bash
cd app
flutter test test/features/production
```
Revisión manual: `docs/pruebas/fase-6.md`, sección 3.
