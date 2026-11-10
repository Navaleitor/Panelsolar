# Fuentes de datos: licencias, límites y atribuciones

Verificación hecha en F0 (2026-11-10). Decisión derivada: [ADR-004](adr/ADR-004-licencias-fuentes-verificacion-f0.md).

> **Cómo se verificó.** Desde el entorno de desarrollo las páginas oficiales estaban bloqueadas por la red, así que se usaron buscadores que citan esas páginas. Columna "Estado": ✅ confirmado por fuente oficial citada · ⚠️ fuente secundaria o antigua, confirmar en navegador · ❓ sin confirmar.

## Resumen

| Fuente | Uso en la app | ¿Comercial? | Key | Límite | Atribución | Estado |
|---|---|---|---|---|---|---|
| Esri World Imagery (ArcGIS Location Platform) | Imagen satelital para trazar techo | ⚠️ Ver para mostrar; **trazar/derivar: dudoso** | Sí (API key) | Cuota mensual gratuita; al agotarla se detiene sin método de pago | "Esri, Maxar, Earthstar Geographics y la comunidad GIS" (texto exacto del servicio) | ⚠️ |
| NASA POWER | Serie horaria 5 años | Sí, con reconocimiento | No | Sin límite fijo publicado; NASA limita abusos | Reconocimiento NASA POWER (texto oficial) | ⚠️ |
| PVGIS (JRC) | TMY, horizonte, validación | Sí (reutilización de datos de la Comisión Europea) | No | 30 llamadas/s por IP (HTTP 429 al exceder) | "PVGIS © Unión Europea, 2001–<año>" | ✅ límite / ⚠️ licencia |
| Overpass API (OSM) | Huella del edificio | Sí (datos ODbL) | No | < 10 000 consultas/día y < 1 GB/día **por aplicación** | "© Colaboradores de OpenStreetMap" | ⚠️ |
| Nominatim (OSM) | Dirección → coordenadas | Sí (datos ODbL) | No | **1 petición/s por aplicación**, User-Agent propio, sin autocompletar | "© Colaboradores de OpenStreetMap" | ⚠️ |
| Google Drive (`drive.appdata`) | Respaldo | N/A | OAuth | Cuota del Drive del usuario | — | ❓ clase del scope |

## 1. Esri World Imagery / ArcGIS Location Platform

