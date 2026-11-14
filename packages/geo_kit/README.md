# geo_kit

Geometría: polígonos, proyección ENU, empaquetado de paneles y parseo de enlaces de mapas. Dart puro, **sin red ni Flutter**.

## Estado
- **F1**: `LatLng` y lectura de enlaces/texto de ubicación (este documento).
- **F2**: zona horaria IANA a partir de coordenadas, sin conexión (`TimeZoneLocator`).
- **F3**: polígonos, calibración, proyección ENU (pendiente).

## Enlaces de mapas (F1)
`MapLinkParser.parse(texto)` devuelve un `MapLinkResult`:

| Resultado | Cuándo |
|---|---|
| `MapLinkCoordinates(point)` | Encontró latitud y longitud. |
| `MapLinkNeedsExpansion(uri)` | Enlace corto (`maps.app.goo.gl`, `goo.gl/maps`, `g.co/kgs`, `maps.apple`, `apple.co`): hay que seguir su redirección. |
| `MapLinkPlaceQuery(query)` | El enlace solo trae un lugar o dirección en texto → se puede buscar con el geocodificador. |
| `MapLinkUnrecognized()` | No es un enlace de mapa ni un par de coordenadas. |

Formatos soportados (cada uno tiene prueba en `test/map_link_parser_test.dart`):
- Google: `@lat,lon,zoom`, pin `!3d…!4d…` (tiene prioridad), `?q=`, `?q=loc:`, `?api=1&query=`, `/maps/search/lat,lon`, dominios de país (`google.com.mx`), lugar en grados/minutos/segundos.
- Apple: `?ll=`, `?q=`, `?sll=`, `/place?coordinate=`, `?address=` (solo texto → `MapLinkPlaceQuery`).
- `geo:lat,lon` y `geo:0,0?q=lat,lon(Etiqueta)` (Android).
- Texto: `25.6866, -100.3161` o `25°41'11.8"N 100°18'58.0"W` (acepta `O` de oeste).
- El enlace puede venir dentro de un texto compartido ("Casa de Ana https://…").

`MapLinkResolver(fetchRedirect).resolve(texto)` hace lo mismo y, si el enlace es corto, sigue hasta 5 redirecciones. La función `fetchRedirect` (petición HTTP sin seguir redirecciones) la pone la app (`app/lib/features/site/data/http_redirect_fetcher.dart`), así este paquete no depende de la red.

## Zona horaria sin conexión (F2)
`TimeZoneLocator.fromGzip(bytes).zoneAt(lat, lon)` → nombre IANA (p. ej. `America/Hermosillo`). En el mar o en un hueco devuelve la zona náutica `Etc/GMT±N`.

- Datos: `assets/timezones.bin.gz` (≈ 1.2 MB): límites de *timezone-boundary-builder* (con océanos), simplificados a ~500 m. **© OpenStreetMap contributors, ODbL 1.0** → mostrar `TimeZoneLocator.attribution`.
- La app lo carga como asset `packages/geo_kit/assets/timezones.bin.gz` (declarado en `pubspec.yaml`, sección `flutter:`).
- Regenerar: `python3 tools/timezones/build_timezones.py` y `python3 tools/timezones/sample_points.py` (puntos de prueba).
- Precisión: las 16 ciudades de referencia exactas y ≥ 99 % de 4 000 puntos al azar igual que los datos completos (`test/time_zone_locator_test.dart`). Ficha: `docs/formulas/15-zona-horaria.md`.

## Archivos clave
- `lib/src/lat_lng.dart` — punto WGS84 con validación de rangos.
- `lib/src/map_links/map_link_parser.dart` — reglas por formato.
- `lib/src/map_links/coordinate_text.dart` — pares decimales y grados/minutos/segundos.
- `lib/src/map_links/map_link_resolver.dart` — expansión de enlaces cortos.
- `lib/src/time_zones/` — lector del índice binario y búsqueda punto-en-polígono.

## Cómo probar
```bash
cd packages/geo_kit
dart test
```

## Agregar un formato nuevo
1. Agrega el ejemplo real (sin datos personales) como prueba en `test/map_link_parser_test.dart` y comprueba que falla.
2. Ajusta la regla en `map_link_parser.dart` (o el dominio en `shortLinkHosts`).
3. `dart test` en verde.
