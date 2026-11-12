# 13 · Estadísticas climáticas del sitio

**Qué calcula:** el resumen del clima del sitio por mes y por estación (sol y temperatura), y las temperaturas extremas que F4 usará para diseñar los strings.

**Código:** `packages/solar_engine/lib/src/statistics/climate_statistics.dart`.

## Definiciones
- Irradiación mensual H_m = Σ GHI·Δt/1000 (kWh/m²) del mes típico; diaria = H_m/días del mes.
- Temperatura media mensual = promedio de las horas del mes típico; mínima y máxima = extremos horarios del mes en toda la serie.
- Estaciones meteorológicas (trimestres): hemisferio norte invierno = dic-ene-feb, primavera = mar-abr-may, verano = jun-jul-ago, otoño = sep-oct-nov; en el sur se invierten. Medias ponderadas por días.
- **Temperaturas de diseño (para F4):**
  - mínima registrada y máxima registrada (extremos horarios de toda la serie);
  - promedio de las mínimas anuales y de las máximas anuales.

| Variable | Unidad |
|---|---|
| Irradiación | kWh/m² y kWh/m²·día |
| Temperaturas | °C (aire a 2 m) |

## Fuente
Definiciones estándar (OMM, estaciones meteorológicas). Temperaturas extremas para strings: plan B.6 punto 14 (NEC 690.7 usa la mínima esperada del sitio).

## Supuestos y límites
- NASA POWER promedia una celda de ~50 km: en sitios de montaña su temperatura puede diferir varios grados de la real (Bogotá: +6.5 °C). El control de calidad avisa si NASA y PVGIS difieren > 3 °C.

## Caso de prueba
- Monterrey (TMY): GHI anual 1600–2200 kWh/m²; junio más soleado que diciembre; verano más caliente que invierno; la suma de las 4 estaciones = el año.
- Serie sintética del hemisferio sur (temperatura = número de mes): verano (dic-feb) con mín. 1 °C y máx. 12 °C; invierno (jun-ago) media 7.011 °C.

**Prueba:** `test/statistics/climate_statistics_test.dart`.
