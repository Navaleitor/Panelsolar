# regional_packs

Normas, tarifas y factores por país (México primero) como datos JSON + validadores.

## Estado
- **F1**: catálogo de tarifas de México (CFE 1, 1A–1F, DAC, PDBT) para capturar recibos de luz.
- **F4**: tablas eléctricas de **NOM-001-SEDE-2012** (calibres AWG/mm², resistencias, ampacidades, factores de temperatura, agrupamiento y azotea; capacidades de interruptores y fusibles; conductor de tierra 250-122) y velocidades regionales de viento de referencia (MDOC CFE 2020, editables).
- **F5**: precios, escalones y medición neta.

## Eléctrico y viento (F4)
| Archivo | Qué trae |
|---|---|
| `src/electrical/conductor_table.dart` | `ConductorStandard` (interfaz para otras normas), `ConductorSize`, `WireMaterial`, `RacewayType` |
| `src/mx/nom_conductors.dart` | `NomConductors`: tablas 310-15(b)(16), 310-15(b)(2)(a), 310-15(b)(3)(a)/(c), cap. 10 tabla 8 |
| `src/mx/nom_protections.dart` | Capacidades 240-6, fusibles gPV, tierra 250-122, 600 V en vivienda |
| `src/mx/wind_speeds.dart` | Velocidad regional por ciudad (**referencia: verificar en el MDOC**) |

Todo es **indicativo y requiere revisión de un profesional** (UVIE). Fichas 24–26 en `docs/formulas/`. Para corregir un valor: editar la tabla y su prueba en `test/nom_conductors_test.dart`.

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
