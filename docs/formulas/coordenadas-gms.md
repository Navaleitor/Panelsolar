# Coordenadas: grados/minutos/segundos ↔ decimal

- **Dónde**: lectura en `packages/geo_kit/lib/src/map_links/coordinate_text.dart` y EXIF de fotos en `app/lib/features/photos/data/photo_processor.dart`; escritura en `app/lib/features/site/domain/coordinate_format.dart` (F1).
- **Pruebas**: `packages/geo_kit/test/map_link_parser_test.dart`, `app/test/features/photos/photo_processor_test.dart`, `app/test/features/site/coordinate_format_test.dart`.

## Ecuación
Decimal = *G* + *M*/60 + *S*/3600, con signo negativo si el hemisferio es S (sur) u W/O (oeste).

Inversa (mostrar): se redondea a décimas de segundo *t* = round(|x| · 36000); *G* = ⌊*t* / 36000⌋; *M* = ⌊(*t* mod 36000) / 600⌋; *S* = (*t* mod 600) / 10. Redondear primero evita mostrar `60.0"`.

## Unidades
Grados sexagesimales (WGS84). 0.1" ≈ 3 m; 6 decimales ≈ 0.1 m.

## Caso de prueba
25°41'11.8" N, 100°18'58.0" W ↔ 25.686611, −100.316111 (Monterrey).
