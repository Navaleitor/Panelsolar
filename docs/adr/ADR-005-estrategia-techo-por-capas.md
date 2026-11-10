# ADR-005 — Techo: solo imágenes que importa el usuario

- Estado: **aceptado** por el dueño (2026-11-10). Reemplaza la versión anterior de este ADR, que proponía capas con Esri, Google Solar API y huellas abiertas de edificios.
- Contexto: [ADR-004](ADR-004-licencias-fuentes-verificacion-f0.md) mostró que trazar y guardar techos sobre imagen de terceros implica temas legales. El dueño decidió no meterse en eso: **la app no obtiene, descarga ni muestra imágenes ni geometría de ningún proveedor.**

## Decisión
1. **Imagen del usuario + calibración (método principal).**
   - El usuario consigue e importa su imagen cenital: una captura, una foto aérea o de dron, o un plano.
   - Al importar se muestra un aviso breve: "Usa solo imágenes que tengas derecho a usar". Ni la app ni la tienda nombran a ningún proveedor.
   - **Calibración:** se traza una línea de longitud conocida (cinta, barra de escala o frente del lote) para obtener metros por píxel.
   - **Orientación:** norte arriba por defecto, flecha girable y confirmación con la brújula en sitio.
   - **Trazado:** polígonos con la medida de cada lado, el área y los ángulos; imán a 90°; planos del techo, obstáculos y pasillos.
   - Precisión esperada: ±2–5 %. Las vistas inclinadas o 3D se rechazan con aviso.
   - Funciona sin conexión. A futuro: OCR de la barra de escala.
2. **Medición en sitio:** inclinómetro y brújula del teléfono, y medición con cámara (ARCore).
3. **Modo sin imagen:** se capturan las medidas con cinta y se dibuja el croquis a escala.

La ubicación (GPS, dirección o enlace de mapa) solo da latitud y longitud para el clima y la posición del sol; no hay mapa satelital en la app. El clima (NASA POWER y PVGIS) sigue descargándose porque son datos numéricos abiertos, no imágenes.

## Descartado
Esri World Imagery, Google Solar API (también en modo BYO key), huellas abiertas de edificios (Open Buildings, Overture, Microsoft) y Overpass para huellas.

## Consecuencias
- No hay interfaces `ImageryProvider` ni `BuildingSource` contra servicios externos; solo existe la fuente "imagen local".
- `geo_kit` necesita: calibración por dos puntos (metros por píxel + rotación), longitudes, áreas y ángulos de polígonos, e imán a 90°. Cada fórmula lleva ficha en `docs/formulas/` y prueba.
- Prueba de aceptación de F3: medir un techo conocido y quedar dentro de ±5 %.
