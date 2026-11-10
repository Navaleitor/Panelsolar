# Consulta a Esri — trazar techos sobre World Imagery

Estado: **borrador, sin enviar**. Lo envía el dueño desde su cuenta de ArcGIS Location Platform. Archiva la respuesta en este directorio (`docs/legal/respuesta-esri-AAAA-MM-DD.md` o PDF) y actualiza [ADR-005](../adr/ADR-005-estrategia-techo-por-capas.md), capa 2.

**A dónde enviarlo:** soporte de Esri desde la cuenta (my.esri.com → Support → Request case, categoría "Licensing / Terms of Use"), o el formulario de contacto de ventas de ArcGIS Location Platform. Pide que la respuesta venga **por escrito**.

---

## Versión en inglés (para enviar)

**Subject:** Terms of use question — saving user-traced roof outlines over World Imagery in a commercial mobile app (ArcGIS Location Platform)

Hello,

I am developing **Panelsolar**, a commercial mobile app (Android first, iOS later) for solar photovoltaic installers. I plan to use an **ArcGIS Location Platform** account and API key to display the **World Imagery** basemap inside the app, rendered with the open-source library **flutter_map** (not an ArcGIS Maps SDK). The app will be sold to installers (one-time purchase / freemium) worldwide.

**Intended use, step by step:**
1. The installer opens a customer's address and sees the World Imagery basemap, with "Powered by Esri" and the data provider attribution always visible.
2. The installer **manually** draws the outline of the customer's roof (a polygon of typically 4–20 vertices) on top of the imagery. No automated feature extraction, AI, or bulk processing is involved.
3. The app **stores that polygon** (vertex coordinates converted to local metres) on the installer's device, as part of that single customer project. It is used to calculate how many solar panels fit and the expected energy production.
4. The polygon (not the imagery) appears in a PDF report that the installer gives to **that one customer**. Optionally, a static image of the map with attribution is included in the report.
5. We do **not** cache imagery for offline use, export tiles, resell or publish the polygons, or build a database of buildings. Each polygon belongs to one private project.

**Questions:**
1. Under the current Product-Specific Terms of Use (E300) and the Master Agreement (E204), is step 3 — storing a polygon that the end user traced manually over World Imagery — permitted in a commercial app that uses ArcGIS Location Platform with a non-ArcGIS rendering library?
2. If it is permitted, are there conditions (attribution in the report, retention limits, a specific license or plan)?
3. If it is not permitted, is there an Esri offering (plan, imagery product or license) that allows this use case, and what would it cost?
4. Is including a static map image with attribution in the customer's PDF report permitted as described in E204 §3.2(b)?

Thank you. A written answer would help us comply correctly with your terms.

Best regards,
[Owner's name]
[Company / developer name]
[ArcGIS Location Platform account username]
[Contact email]

---

## Versión en español (para que el dueño sepa qué envía)

**Asunto:** Pregunta sobre términos de uso — guardar contornos de techo trazados por el usuario sobre World Imagery en una app móvil comercial (ArcGIS Location Platform)

Hola:

Estoy desarrollando **Panelsolar**, una app móvil comercial (primero Android, luego iOS) para instaladores de paneles solares. Quiero usar una cuenta de **ArcGIS Location Platform** con su API key para mostrar el mapa base **World Imagery** dentro de la app, dibujado con la librería de código abierto **flutter_map** (no con un SDK de ArcGIS). La app se venderá a instaladores (pago único / freemium) en todo el mundo.

**Uso previsto, paso a paso:**
1. El instalador abre la dirección de su cliente y ve el mapa World Imagery, con "Powered by Esri" y los proveedores de datos siempre visibles.
2. El instalador dibuja **a mano** el contorno del techo del cliente (un polígono de 4 a 20 vértices, normalmente) sobre la imagen. No hay extracción automática, inteligencia artificial ni procesamiento masivo.
3. La app **guarda ese polígono** (coordenadas de los vértices pasadas a metros locales) en el teléfono del instalador, dentro del proyecto de ese único cliente. Sirve para calcular cuántos paneles caben y cuánta energía producirán.
4. El polígono (no la imagen) aparece en un reporte PDF que el instalador entrega **a ese cliente**. Opcionalmente se incluye una imagen estática del mapa con atribución.
5. **No** guardamos imagen para usarla sin conexión, no exportamos teselas, no revendemos ni publicamos los polígonos y no armamos una base de datos de edificios. Cada polígono pertenece a un proyecto privado.

**Preguntas:**
1. Según los Términos de Producto vigentes (E300) y el Master Agreement (E204), ¿está permitido el paso 3 (guardar un polígono que el usuario trazó a mano sobre World Imagery) en una app comercial que usa ArcGIS Location Platform con una librería de mapas que no es de ArcGIS?
2. Si está permitido, ¿hay condiciones (atribución en el reporte, límites de tiempo de guardado, un plan o licencia específico)?
3. Si no está permitido, ¿hay algún producto de Esri (plan, imagen o licencia) que permita este caso de uso, y cuánto costaría?
4. ¿Está permitido incluir en el PDF del cliente una imagen estática del mapa con atribución, como describe E204 §3.2(b)?

Gracias. Una respuesta por escrito nos ayudaría a cumplir correctamente sus términos.

Saludos,
[Nombre del dueño] · [Empresa o nombre de desarrollador] · [Usuario de la cuenta ArcGIS Location Platform] · [Correo]
