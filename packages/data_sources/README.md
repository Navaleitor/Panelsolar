# data_sources

Clientes HTTP de fuentes de datos externas, con caché local. En F2: clima (NASA POWER y PVGIS). La geocodificación (Nominatim) es de F1.

## Estado
**F2:** clima completo. Pendiente de otras fases: geocodificación (F1).

## Archivos clave
| Archivo | Qué hace |
|---|---|
| `weather/nasa_power_client.dart` | Serie horaria UTC de los últimos 5 años completos: GHI, DNI, DHI, T2M, WS10M, albedo (−999 → NaN) |
| `weather/pvgis_client.dart` | PVGIS 5.3: TMY (respeta `irradiance_time_offset`) y horizonte del terreno |
| `weather/weather_dataset.dart` | Serie + metadatos (versión, fecha, base de datos) con JSON para la caché |
| `weather/weather_repository.dart` | Orquesta: caché → descarga → control de calidad → comparación NASA vs PVGIS → `SiteClimate` |
| `cache/project_cache.dart` | Caché JSON + gzip por proyecto (`<raíz>/<proyecto>/<clave>.json.gz`) |
| `quality/weather_quality_control.dart`, `component_closure.dart`, `quality_report.dart` | Huecos, negativos, GHI > extraterrestre, cierre GHI = DNI·cos θz + DHI, advertencias (ficha 14) |
| `attribution/attributions.dart` | Textos obligatorios de NASA POWER (con versión y fecha) y PVGIS (CC BY 4.0) |
| `http/retrying_get.dart` | GET con reintentos (2, 4, 8, 16 s) ante 429/529/5xx y User-Agent propio |
| `tool/cross_validation.dart` | Validación cruzada del motor (necesita red) |

Dependencias: `http`, `solar_engine`. Sin Flutter.

## Cómo probar
```bash
cd packages/data_sources
dart analyze --fatal-infos
dart test        # sin red: usa respuestas grabadas en test/fixtures/
```
Prueba con red (opcional): `dart run tool/cross_validation.dart` (requiere `tools/golden_data/out/cross_reference.csv`).

## Notas
- Licencias y límites: `docs/fuentes-de-datos.md`. NASA POWER responde 429 si se excede; PVGIS limita a 30 llamadas/s por IP.
- NASA POWER promedia celdas de ~50 km: en montaña su temperatura puede diferir varios grados (se avisa si > 3 °C contra PVGIS).
