# Datos de referencia (golden data)

Scripts Python con [pvlib](https://pvlib-python.readthedocs.io) (y PySAM para PVWatts) que generan los valores de referencia de las pruebas de `packages/solar_engine` (plan D). Versiones usadas: `test/golden/meta.csv` (pvlib 0.16.1, pandas 3.0.5, numpy 2.5.3, Python 3.13).

## Archivos
| Script | Qué hace | Salida |
|---|---|---|
| `sites.py` | Los 6 sitios de referencia (Monterrey, CDMX, Hermosillo, Madrid, Bogotá, Phoenix) | — |
| `download_tmy.py` | Descarga el TMY de PVGIS 5.3 de cada sitio (red) | `packages/solar_engine/test/golden/tmy/<sitio>.csv.gz` |
| `reference_model.py` | La cadena de modelos con pvlib, con las mismas convenciones que el motor Dart | — |
| `generate_golden.py` | CSV de referencia: posición solar, detalle horario, totales anuales y casos por fórmula | `test/golden/*.csv` |
| `cross_validation.py` | PVWatts v8 (PySAM, local) con el mismo TMY + PVGIS PVcalc (red) | `out/cross_reference.csv` |
| `gen_spa_tables.py` | Genera las tablas del NREL SPA en Dart desde pvlib | `lib/src/position/spa_*_terms.dart` |

## Tolerancias (plan D)
Posición solar ±0.01° · POA ±1 % (o ±1 W/m² en valores pequeños) · energía anual ±2 % · fórmulas sueltas 1×10⁻⁶ relativo · validación cruzada ±5 %.

## Cómo regenerar
```bash
pip install pvlib==0.16.1 pandas numpy nrel-pysam==7.1.1.post1
# desde la raíz del repo
python3 tools/golden_data/download_tmy.py        # opcional (cambia los datos de entrada)
python3 tools/golden_data/generate_golden.py
python3 tools/golden_data/cross_validation.py
cd packages/solar_engine && dart test
```
Si cambia una fórmula del motor a propósito, se cambia también `reference_model.py`, se regeneran los CSV y se explica el cambio en la ficha de `docs/formulas/`.

Datos de entrada: PVGIS © Unión Europea, 2001–2026 (CC BY 4.0).
