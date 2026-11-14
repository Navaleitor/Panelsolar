# Clima y producción

Pantalla de F2: con la ubicación de un proyecto (o lat/lon a mano), descarga el clima (NASA POWER 5 años + PVGIS), lo revisa y muestra la producción estimada de 1 kWp, la orientación óptima, las temperaturas del sitio y la carta solar.

## Estado
F2: se abre desde la ficha del proyecto (tarjeta "Clima y producción", al final) y, para pruebas, desde Ajustes. La caché usa el id del proyecto.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/projects/:id/weather` | `presentation/weather_page.dart` | Ubicación guardada del proyecto (o campos si no tiene), botón, producción anual y mensual, óptimo, temperaturas, carta solar, advertencias y fuentes |
| `/settings/weather` | `presentation/weather_page.dart` | Igual, con coordenadas a mano (prueba) |

## Capas
- `domain/weather_analysis.dart` — `analyzeClimate()`: función pura (sin Flutter) que simula con `solar_engine`.
- `data/weather_job.dart` — `runWeatherJob()`: descarga/caché (`data_sources`) + análisis; se ejecuta entero en un isolate.
- `data/weather_providers.dart` — providers de Riverpod (carpeta de caché, ejecutor, controlador de estado).
- `presentation/` — página y widgets (`weather_form.dart`, `weather_entry_card.dart` para la ficha del proyecto, `monthly_energy_chart.dart`, `sun_path_chart.dart`, `weather_results_view.dart`).

Dependencias permitidas: `presentation → domain ← data`.

## Cómo probar
```bash
cd app
flutter test test/features/weather
```
Revisión manual en el teléfono: ver `docs/pruebas/fase-2.md`.

## Errores conocidos / notas
- En el hemisferio sur la trayectoria solar cruza el azimut 0°/360° y la línea se corta en el borde de la gráfica.
- La caché vive en el directorio de soporte de la app (`weather/<id del proyecto>/`; `weather/sin_proyecto/` desde Ajustes).
