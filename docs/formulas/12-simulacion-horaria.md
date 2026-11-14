# 12 · Simulación horaria completa

**Qué calcula:** la producción hora por hora de un sistema, encadenando las fichas 01 a 10, y los totales mensuales y anuales.

**Código:** `packages/solar_engine/lib/src/simulation/` (`simulation_inputs.dart`, `simulator.dart`, `monthly_aggregator.dart`).

## Cadena por cada hora
1. **Tiempo:** cada dato es el promedio de un intervalo; el Sol se evalúa en su centro (NASA POWER: minuto 30; PVGIS: el minuto que indica `irradiance_time_offset`, 30 en ERA5 y ≈ 10 en SARAH).
2. Posición solar SPA (01) con presión estándar a la altitud del sitio y cenit **aparente**.
3. I₀ y masa de aire (03). Si faltan DNI o DHI → Erbs (04).
4. Si un horizonte (terreno de PVGIS) tapa el Sol → directa = 0.
5. POA con Perez o Hay-Davies (05); albedo de NASA o 0.2.
6. IAM ASHRAE (06) → irradiancia efectiva.
7. Temperatura de celda con la POA total (07).
8. Pdc PVWatts (08) × factor de pérdidas × degradación (09).
9. Pac con inversor PVWatts y recorte (10).
10. Energía = Pac × duración del intervalo.

## Agregación
- Meses en **hora estándar local** (sin horario de verano), con el desfase de la zona IANA del sitio (ficha 15); si no hay zona, se estima como redondeo(longitud/15). Un mes cuenta si tiene ≥ 90 % de sus horas.
- **Altitud:** la del proyecto si el usuario la escribió; si no, internamente la que informa la fuente de clima (PVGIS o NASA) o 0 m, sin mostrar error. Solo afecta la presión para la refracción.
- **Mes típico** = promedio de ese mes en todos los años completos; **año típico** = suma de los 12 meses típicos.
- Rendimiento específico = E_anual/kWp; PR = rendimiento específico / irradiación anual en el plano.

## Rendimiento (requisito A.4: 5 años en < 3 s)
5 años horarios (43 800 h) en **≈ 0.3 s** en la máquina de CI; la prueba exige < 1.5 s. En la app todo corre en un *isolate*.

## Validación
- Contra pvlib (misma cadena) en 6 sitios × 2 sistemas: energía anual con diferencia < 3×10⁻⁶ % (tolerancia 2 %).
- Contra PVWatts (NREL) y PVGIS: ver `docs/pruebas/validacion-motor.md`.

**Pruebas:** `test/simulation/golden_simulation_test.dart`, `simulation_test.dart`, `performance_test.dart`.
