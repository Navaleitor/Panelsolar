# 14 · Control de calidad de los datos de clima

**Qué hace:** revisa y limpia la serie descargada antes de simular, y avisa al usuario de lo que corrigió.

**Código:** `packages/data_sources/lib/src/quality/` (`weather_quality_control.dart`, `component_closure.dart`, `quality_report.dart`).

## Reglas
1. **Huecos de tiempo:** si faltan horas en una serie cronológica, se insertan.
2. **Valores faltantes** (−999 de NASA):
   - irradiancia de noche (Sol bajo el horizonte al inicio y al final de la hora) → 0;
   - irradiancia de día → promedio de la misma hora del día anterior y del siguiente; si no hay, interpolación lineal;
   - temperatura y viento → interpolación lineal; albedo → promedio de la serie.
3. **Negativos:** irradiancia o viento < 0 → 0.
4. **GHI > extraterrestre:** se recorta a I₀·max(cos θz en la hora) + 5 W/m².
5. **Cierre de componentes:** se exige GHI = DNI·cos θz + DHI conservando GHI y DHI:
   DNI = (GHI − min(DHI, GHI))/cos θz (con θz a la mitad del intervalo; si θz > 87°, DNI = 0 y DHI = GHI; DNI ≤ I₀).
   *Por qué:* en NASA POWER la suma DNI·cos θz + DHI da ≈ 90 % de la GHI en sitios como Bogotá y CDMX, y eso subestimaba la energía ~9 %. En el TMY de PVGIS la directa se calculó con el Sol en HH:00 aunque la GHI está centrada en HH:30 (ERA5).
6. **Usable** si faltaba < 5 % de los valores.
7. **Comparación NASA vs PVGIS:** advertencia si la irradiación anual difiere > 10 % o la temperatura media > 3 °C.

## Fuente
Plan maestro B.5. Cierre de componentes: misma relación geométrica que `pvlib.irradiance.complete_irradiance`.

## Caso de prueba
Respuesta grabada de NASA POWER (Monterrey, 2 días) con una hora quitada, un −999 de GHI, una DNI negativa y un −999 de temperatura: se agrega 1 hora, la GHI faltante se toma del día siguiente, la temperatura se interpola, 1 negativo → 0, informe "usable" con 4 avisos.

**Prueba:** `packages/data_sources/test/weather_quality_control_test.dart`.
