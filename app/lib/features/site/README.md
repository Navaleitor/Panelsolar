# Sitio — ubicación

Obtiene **solo coordenadas** (latitud, longitud, altitud opcional, zona horaria) del sitio del proyecto. No hay mapa ni imagen de ningún proveedor ([ADR-005](../../../../docs/adr/ADR-005-estrategia-techo-por-capas.md)). En F3 se agrega aquí el techo (imagen importada, calibración, trazado).

## Estado
**F1 completa** (ubicación). Techo: F3.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/projects/:id/location` | `presentation/location_page.dart` | 4 opciones → pantalla de confirmación → guardar. |
| (ficha del proyecto) | `presentation/site_summary_card.dart` | Coordenadas guardadas, origen, altitud y zona horaria. |

## Las 4 formas de obtener la ubicación
| Opción | Cómo | Archivo |
|---|---|---|
| GPS | `geolocator`, alta precisión, 30 s máx. Errores con mensaje: ubicación apagada, permiso negado/bloqueado, sin señal. | `data/geolocator_location_service.dart` |
| Dirección | `Geocoder` de `packages/data_sources` (Nominatim + caché + 1 petición/s + User-Agent `Panelsolar/<versión>`). Solo busca al tocar **Buscar** (sin autocompletar). Muestra "© OpenStreetMap contributors". | `presentation/widgets/address_search_sheet.dart` |
| Enlace de Google/Apple Maps | `MapLinkResolver` de `packages/geo_kit`. Enlaces cortos (`maps.app.goo.gl`, `maps.apple`…) se expanden leyendo solo la cabecera de redirección HTTP. Si el enlace trae solo un nombre de lugar, abre la búsqueda por dirección. | `presentation/widgets/map_link_dialog.dart`, `data/http_redirect_fetcher.dart` |
| A mano | Decimal o grados/minutos/segundos (`parseCoordinateText` de geo_kit). | `presentation/widgets/manual_coordinates_dialog.dart` |

**Confirmación** (`presentation/widgets/location_confirm_view.dart`): coordenadas en decimal y en grados/minutos/segundos, origen y precisión; altitud editable (el GPS la llena); zona horaria IANA: se propone la **deducida de las coordenadas sin conexión** (`TimeZoneService.timeZoneAt`, índice de `geo_kit`, F2) y, si no se puede, la del teléfono; es editable y se valida con la base del paquete `timezone`. Botón copiar para revisarlas en otra app.

## Capas
- `domain/` — `LocationCandidate`, `CoordinateFormat`, interfaces `LocationService` y `TimeZoneService`.
- `data/` — GPS, zonas horarias, redirecciones HTTP y `site_data_providers.dart` (aquí se elige el `Geocoder`: para cambiar de servicio basta con cambiar este provider).
- `presentation/` — pantallas y diálogos.

## Cómo probar
```bash
cd app
flutter test test/features/site
```
Las pruebas usan GPS, geocodificador y redirecciones **falsos** (`test/helpers/fakes.dart`), sin red.

## Notas
- La zona horaria se deduce de las coordenadas sin conexión (decisión del dueño 2026-11-14, implementada en F2): Hermosillo → `America/Hermosillo`, Cancún → `America/Cancun`, Tijuana → `America/Tijuana`. Pruebas: `test/features/site/coordinate_time_zone_test.dart` y `location_time_zone_proposal_test.dart`.
- Altitud por dirección/enlace: vacía salvo que el usuario la escriba (F2 podrá llenarla con el dato de elevación de PVGIS/NASA).
