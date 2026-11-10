# Aceptación — Fase F0 (Cimientos)

Lista para el dueño. Marca cada casilla en tu teléfono Android (8.0 o superior). Si algo falla, abre un *issue* con la plantilla **Error (bug)** y pon el número de la ejecución de GitHub Actions.

## 1. Descargar e instalar el APK
1. En GitHub abre el repositorio → pestaña **Actions** → flujo **CI**.
2. Entra a la ejecución más reciente de la rama `fase-0-cimientos` (o de `main` tras integrar) con marca verde ✅.
3. Abajo, en **Artifacts**, descarga `panelsolar-debug-<código>` (es un .zip). Ábrelo: dentro está `app-debug.apk`.
4. Pásalo al teléfono (correo, Drive, cable) y ábrelo. Android pedirá permitir "instalar apps de origen desconocido" para esa app: acéptalo.
5. Es una versión *debug*: es normal que pese ~100 MB y que arranque un poco lento.

- [ ] La app se instala y aparece como **Panelsolar**.

## 2. Qué revisar
- [ ] Abre directo en **Clientes**, con una barra inferior de 5 pestañas: Clientes, Proyectos, Catálogo, Mantenimiento, Ajustes.
- [ ] Cada pestaña abre su pantalla con título, ícono, una descripción y el aviso "Disponible en la fase F…".
- [ ] **Ajustes** muestra la tarjeta **Base de datos: Funcionando · esquema v2**. (Si dice "Error al abrir la base de datos", repórtalo.)
- [ ] Cierra la app por completo y ábrela otra vez: sigue diciendo "Funcionando · esquema v2".
- [ ] **Idioma:** cambia el idioma del teléfono a inglés (Ajustes de Android → Idioma). Al volver a la app los textos están en inglés (Clients, Projects, Catalog, Maintenance, Settings). Regresa a español.
- [ ] **Tema oscuro:** activa el modo oscuro del teléfono. La app cambia a fondo oscuro y todo se lee bien.
- [ ] **Exteriores:** al sol, los textos y la barra inferior se leen con claridad y los botones son fáciles de tocar.

## 3. Revisión del repositorio (opcional, en GitHub)
- [ ] La ejecución de **CI** está en verde (formato, análisis, pruebas y APK).
- [ ] Existen las plantillas al abrir un *issue* nuevo: "Error (bug)" y "Mejora".

## 4. Decisiones (resueltas el 2026-11-10)
- [x] ADR-004 aceptado: geocodificación y Overpass públicos detrás de interfaces; solución comercial en F7.
- [x] ADR-005 aceptado: techo por capas, con la imagen importada y calibrada como principal.
- [ ] Enviar la consulta a Esri (`docs/legal/consulta-esri.md`) y guardar la respuesta en `docs/legal/`.

Firma / fecha: ____________________
