# Aceptación — Fase F1 (Clientes y proyectos)

Lista para el dueño. Marca cada casilla en tu teléfono Android (8.0 o superior). Si algo falla, abre un *issue* con la plantilla **Error (bug)**: qué hiciste, qué pasó, qué esperabas y una captura.

## 0. Instalar el APK
1. GitHub → **Actions** → flujo **CI** → ejecución más reciente de la rama `fase-1-clientes` con ✅.
2. En **Artifacts** descarga `panelsolar-debug-<código>` (.zip) y dentro está `app-debug.apk`.
3. Instálalo encima de la versión de F0 (**sin desinstalar**: así se prueba la migración de la base de datos).

- [ ] La app abre sin errores.
- [ ] **Ajustes** dice **Funcionando · esquema v3**. (Si venías de F0 decía v2: la base se actualizó sola.)

## 1. Clientes
- [ ] La pestaña **Clientes** dice "Aún no hay clientes".
- [ ] **Nuevo cliente** → intenta guardar vacío: pide el nombre. Escribe un correo sin "@": avisa "Correo no válido".
- [ ] Da de alta 3 clientes con nombre, teléfono, correo y dirección. Al guardar se abre la ficha.
- [ ] En la lista aparecen en orden alfabético. El buscador filtra por nombre, por parte del teléfono, por correo y por colonia/calle.
- [ ] En la ficha, mantén presionado el teléfono: dice "Copiado".
- [ ] **Editar** (lápiz) cambia el nombre y se ve al volver.
- [ ] Menú ⋮ → **Borrar** pide confirmación; el cliente desaparece de la lista y sus proyectos de la pestaña Proyectos.

## 2. Proyectos
- [ ] En la ficha de un cliente → Proyectos → **Agregar**: crea "Casa" con fecha de hoy. Se abre la ficha del proyecto con estado **Prospecto**.
- [ ] Crea un segundo proyecto para el mismo cliente: la ficha del cliente muestra los dos.
- [ ] Botón **Pasar a «Diseño»** cambia el estado; repítelo hasta **Mantenimiento** (el botón desaparece).
- [ ] **Editar**: cambia nombre, estado y fecha.
- [ ] Pestaña **Proyectos**: aparecen todos con su cliente, del más reciente al más antiguo. Los filtros por estado y el buscador funcionan.
- [ ] **Nuevo proyecto** desde la pestaña pide elegir cliente.

## 3. Ubicación (solo coordenadas, sin mapa)
En la ficha del proyecto → **Ubicación** → **Agregar**.
- [ ] **GPS** (afuera, con la ubicación del teléfono encendida): pide permiso la primera vez; muestra coordenadas, precisión (±m) y altitud. Con la ubicación apagada, avisa que la actives.
- [ ] **Buscar dirección**: escribe una dirección real con ciudad → **Buscar** → elige un resultado. Se ve "© OpenStreetMap contributors".
- [ ] **Pegar enlace** de **Google Maps**: en Google Maps toca un lugar → Compartir → Copiar → en la app, botón pegar → Continuar. (Es un enlace corto `maps.app.goo.gl`, necesita internet.)
- [ ] **Pegar enlace** de **Apple Maps** (si tienes un iPhone a la mano, compártelo por WhatsApp/correo).
- [ ] Pega un texto sin coordenadas: avisa "No se encontraron coordenadas".
- [ ] **Escribir coordenadas**: `25.6866, -100.3161` y también `25°41'11.8"N 100°18'58.0"W`.
- [ ] La pantalla de confirmación muestra las coordenadas en decimal y en grados/minutos/segundos. Copia las coordenadas y compruébalas en tu app de mapas: es el lugar correcto.
- [ ] La zona horaria viene llena con la del teléfono (p. ej. America/Monterrey). Escribe una inventada: no deja guardar.
- [ ] **Sí, guardar ubicación**: la ficha del proyecto muestra las coordenadas. **Cambiar** permite reemplazarlas.

## 4. Fotos
En la ficha del proyecto → Fotos → **Abrir**.
- [ ] Pestañas **Levantamiento / Instalación / Mantenimiento**.
- [ ] **Agregar foto → Tomar con la cámara**: la foto aparece en la pestaña visible.
- [ ] **Elegir de la galería** varias fotos a la vez: se agregan todas; si repites una, el aviso dice "1 repetida".
- [ ] Toca una foto: se ve completa, con zoom de dos dedos, tamaño ≈ 1600 px de lado mayor, fecha y coordenadas (o "Sin ubicación GPS").
- [ ] Escribe una **descripción**; **Borrar** la quita de la etapa.
- [ ] El resumen de la ficha del proyecto cuenta las fotos por etapa.

## 5. Documentos
- [ ] Ficha del proyecto → Documentos → **Agregar**: elige un **PDF**. Aparece con su nombre y tamaño.
- [ ] Agrega una **imagen** (JPG/PNG).
- [ ] Intenta agregar otro tipo (p. ej. .docx): avisa que solo se aceptan PDF o imágenes.
- [ ] Tocar un documento lo abre con el visor del teléfono.
- [ ] Menú ⋮ → **Renombrar** y **Borrar**.

## 6. Recibos de luz
En la ficha del cliente → Recibos de luz → **Agregar**.
- [ ] Elige tarifa **1C**: el periodo cambia a **Bimestral**; las fechas proponen 2 meses.
- [ ] Captura kWh e importe (acepta `1,540.50`). Guarda.
- [ ] El siguiente recibo propone empezar el día después del anterior y con la misma tarifa.
- [ ] Captura **6 recibos bimestrales** (un año): aparece **Consumo anual estimado**, promedio mensual y diario, gasto anual y la **gráfica** de barras con la línea punteada del promedio.
- [ ] Con menos de un año avisa que el anual es una estimación.
- [ ] Con tarifa **1** y más de 250 kWh/mes de promedio aparece el aviso de **DAC**.
- [ ] Toca un recibo para editarlo o borrarlo (ícono de bote).
- [ ] Prueba también **PDBT**: propone periodo **Mensual**.

## 7. Generales
- [ ] Cambia el idioma del teléfono a inglés: todas las pantallas nuevas están en inglés.
- [ ] Modo oscuro: todo se lee bien.
- [ ] Modo avión: clientes, proyectos, fotos, documentos y recibos funcionan; solo "Buscar dirección" y los enlaces cortos avisan que no hay conexión.
- [ ] Cierra la app por completo y ábrela: todo sigue ahí.

## Decisiones pendientes (para el chat principal)
- Zona horaria: hoy se propone la del teléfono (editable). ¿Basta, o se quiere deducirla de las coordenadas sin conexión (agrega ~1–5 MB de datos)?
- Recibos: el importe se captura en MXN. ¿Hace falta otra moneda antes de F7?

Firma / fecha: ____________________
