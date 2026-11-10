# regional_packs

Normas, tarifas y factores por país (México primero) como datos JSON + validadores.

## Estado
Paquete vacío creado en F0 (solo `RegionalPacksInfo`). Su contenido se implementa en **F5**.

## Alcance previsto
Paquetes regionales: normas, tarifas, ortofotos y factores por país, empezando por México (CFE/NOM).

## Archivos clave
- `lib/regional_packs.dart` — API pública (solo exporta lo de `lib/src/`).
- `lib/src/` — implementación, un archivo por responsabilidad.
- `test/` — pruebas unitarias.

## Cómo probar
```bash
cd packages/regional_packs
dart test
```
