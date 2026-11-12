# data_sources

Clientes HTTP para NASA POWER, PVGIS, Overpass, Nominatim y teselas, con caché.

## Estado
Paquete vacío creado en F0 (solo `DataSourcesInfo`). Su contenido se implementa en **F2**.

## Alcance previsto
Clientes de NASA POWER, PVGIS, Overpass, Nominatim y proveedores de imagen, con caché local (plan B.4/B.5).

## Archivos clave
- `lib/data_sources.dart` — API pública (solo exporta lo de `lib/src/`).
- `lib/src/` — implementación, un archivo por responsabilidad.
- `test/` — pruebas unitarias.

## Cómo probar
```bash
cd packages/data_sources
dart test
```

## Geocodificación (F1)
Biblioteca aparte: `import 'package:data_sources/geocoding.dart';` (código en `lib/src/geocoding/`, sin tocar el resto del paquete).

| Pieza | Qué hace |
|---|---|
| `Geocoder` | Interfaz intercambiable: `search(dirección) → List<GeocodeResult>` + `attribution`. |
| `NominatimGeocoder` | Implementación con Nominatim. URL configurable, `User-Agent` propio (`Panelsolar/<versión>`), máximo 1 petición/s (`RateLimiter`), errores tipados (`GeocodingException`: `network`, `rateLimited`, `badResponse`). Usa `dart:io`, sin dependencias extra. |
| `CachedGeocoder` + `JsonFileGeocodeCache` | La misma búsqueda no se repide; caché persistente en JSON (máx. 500 búsquedas). |

Reglas (ADR-004): sin autocompletar (solo se busca al tocar "Buscar"), atribución "© OpenStreetMap contributors" visible. El servicio comercial definitivo se decide en F7: basta con otra clase que implemente `Geocoder` o cambiar la URL.

Pruebas: `test/geocoding/` (sin red: el HTTP se inyecta).
