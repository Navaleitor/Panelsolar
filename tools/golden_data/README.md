# Datos de referencia (golden data)

Scripts Python con [pvlib](https://pvlib-python.readthedocs.io) que generan los valores de referencia para las pruebas de `packages/solar_engine` (plan D). Se crean en F2.

Regla: cada script escribe un JSON en `packages/solar_engine/test/golden/` y documenta versión de pvlib, sitio, fechas y tolerancia.
