# regional_packs

Normas, tarifas y factores por país (México primero) como datos JSON + validadores.

## Estado
- **F1**: catálogo de tarifas de México (CFE 1, 1A–1F, DAC, PDBT) para capturar recibos de luz.
- **F5**: precios, escalones, medición neta y normas.

## Tarifas (F1)
- `Tariff`: código único (`MX-CFE-1C`, es lo que se guarda en el recibo — **no cambiarlo nunca**), nombre corto, nombres es/en, sector, periodo de facturación habitual, temperatura mínima de verano y límite de alto consumo (kWh/mes, promedio de 12 meses → DAC).
- `TariffCatalog`: lee JSON `{"tariffs": [...]}` y valida (códigos únicos con prefijo `PAÍS-SUMINISTRADOR-`, nombres no vacíos, límites positivos).
- `mexicoTariffs`: catálogo listo; datos en `lib/src/mx/cfe_tariffs.dart` (JSON dentro de un archivo Dart para no depender de *assets*).

Para corregir un dato: editar el JSON de `cfe_tariffs.dart` y ajustar `test/cfe_tariffs_test.dart`.

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
