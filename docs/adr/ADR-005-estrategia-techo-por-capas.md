# ADR-005 — Estrategia de techo por capas

- Estado: **aceptado** por el dueño (2026-11-10)
- Sustituye: la tabla de prioridades de proveedores de imagen del plan maestro, sección B.4. El texto del plan lo actualiza el chat principal en la rama base.
- Contexto: [ADR-004](ADR-004-licencias-fuentes-verificacion-f0.md) confirmó que ninguna fuente gratuita con permiso comercial claro deja **trazar y guardar** el techo sobre imagen satelital mundial (Esri: no hay permiso escrito; Google Maps: lo prohíbe). Se necesita un método que funcione en todo el mundo, sin costo y sin conexión.

## Decisión
El techo se obtiene por **capas**, de la más universal a la más automática. Todas entregan el mismo resultado: polígonos en metros, en coordenadas locales ENU del sitio (plan B.4 paso 5). Dos interfaces aíslan las fuentes:

- `ImageryProvider` — da una imagen de fondo con su escala (metros por píxel) y su orientación.
- `BuildingSource` — da contornos de edificios iniciales para una ubicación.

### Capa 0 — PRINCIPAL: imagen importada por el usuario + calibración
- El usuario importa una imagen **cenital**: una captura de su proveedor de mapas, una foto de dron o un plano.
- **Calibración de escala:** traza una línea de referencia de longitud conocida (medida con cinta, la barra de escala de la imagen o el frente del lote) → metros por píxel.
- **Orientación:** norte arriba por defecto; flecha de norte girable; confirmación con la brújula en sitio.
- **Trazado:** polígono con la medida de cada lado, el área y los ángulos visibles; imán a 90°.
- **Precisión esperada:** ±2–5 % (depende de la línea de referencia y de que la imagen sea realmente cenital).
- **Vistas inclinadas** (3D, oblicuas): se rechazan con aviso, porque deforman las medidas.
- Funciona **sin conexión**.
- La app es una herramienta genérica para **medir sobre una imagen**. En la tienda se anuncia como "importa cualquier imagen aérea"; **no se nombra a Google** ni a ningún proveedor.
- Futuro: lectura automática (OCR) de la barra de escala.

### Capa 1 — Contorno automático desde datos abiertos de edificios
- Fuentes: Google Open Buildings 2.5D (CC BY 4.0), Overture Maps y Microsoft Building Footprints (ODbL).
- Se preprocesan por zona en archivos estáticos alojados gratis y la app los descarga por zona.
- Se validan viabilidad, tamaño y hosting en F3. Atribución según la licencia de cada fuente; las de ODbL siguen las reglas de `docs/fuentes-de-datos.md` §6.
- Overpass (OSM) queda como `BuildingSource` de desarrollo; su opción comercial se decide en F7 (ADR-004).

### Capa 2 — Esri World Imagery: solo ver y ajustar
- Vista en línea para ubicarse y ajustar visualmente; **sin caché sin conexión** y **sin guardar geometría derivada de Esri** hasta que Esri responda por escrito ([`docs/legal/consulta-esri.md`](../legal/consulta-esri.md)).
- Atribución "Powered by Esri" + proveedores, visible y sin tapar.

### Capa 3 — Modo Pro opcional: Google Solar API con la clave del instalador (BYO key)
- Cada instalador usa **su propia** API key (su cuenta, su tarjeta y su aceptación de los términos de Google). La app nunca trae una clave de Google.
- Free tier informado por el dueño: 10 000 consultas Building Insights y 1 000 Data Layers al mes. ⚠️ Cifras y **términos de caché/almacenamiento** se verifican en F3 antes de implementar.

### Capa 4 — En sitio
- Inclinómetro y brújula del teléfono, ARCore (medición con cámara), foto de dron en el momento, o **modo sin imagen** (medidas con cinta). Siempre disponible.

### Futuro
- LiDAR abierto por país (p. ej. PNOA-LiDAR, AHN, USGS 3DEP) para alturas e inclinaciones automáticas.

## Consecuencias
- F3 empieza por la capa 0 + capa 4 (modo sin imagen); luego capa 1, capa 2 y capa 3, en ese orden.
- `geo_kit` necesita: calibración por dos puntos (metros por píxel + rotación), cálculo de longitudes, áreas y ángulos de polígonos, e imán a 90°. Cada fórmula con ficha en `docs/formulas/` y prueba.
- Prueba de aceptación de F3: medir un techo conocido con la capa 0 y quedar dentro de ±5 %.
- Riesgo a vigilar: en la capa 0 el usuario es responsable de tener derecho a usar la imagen que importa (las capturas de algunos proveedores de mapas tienen restricciones en sus términos). La app lo indica en un aviso breve al importar y no menciona ni integra a ningún proveedor.
