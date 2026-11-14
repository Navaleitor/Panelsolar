# Validación del motor solar (F2)

Fecha: 2026-11-12 · Rama `fase-2-motor-clima` · Plan maestro, sección D y "Verificación del plan" (cierre de F2).

**Resumen para el dueño:** el motor de Panelsolar calcula lo mismo que la biblioteca de referencia pvlib, hasta el último decimal útil. Comparado con dos calculadoras reconocidas (PVWatts de NREL y PVGIS de la Unión Europea), la producción anual queda **dentro de ±5 % en las 6 ciudades**, que es la meta del plan.

## 1. Fórmula por fórmula contra pvlib (pruebas golden)

Referencia: pvlib-python 0.16.1 (Sandia/NREL). Los scripts están en `tools/golden_data/` y las pruebas Dart en `packages/solar_engine/test/`. Entrada: TMY de PVGIS 5.3 de cada sitio (8 760 h). Dos sistemas por sitio:
- **s1:** inclinación = latitud, al sur, Perez + Faiman, pérdidas por defecto (11.4 %), DC/AC 1.2.
- **s2:** 10° al sureste (135°), Hay-Davies + NOCT, sin pérdidas, DC/AC 1.4 (fuerza el recorte del inversor).

| Sitio | Δ posición máx. (°) | Δ POA máx. s1 | Δ POA máx. s2 | Δ energía anual s1 | Δ energía anual s2 |
|---|---|---|---|---|---|
| Monterrey | 5.0e-9 | 8.9e-7 % | 5.6e-7 % | 2.1e-6 % | 1.1e-7 % |
| CDMX | 5.0e-9 | 5.5e-7 % | 7.7e-7 % | 4.7e-7 % | 1.7e-6 % |
| Hermosillo | 5.0e-9 | 6.4e-7 % | 6.2e-7 % | 1.2e-7 % | 5.3e-7 % |
| Madrid | 5.0e-9 | 7.0e-7 % | 7.7e-7 % | 2.1e-6 % | 8.7e-7 % |
| Bogotá | 5.0e-9 | 8.1e-7 % | 9.0e-7 % | 2.7e-6 % | 1.5e-6 % |
| Phoenix | 5.0e-9 | 9.0e-7 % | 7.6e-7 % | 1.6e-6 % | 2.1e-6 % |
| **Tolerancia del plan** | **0.01°** | **1 %** | **1 %** | **2 %** | **2 %** |

(Δ POA: horas con POA ≥ 50 W/m², una de cada 10 horas diurnas. Las diferencias que quedan son solo de redondeo de los CSV.)

Además, el ejemplo oficial del artículo del NREL SPA (Golden, Colorado, 17-oct-2003) da cenit 50.11162° y azimut 194.34024°, igual que el artículo.

Tabla generada con `cd packages/solar_engine && dart run tool/golden_report.dart`.

## 2. Validación cruzada: energía anual contra PVWatts y PVGIS (meta ±5 %)

Sistema común: 1 kWp, inclinación = latitud redondeada, al sur, rack abierto, γ = −0.37 %/°C, pérdidas 14.08 % (desglose por defecto de PVWatts), DC/AC 1.2, inversor 96 %.

- **Motor + TMY vs PVWatts + TMY:** los dos calculan con exactamente el mismo clima (TMY de PVGIS). PVWatts v8 de NREL se ejecuta con PySAM 7.1.1 (el motor oficial de SAM). La diferencia mide **solo los modelos**.
- **Motor + NASA vs PVGIS PVcalc:** es lo que hará la app: NASA POWER 2021–2025 con su control de calidad, contra la calculadora PVGIS 5.3 en línea (sus propios datos 2005–2023, sus propios modelos y el horizonte del terreno).

