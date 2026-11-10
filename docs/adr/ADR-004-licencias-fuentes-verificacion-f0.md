# ADR-004 — Resultado de la verificación de licencias en F0

- Estado: **propuesto — requiere aprobación del dueño** (2026-11-10)
- Contexto: el plan (B.4, B.9) dejó para F0 verificar (1) si la cuenta gratuita de ArcGIS Location Platform pide tarjeta y si sus términos permiten digitalizar techos sobre World Imagery, (2) si el scope `drive.appdata` es no restringido, y (3) los términos de NASA POWER, PVGIS, Overpass y Nominatim. Detalle y fuentes en [`docs/fuentes-de-datos.md`](../fuentes-de-datos.md).
- Limitación: desde el entorno de desarrollo no se pudieron abrir las páginas oficiales (red bloqueada); se usaron resultados de búsqueda que citan esas páginas. Lo marcado "por confirmar" debe revisarse en un navegador antes de F3/F6.

## Hallazgos que cambian el plan

1. **Esri World Imagery — riesgo alto para trazar techos en una app comercial.** Un artículo oficial de Esri (Living Atlas) dice que los datos *derivados* de World Imagery, "incluidos derivados vectoriales", son "estrictamente para uso no comercial dentro de ArcGIS". El permiso para "trazar entidades" que circula en foros se anunció para edición de OpenStreetMap sin fines de lucro. Además, la capa no es para exportar teselas sin conexión (Esri ofrece otra capa "for Export"). Sobre la tarjeta: crear la cuenta parece no pedirla, pero **sí se pide un método de pago para seguir usando los servicios después de la cuota gratuita**; sin él, el servicio se detiene (no cobra).
2. **Nominatim y Overpass públicos — los límites cuentan por aplicación, no por usuario.** Nominatim: máximo 1 petición/s sumando a *todos* los usuarios de la app, con User-Agent propio. Overpass: guía de < 10 000 consultas/día por aplicación (y dividir entre 100 si el uso es regular). Sirven para el MVP y pruebas, no para miles de instaladores.

## Decisión propuesta

- **Imagen (B.4):** no depender de Esri como proveedor principal *para trazar* hasta tener confirmación escrita de Esri (correo a soporte/ventas o términos E300 vigentes que lo permitan para apps no-ArcGIS). Mientras tanto el orden queda: (1) ortofotos abiertas nacionales (PNOA, IGN, PDOK, NAIP, INEGI donde exista), (2) foto de dron/propia, (3) modo sin imagen, (4) Esri solo como **vista de referencia** (sin guardar geometría derivada) o con *BYO key* bajo los términos que acepte cada instalador. La interfaz `ImageryProvider` ya prevista permite cambiarlo sin reescribir.
- **Geocodificación:** interfaz `Geocoder` intercambiable; Nominatim público solo con caché local, 1 petición/s, User-Agent `Panelsolar/<versión>`, sin autocompletar. Antes de publicar (F7): evaluar Photon u otro servicio con cuota por usuario, o "BYO endpoint".
- **Huellas OSM (Overpass):** una consulta por proyecto, con caché; atribución "© Colaboradores de OpenStreetMap" (ODbL). Antes de F7 evaluar instancia alternativa si el volumen crece.
- **Clima:** sin cambios. NASA POWER (dominio público, uso comercial con reconocimiento) y PVGIS (30 llamadas/s por IP, atribución JRC).
- **Drive:** sin cambios (`drive.appdata`), con verificación final en la consola de Google Cloud al configurar F6 (la consola muestra si el scope es sensible/restringido).

## Consecuencias

- F3 debe empezar por ortofotos abiertas + dron + modo sin imagen; Esri pasa a "opcional" hasta resolver la duda legal.
- Si el dueño prefiere mantener Esri como prioridad 1, la acción es escribir a Esri con el caso de uso concreto ("app móvil comercial, el usuario dibuja el contorno del techo sobre World Imagery y guardamos el polígono") y archivar la respuesta en `docs/legal/`.
