# 15 · Zona horaria a partir de las coordenadas (sin conexión)

**Qué calcula:** la zona horaria oficial (nombre IANA, p. ej. `America/Hermosillo`) de un punto, sin Internet. El motor la necesita para agrupar la producción por meses en la hora local del sitio, y la ficha del proyecto la propone al confirmar la ubicación.

**Código:** `packages/geo_kit/lib/src/time_zones/` (búsqueda) y `app/lib/features/site/data/device_time_zone_service.dart` (carga del índice y desfase estándar).

## Método
1. **Datos:** límites de zonas de *timezone-boundary-builder* 2026f, incluidos los océanos, simplificados (Douglas-Peucker, tolerancia 0.005° ≈ 500 m) y guardados en enteros de 1×10⁻⁵° con diferencias comprimidas: 444 zonas, 1 356 polígonos, ≈ 1.2 MB.
2. **Búsqueda:** para cada polígono cuya caja envolvente contiene el punto, prueba **par-impar** (se traza un rayo hacia el este y se cuentan los cruces con los bordes; impar = adentro). Las zonas de tierra se revisan antes que las de océano.
3. **Sin coincidencia** (hueco de la simplificación): zona náutica `Etc/GMT±N` con N = redondeo(longitud/15).
4. **Desfase estándar** (sin horario de verano) con la base IANA del paquete `timezone`: el desfase del 15 de enero o del 15 de julio que no es horario de verano.

## Fuente
Evan Siroky, *timezone-boundary-builder* (datos de OpenStreetMap, **ODbL 1.0**, atribución "© OpenStreetMap contributors"), empaquetados por `timezonefinder-data`. Base de reglas horarias: IANA tz database.

## Supuestos y límites
- A menos de ~500 m de una frontera de zona puede dar la zona vecina; por eso el usuario siempre puede corregirla.
- Las reglas de horario de verano cambian por ley; la app usa la base IANA incluida en el paquete `timezone` (se actualiza con las dependencias).

## Caso de prueba
| Ciudad | Zona | Desfase estándar |
|---|---|---|
| Hermosillo (29.0729, −110.9559) | `America/Hermosillo` | **UTC−7** todo el año (Sonora sin horario de verano) |
| Cancún (21.1619, −86.8515) | `America/Cancun` | **UTC−5** todo el año |
| Tijuana (32.5149, −117.0382) | `America/Tijuana` | **UTC−8** (−7 en verano) |
| Monterrey | `America/Monterrey` | UTC−6 |
| Atlántico (20, −40) | `Etc/GMT+3` | UTC−3 |

Además, 4 000 puntos al azar (1 000 en México) coinciden ≥ 99 % con los datos sin simplificar.

**Pruebas:** `packages/geo_kit/test/time_zone_locator_test.dart`, `app/test/features/site/coordinate_time_zone_test.dart`.
