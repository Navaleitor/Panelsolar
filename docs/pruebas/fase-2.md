# Aceptación — Fase F2 (Motor solar y clima)

Lista para el dueño. Marca cada casilla en tu teléfono Android. Si algo falla, abre un *issue* con la plantilla **Error (bug)** e incluye una captura.

> El APK con F2 aparece en el enlace fijo **cuando el chat principal integre la rama `fase-2-motor-clima`** en la rama base (ADR-006):
> **https://github.com/Navaleitor/Panelsolar/releases/latest/download/panelsolar.apk**
> Se instala encima de la versión anterior y conserva tus datos.

## 1. Pantalla de clima y producción
Necesitas conexión a Internet la primera vez.

1. Abre **Ajustes** → toca **Clima y producción (prueba F2)**.
2. Vienen escritas las coordenadas del centro de Monterrey (25.6866, −100.3161). Toca **Descargar clima y calcular**.
   - [ ] Aparece una barra de progreso con "Descargando clima y simulando…" y **la pantalla no se congela** (puedes desplazarte).
   - [ ] En menos de ~30 s (depende de la red) aparecen los resultados.
3. Revisa los resultados de Monterrey (valores esperados con datos 2021–2025):
   - [ ] **Serie:** "NASA POWER 2021–2025".
   - [ ] **Producción anual:** alrededor de **1 770 kWh por kWp al año** (rango aceptable 1 680–1 860).
   - [ ] **Producción mensual:** 12 barras bastante parejas (130–175 kWh); marzo la más alta y diciembre la más baja.
   - [ ] **Orientación óptima:** inclinación ≈ **26°** y azimut ≈ **172°** (casi al sur).
   - [ ] La línea "Con inclinación = latitud" da un valor muy cercano (diferencia menor a ±1 %).
   - [ ] **Temperaturas del sitio:** mínima registrada ≈ −6 °C y máxima ≈ 38 °C (datos de NASA 2021–2025).
   - [ ] **Trayectoria solar:** tres curvas: la roja (junio) más alta y larga, la verde (equinoccios) en medio y la azul (diciembre) más baja y corta.
   - [ ] **Advertencias:** puede decir que se ajustó la irradiancia directa en varias horas; es normal (ver ficha 14).
   - [ ] **Fuentes de datos:** aparecen los textos de NASA POWER (con versión y fecha de hoy) y "PVGIS © Unión Europea… (CC BY 4.0)".
4. Sin datos: activa el **modo avión**, vuelve a tocar **Descargar clima y calcular**.
   - [ ] Los resultados aparecen igual, porque el clima quedó guardado en el teléfono.
5. Prueba otra ciudad (con datos móviles o Wi-Fi), por ejemplo **Madrid: 40.4168, −3.7038**.
   - [ ] Producción ≈ 1 600 kWh/kWp; inclinación óptima ≈ 36°; julio el mes más alto y diciembre el más bajo.
6. Prueba **Bogotá: 4.7110, −74.0721**.
   - [ ] Aparece una advertencia de que la temperatura de NASA difiere varios °C de la de PVGIS (esperado; ver la sección 3).
7. Escribe una latitud de **95**.
   - [ ] Aparece "Escriba un número válido" y no descarga nada.
8. En inglés (idioma del teléfono): los textos de la pantalla están traducidos.

## 2. Validación del motor (revisión en GitHub)
- [ ] La ejecución de **CI** de la rama está en verde. Ahora también revisa que la cobertura de pruebas del motor sea ≥ 90 % (hoy 99.7 %).
- [ ] Leer [`docs/pruebas/validacion-motor.md`](validacion-motor.md):
  - frente a pvlib la diferencia es prácticamente cero;
  - frente a PVWatts y PVGIS, las 6 ciudades quedan dentro de ±5 %.
- [ ] Revisar las fichas de fórmulas en [`docs/formulas/`](../formulas/README.md): cada una explica la fórmula en español, sus unidades, la fuente y un caso de prueba.

## 3. Decisión pendiente
- [ ] **Temperatura para diseñar strings (F4).** NASA y PVGIS pueden dar temperaturas distintas en zonas de montaña (Bogotá: +6.5 °C en NASA). Propuesta: usar la **mínima más fría** y la **máxima más caliente** de las dos fuentes (lo más seguro). ¿De acuerdo?

## Notas
- La producción es para **1 kWp** (por ejemplo, 2 paneles de 500 W) con pérdidas típicas (11.4 %), sin sombras. Las sombras reales y el equipo específico llegan en F3 y F4.
- Cerca del ecuador (Bogotá) el azimut óptimo casi no importa porque la inclinación es baja (≈ 10°): puede salir hacia el suroeste sin que cambie la producción.
- La orientación óptima se busca con el año típico de PVGIS y la producción se calcula con los 5 años de NASA; por eso "inclinación = latitud" a veces da unos kWh más (menos de 1 %).
- La pantalla es temporal (prueba de F2). En F3/F4 el clima se mostrará dentro de cada proyecto.

Firma / fecha: ____________________