**Pregunta 1: ¿la cuenta gratuita pide tarjeta?**
- Una guía de terceros dice que la cuenta gratuita se crea sin tarjeta y que, al agotar la cuota, los servicios se desactivan si no se activa el pago por uso. Fuente: búsqueda; ver [Billing (Esri)](https://location.arcgis.com/help/billing/).
- La ayuda oficial de facturación dice que **se requiere un método de pago para activar pay-as-you-go y seguir usando servicios después de la capa gratuita**. [location.arcgis.com/help/billing](https://location.arcgis.com/help/billing/)
- Un blog más antiguo decía que hacía falta tarjeta. Conclusión: **probablemente no pide tarjeta para registrarse**, pero la cuota gratuita es un techo duro. ⚠️ No se confirmó la cifra de la cuota de teselas.

**Pregunta 2: ¿se pueden digitalizar techos sobre World Imagery en una app comercial?**
- Artículo oficial de Esri (Living Atlas): *"data and information derived from World Imagery layers, services, and tiles, including but not limited to vector and raster derivatives, are strictly for non-commercial use within ArcGIS"*. También: las capas no pueden usarse como entrada directa para extracción automática. [esri.com/arcgis-blog/...learn-to-use-ai-to-extract-information-from-world-imagery](https://www.esri.com/arcgis-blog/products/arcgis-living-atlas/imagery/learn-to-use-ai-to-extract-information-from-world-imagery)
- Permiso de trazado citado en la wiki de OSM: *"the non-exclusive right to use the World Imagery map to trace features and validate edits in the creation of vector data"*, anunciado para aplicaciones sin fines de lucro centradas en editar OpenStreetMap. [wiki.openstreetmap.org/wiki/Esri](https://wiki.openstreetmap.org/wiki/Esri)
- Teselas sin conexión: la capa *"is not intended to be used to export tiles for offline"*; existe "World Imagery (for Export)". [World Imagery – item](https://www.arcgis.com/home/item.html?id=974d45be315c4c87b2ac32be59af9a0b)
- Términos de producto vigentes: [E300 (13-nov-2025)](https://www.esri.com/content/dam/esrisites/en-us/media/legal/product-specific-terms-of-use/e300.pdf) — prohíbe uso programático de tokens para exportar volúmenes de teselas. ⚠️ No se pudo leer el texto completo.

**Conclusión:** riesgo alto. Mostrar la imagen en la app con atribución parece permitido; **guardar el polígono del techo trazado sobre ella en una app comercial no-ArcGIS no está claramente permitido**. Ver ADR-004.

## 2. NASA POWER
- Foro oficial de NASA Earthdata: los datos *"are public domain and free of any charges or fees. You may use them in your research, publications, and commercial applications with the request that you acknowledge usage"*. [forum.earthdata.nasa.gov](https://forum.earthdata.nasa.gov/viewtopic.php?p=15146) ⚠️ (publicación de foro, no página de términos)
- Límite: personal de NASA Langley indica que no hay límite fijo, pero monitorean y limitan para un acceso equitativo; en 2021 se citó 30 peticiones/min para climatología. [mismo hilo](https://forum.earthdata.nasa.gov/viewtopic.php?p=15146), [ropensci/nasapower#57](https://github.com/ropensci/nasapower/issues/57)
- Texto de reconocimiento: tomarlo de la página oficial de referencias de POWER en F2.
- Implementación: descarga una vez por proyecto, guardar comprimido, reintentos con espera.

## 3. PVGIS (Centro Común de Investigación, Comisión Europea)
- ✅ Límite: *"30 calls/second per IP address"*; al exceder responde 429. [JRC – API non-interactive service](https://joint-research-centre.ec.europa.eu/photovoltaic-geographical-information-system-pvgis/getting-started-pvgis/api-non-interactive-service_en)
- Las rutas son versionadas (`https://re.jrc.ec.europa.eu/api/v5_2/<herramienta>`); confirmar en F2 si existe `v5_3` y usar la más nueva.
- Licencia: la política de reutilización de la Comisión (Decisión 2011/833/UE) permite reutilizar con atribución. ⚠️ No confirmado en esta verificación.
- Como el límite es por IP y cada teléfono llama directo, no hay riesgo de cuota compartida.

## 4. Overpass API (huellas OpenStreetMap)
- Guía del wiki de OSM: *"you don't disturb other users when you do less than 10,000 queries per day and download less than 1 GB data per day"*; los límites *"should always be counted towards an application"*; para uso regular, *"divide those numbers by 100"*; enviar User-Agent o Referer que identifique la app. [wiki.openstreetmap.org/wiki/Overpass_API](https://wiki.openstreetmap.org/wiki/Overpass_API), [Overpass – commons](https://dev.overpass-api.de/overpass-doc/en/preface/commons.html) ⚠️
- Datos bajo ODbL: atribución "© OpenStreetMap contributors". Si la app guarda y redistribuye la huella modificada como base de datos, aplica *share-alike* sobre esa base; el reporte PDF es "obra producida" y solo pide atribución. ⚠️ Confirmar en [openstreetmap.org/copyright](https://www.openstreetmap.org/copyright).

## 5. Nominatim (geocodificación)
- Política: máximo 1 petición/s; User-Agent que identifique la app (los User-Agent genéricos de librerías se bloquean con 403); el límite **suma a todos los usuarios de la app**. [Nominatim usage policy](https://operations.osmfoundation.org/policies/nominatim/) (citada por foros de OSM) ⚠️
- Implicación: apta para el MVP con caché; para una app publicada con muchos usuarios hay que tener alternativa (Photon u otro servicio, o "BYO endpoint"). Prohibido autocompletar mientras se escribe.

## 6. Google Drive — scope `drive.appdata`
- Google recomienda usar el scope más específico y no sensible. [developers.google.com – api-specific-auth](https://developers.google.com/workspace/drive/api/guides/api-specific-auth), [OAuth 2.0 Scopes](https://developers.google.com/identity/protocols/oauth2/scopes)
- ❓ No se pudo leer la tabla oficial. Según conocimiento previo (no verificado hoy), `drive.appdata` y `drive.file` son **no restringidos** (no piden la auditoría anual CASA), mientras que `drive` y `drive.readonly` son restringidos.
- Verificación definitiva (F6, 5 minutos): en Google Cloud Console → "Pantalla de consentimiento OAuth" → agregar el scope; la consola indica si es no sensible, sensible o restringido.

## Atribuciones (para pantallas y reportes)
Se centralizarán en `packages/data_sources` (F2/F3) y se imprimirán en cada reporte PDF que use la fuente.
