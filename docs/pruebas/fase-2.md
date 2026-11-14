# Aceptación — Fase F2 (Motor solar y clima)

Lista para el dueño. Marca cada casilla en tu teléfono Android. Si algo falla, abre un *issue* con la plantilla **Error (bug)** e incluye una captura.

> El APK con F2 aparece en el enlace fijo **cuando el chat principal integre la rama `fase-2-motor-clima`** en la rama base (ADR-006):
> **https://github.com/Navaleitor/Panelsolar/releases/latest/download/panelsolar.apk**
> Se instala encima de la versión anterior y conserva tus datos.

## 1. Pantalla de clima y producción
Necesitas conexión a Internet la primera vez.

1. Abre **Proyectos** → un proyecto que ya tenga ubicación (si no tienes, crea uno y en **Ubicación** escribe a mano `25.6866, -100.3161`, el centro de Monterrey).
2. En la ficha del proyecto baja hasta el final y toca **Clima y producción**.
   - [ ] Arriba dice "Ubicación guardada del proyecto:" con sus coordenadas (no se pueden editar aquí).
   - [ ] Toca **Descargar clima y calcular**: aparece una barra con "Descargando clima y simulando…" y **la pantalla no se congela** (puedes desplazarte).
   - [ ] En menos de ~30 s (depende de la red) aparecen los resultados.
3. Revisa los resultados de Monterrey (valores esperados con datos 2021–2025):
   - [ ] **Serie:** "NASA POWER 2021–2025".
   - [ ] **Producción anual:** alrededor de **1 770 kWh por kWp al año** (rango aceptable 1 680–1 860).
   - [ ] **Producción mensual:** 12 barras bastante parejas (130–175 kWh); marzo la más alta y diciembre la más baja.
   - [ ] **Orientación óptima:** inclinación ≈ **26°** y azimut ≈ **172°** (casi al sur).
   - [ ] La línea "Con inclinación = latitud" da un valor muy cercano (diferencia menor a ±1 %).
   - [ ] **Zona horaria:** "America/Monterrey (UTC−6)".
   - [ ] **Temperaturas del sitio:** "Mínima para diseño ≈ −6 °C (NASA POWER)" y "Máxima para diseño ≈ 38 °C (NASA POWER)", y debajo las dos fuentes: NASA POWER (≈ −6 / 38 °C) y PVGIS (≈ 2 / 36 °C). Se usa la más extrema de las dos (tu decisión).
   - [ ] **Trayectoria solar:** tres curvas: la roja (junio) más alta y larga, la verde (equinoccios) en medio y la azul (diciembre) más baja y corta.
   - [ ] **Advertencias:** puede decir que se ajustó la irradiancia directa en varias horas; es normal (ver ficha 14).
   - [ ] **Fuentes de datos:** aparecen los textos de NASA POWER (con versión y fecha de hoy) y "PVGIS © Unión Europea… (CC BY 4.0)".
4. Sin datos: activa el **modo avión**, sal de la pantalla, vuelve a entrar y toca **Descargar clima y calcular**.
   - [ ] Los resultados aparecen igual, porque el clima quedó guardado en el teléfono para ese proyecto.
5. Proyecto **sin** ubicación: abre otro proyecto que no tenga ubicación → **Clima y producción**.
   - [ ] Aparece el aviso "Este proyecto todavía no tiene ubicación…" y puedes escribir las coordenadas. Prueba **Madrid: 40.4168, −3.7038**.
   - [ ] Producción ≈ 1 600 kWh/kWp; inclinación óptima ≈ 36°; julio el mes más alto y diciembre el más bajo.
6. Sin proyecto: **Ajustes** → **Clima y producción (prueba F2)** permite probar cualquier coordenada. Prueba **Bogotá: 4.7110, −74.0721**.
   - [ ] Aparece una advertencia de que la temperatura de NASA difiere varios °C de la de PVGIS (esperado: la celda de NASA está más baja que Bogotá).
   - [ ] Temperaturas para diseño: mínima ≈ 4 °C **(PVGIS)** y máxima ≈ 29 °C **(NASA POWER)**: cada una sale de la fuente más extrema.
7. Escribe una latitud de **95**.
   - [ ] Aparece "Escribe un número válido" y no descarga nada.
8. En inglés (idioma del teléfono): los textos de la pantalla están traducidos.

## 2. Validación del motor (revisión en GitHub)
- [ ] La ejecución de **CI** de la rama está en verde. Ahora también revisa que la cobertura de pruebas del motor sea ≥ 90 % (hoy 99.7 %).
- [ ] Leer [`docs/pruebas/validacion-motor.md`](validacion-motor.md):
  - frente a pvlib la diferencia es prácticamente cero;
  - frente a PVWatts y PVGIS, las 6 ciudades quedan dentro de ±5 %.
- [ ] Revisar las fichas de fórmulas en [`docs/formulas/`](../formulas/README.md): cada una explica la fórmula en español, sus unidades, la fuente y un caso de prueba.

## 3. Zona horaria automática (sin Internet)
1. Crea un proyecto y en **Ubicación** → escribe a mano `29.0729, -110.9559` (Hermosillo).
   - [ ] En la confirmación, la zona horaria propuesta es **America/Hermosillo** (aunque tu teléfono esté en otra zona). Puedes cambiarla si quieres.
2. Repite con `21.1619, -86.8515` (Cancún) → **America/Cancun**, y con `32.5149, -117.0382` (Tijuana) → **America/Tijuana**.
   - [ ] Las tres salen bien con el **modo avión** activado.
3. **Altitud:** si la dejas vacía no pasa nada; el cálculo usa un valor interno y no muestra error.

## 4. Decisiones del dueño aplicadas (2026-11-14)
- [x] Temperaturas para strings: la más extrema de NASA y PVGIS, con las dos visibles y aviso si difieren > 3 °C.
- [x] Zona horaria deducida de las coordenadas, sin conexión, editable (agrega ≈ 1.2 MB a la app).
- [x] Altitud opcional y manual.

## Notas
- La zona horaria usa límites de OpenStreetMap (licencia ODbL); por eso aparece "© OpenStreetMap contributors" en las fuentes.
- La producción es para **1 kWp** (por ejemplo, 2 paneles de 500 W) con pérdidas típicas (11.4 %), sin sombras. Las sombras reales y el equipo específico llegan en F3 y F4.
- Cerca del ecuador (Bogotá) el azimut óptimo casi no importa porque la inclinación es baja (≈ 10°): puede salir hacia el suroeste sin que cambie la producción.
- La orientación óptima se busca con el año típico de PVGIS y la producción se calcula con los 5 años de NASA; por eso "inclinación = latitud" a veces da unos kWh más (menos de 1 %).
- El acceso de Ajustes es solo para pruebas; el uso normal es desde la ficha de cada proyecto. En F4 el diseño completo usará este mismo clima.

Firma / fecha: ____________________
