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
