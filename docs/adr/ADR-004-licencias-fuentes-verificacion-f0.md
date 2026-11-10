# ADR-004 — Resultado de la verificación de licencias en F0

- Estado: **aceptado** por el dueño (2026-11-10), con los ajustes de la sección "Decisión". La parte de imagen/techo la sustituye [ADR-005](ADR-005-estrategia-techo-por-capas.md).
- Contexto: el plan (B.4, B.9) dejó para F0 verificar (1) si la cuenta gratuita de ArcGIS Location Platform pide tarjeta y si sus términos permiten digitalizar techos sobre World Imagery, (2) si el scope `drive.appdata` es no restringido, y (3) los términos de NASA POWER, PVGIS, Overpass y Nominatim. Detalle, citas textuales y fuentes en [`docs/fuentes-de-datos.md`](../fuentes-de-datos.md).
- Verificación: primera pasada con buscadores; segunda pasada leyendo directamente las páginas y PDF oficiales (Esri E300 de 13-nov-2025 y Master Agreement E204 de 14-ago-2026, facturación y precios de Location Platform, tabla de scopes de Google, POWER Docs, JRC, wiki OSM, política de Nominatim, guía de atribución OSMF). Siguen sin poder leerse: el blog de Esri (403) y earthdata.nasa.gov (sin conexión).

## Hallazgos que cambian el plan

1. **Esri World Imagery — permitido mostrarla; trazar y guardar el techo sigue sin permiso escrito.**
   - Confirmado: la cuenta se crea **sin tarjeta** (solo nombre y correo); el pago por uso viene apagado; la cuota es de **2 000 000 teselas/mes**; al agotarla el servicio se corta sin cobrar.
   - Confirmado: los términos E300 permiten **apps comerciales** que usan Location Platform con API key (notas 16, 78 y 89), también con librerías no-ArcGIS, siempre con "Powered by Esri" + proveedores de datos.
   - Confirmado: se permite poner **imágenes estáticas** del mapa en reportes PDF para terceros, con atribución (E204 §3.2 b).
   - Confirmado: **prohibida la caché sin conexión** fuera de los SDK de ArcGIS (E204 §3.2 c; E300 nota 10).
   - **No confirmado:** ningún texto oficial permite expresamente guardar el polígono que el usuario traza. El polígono encaja como "Customer Content", pero E204 §3.3 b prohíbe usar los datos para "compilar o complementar" información que se entrega a terceros, y el artículo de Esri que limita los derivados vectoriales a "uso no comercial dentro de ArcGIS" no se pudo releer (403). **No se puede afirmar que Esri permita trazar en una app comercial.**
2. **Overpass público — no es para uso comercial.** La wiki de OSM dice: *"Commercial use should use self-hosted or paid Overpass servers."* Además los límites (< 10 000 consultas/día, ÷100 si es uso regular) suman a todos los usuarios de la app.
3. **Nominatim público — 1 petición/s sumando a todos los usuarios, y la app debe poder cambiar de servicio sin publicar una actualización.**
4. **Google `drive.appdata` — confirmado no sensible**; solo requiere verificación OAuth básica, sin CASA.
5. **PVGIS — versión vigente `v5_3`** (SARAH3, 2005–2023); licencia CC BY 4.0 de la Comisión.

## Decisión (aceptada)

- **Imagen y techo (B.4):** reemplazado por la estrategia por capas de [ADR-005](ADR-005-estrategia-techo-por-capas.md). Esri queda como capa 2: solo ver y ajustar, sin caché sin conexión ni geometría derivada de Esri; se le envía la consulta de [`docs/legal/consulta-esri.md`](../legal/consulta-esri.md).
- **Geocodificación:** interfaz `Geocoder` intercambiable con **URL configurable en remoto**; Nominatim público solo con caché local, 1 petición/s, User-Agent `Panelsolar/<versión>`, sin autocompletar. Se desarrolla con el servicio público; la solución comercial (servidor propio, de pago o BYO) **se decide en F7**.
- **Huellas OSM (Overpass):** una consulta por proyecto, con caché, User-Agent propio y pausa de 30 s ante 429/406; atribución "© OpenStreetMap contributors" (ODbL). Se desarrolla con el servidor público detrás de una interfaz intercambiable (`BuildingSource`, ADR-005); la solución comercial (servidor propio, de pago o BYO) **se decide en F7**, por la regla de uso comercial de Overpass.
- **Clima:** sin cambios. NASA POWER (texto oficial de referencia con versión y fecha; licencia de dominio público solo por fuente secundaria) y PVGIS `v5_3` (30 llamadas/s por IP, CC BY 4.0).
- **Drive:** sin cambios (`drive.appdata`, no sensible).

## Consecuencias
- F3 implementa el techo según ADR-005 (capa 0, imagen importada y calibrada, como principal).
- Geocodificación y huellas de edificios se acceden solo a través de interfaces (`Geocoder`, `BuildingSource`) para poder cambiar de servicio sin tocar las pantallas.
- F7 decide y presupuesta el servicio comercial de Overpass y geocodificación.
- Pendiente: respuesta de Esri a la consulta; se archiva en `docs/legal/`.
