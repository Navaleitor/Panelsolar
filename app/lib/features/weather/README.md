# Clima y producción

Pantalla mínima de F2: dada una latitud/longitud de prueba, descarga el clima (NASA POWER 5 años + PVGIS), lo revisa y muestra la producción estimada de 1 kWp, la orientación óptima, las temperaturas del sitio y la carta solar.

## Estado
F2: pantalla de prueba accesible desde Ajustes. En F3/F4 el clima se integrará a cada proyecto (con el id real del proyecto para la caché).

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/settings/weather` | `presentation/weather_page.dart` | Campos de latitud/longitud, botón, producción anual y mensual, óptimo, temperaturas, carta solar, advertencias y fuentes |

## Capas
- `domain/weather_analysis.dart` — `analyzeClimate()`: función pura (sin Flutter) que simula con `solar_engine`.
- `data/weather_job.dart` — `runWeatherJob()`: descarga/caché (`data_sources`) + análisis; se ejecuta entero en un isolate.
- `data/weather_providers.dart` — providers de Riverpod (carpeta de caché, ejecutor, controlador de estado).
- `presentation/` — página y widgets (`monthly_energy_chart.dart`, `sun_path_chart.dart`, `weather_results_view.dart`).

Dependencias permitidas: `presentation → domain ← data`.

## Cómo probar
```bash
cd app
flutter test test/features/weather
```
Revisión manual en el teléfono: ver `docs/pruebas/fase-2.md`.

## Errores conocidos / notas
- En el hemisferio sur la trayectoria solar cruza el azimut 0°/360° y la línea se corta en el borde de la gráfica.
- La caché vive en el directorio de soporte de la app (`weather/f2_demo/`).
