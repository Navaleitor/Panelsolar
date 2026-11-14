# Fichas de fórmulas

Una ficha por fórmula del motor (`packages/solar_engine`), plan B.6. Cada ficha (`NN-nombre.md`) contiene: qué calcula en palabras simples, ecuación, variables con **unidades SI**, fuente bibliográfica, supuestos/límites, caso de prueba con valores de referencia (de `tools/golden_data/`, generados con pvlib) y la ruta de la prueba que la valida.

| # | Ficha | Plan B.6 |
|---|---|---|
| 01 | [Posición solar (NREL SPA)](01-posicion-solar-spa.md) | 1 |
| 02 | [Ángulo de incidencia](02-angulo-de-incidencia.md) | 2 |
| 03 | [Extraterrestre, masa de aire y presión](03-extraterrestre-y-masa-de-aire.md) | auxiliar |
| 04 | [Descomposición de Erbs](04-descomposicion-erbs.md) | 3 |
| 05 | [POA: Perez 1990 y Hay-Davies](05-transposicion-perez-hay-davies.md) | 4 |
| 06 | [IAM ASHRAE](06-iam-ashrae.md) | 5 |
| 07 | [Temperatura de celda: Faiman y NOCT](07-temperatura-de-celda.md) | 6 |
| 08 | [Potencia DC PVWatts](08-potencia-dc-pvwatts.md) | 7 |
| 09 | [Pérdidas y degradación](09-perdidas-y-degradacion.md) | 8 |
| 10 | [Inversor PVWatts con recorte](10-inversor-pvwatts.md) | 9 |
| 11 | [Inclinación y azimut óptimos](11-orientacion-optima.md) | 10 |
| 12 | [Simulación horaria completa](12-simulacion-horaria.md) | 1–9 |
| 13 | [Estadísticas climáticas](13-estadisticas-climaticas.md) | B.5 / 14 |
| 14 | [Control de calidad del clima](14-control-de-calidad-clima.md) | B.5 |
| 15 | [Zona horaria desde coordenadas](15-zona-horaria.md) | auxiliar (decisión 2026-11-14) |

Validación de conjunto: [`docs/pruebas/validacion-motor.md`](../pruebas/validacion-motor.md).