| Sitio | Motor + TMY (kWh) | PVWatts + TMY | Dif. | Motor + NASA | PVGIS PVcalc | Dif. | GHI NASA vs PVGIS | ΔT media NASA − PVGIS |
|---|---|---|---|---|---|---|---|---|
| Monterrey | 1745 | 1729 | +0.9 % | 1713 | 1639 | **+4.5 %** | −1.2 % | −1.7 °C |
| CDMX | 1740 | 1711 | +1.7 % | 1670 | 1714 | −2.5 % | −2.0 % | −1.4 °C |
| Hermosillo | 1889 | 1883 | +0.3 % | 1833 | 1810 | +1.3 % | −0.7 % | −0.7 °C |
| Madrid | 1635 | 1605 | +1.9 % | 1544 | 1617 | **−4.5 %** | −5.1 % | −0.4 °C |
| Bogotá | 1382 | 1344 | +2.8 % | 1335 | 1322 | +1.1 % | −0.0 % | **+6.5 °C** |
| Phoenix | 1909 | 1902 | +0.4 % | 1821 | 1827 | −0.4 % | −1.7 % | +0.2 °C |

**Resultado: los 12 valores quedan dentro de ±5 %.**

### Cómo leer las diferencias
- **Motor vs PVWatts (+0.3 % a +2.8 %):** el motor da un poco más porque usa Perez para el cielo y Faiman para la temperatura. PVWatts usa otro modelo de temperatura de celda y su propio IAM. Las diferencias son las esperadas entre programas reconocidos.
- **Monterrey (+4.5 %) y Madrid (−4.5 %)** son los casos más cercanos al límite. Se explican por el clima: PVGIS en Monterrey da 6 % menos irradiación en el plano con su promedio 2005–2023 y su horizonte (Sierra Madre) que su propio TMY. En Madrid, NASA trae 5 % menos sol que PVGIS (SARAH3, de satélite y más precisa en Europa).
- **Bogotá:** la temperatura de NASA es 6.5 °C más alta que la real. Su celda de ~50 km está a 1 790 m de altitud y Bogotá a 2 640 m. La energía casi no cambia (≈ 2 %), pero **sí importa para el diseño de strings (F4)**; la app ya lo advierte (umbral 3 °C).

## 3. Hallazgos que cambiaron el código

1. **NASA POWER no "cuadra" sus componentes.** En Bogotá y CDMX, DNI·cos θz + DHI daba ≈ 90 % de la GHI. Con los datos crudos el motor subestimaba la energía 8–9 % frente a PVGIS. Se agregó el **cierre de componentes** al control de calidad (ficha 14): se conserva GHI y DHI y se recalcula la DNI. Con el cierre, todos los sitios quedan dentro de ±5 %.
2. **Hora de los datos de PVGIS.** Se midió dónde cae el centro de la GHI respecto al mediodía solar:
   - ERA5 (NASA y TMY de Monterrey/Phoenix): centrada en HH:30.
   - SARAH3 (Madrid): centrada en ≈ HH:10.

   Coincide con el campo `irradiance_time_offset` que publica PVGIS (0.5 h y 0.1705 h), así que el cliente PVGIS ahora lo respeta. Pero PVGIS calculó su DNI con el Sol en HH:00, lo que inflaba la directa de la mañana y movía el azimut óptimo de Monterrey hacia el este (156°). Con el cierre de componentes el óptimo vuelve a ≈ 172°.

## 4. Cómo regenerar todo

```bash
# Python (una vez)
pip install pvlib==0.16.1 pandas numpy nrel-pysam==7.1.1.post1

# Desde la raíz del repo
python3 tools/golden_data/download_tmy.py      # opcional: renovar los TMY (red)
python3 tools/golden_data/generate_golden.py   # CSV golden con pvlib
python3 tools/golden_data/cross_validation.py  # PVWatts (local) + PVGIS PVcalc (red)

cd packages/solar_engine && dart test && dart run tool/golden_report.dart   # tabla 1
cd ../data_sources && dart run tool/cross_validation.dart                    # tabla 2 (red: NASA POWER)
```

Resultados crudos en `tools/golden_data/out/cross_reference.csv` y `engine_results.csv`. Detalle de los scripts: `tools/golden_data/README.md`.

## 5. Pendiente: validación de campo
El plan pide además comparar con instalaciones reales del dueño (meta ±10 % anual). Eso requiere sus datos de monitoreo y queda para F6 (seguimiento de producción).
