# Aceptación — Fase F0 (Cimientos)

Lista para el dueño. Marca cada casilla en tu teléfono Android (8.0 o superior). Si algo falla, abre un *issue* con la plantilla **Error (bug)** y pon el número de la ejecución de GitHub Actions.

## 1. Descargar e instalar el APK
1. En el teléfono abre este **enlace fijo** (siempre baja la versión más reciente):
   **https://github.com/Navaleitor/Panelsolar/releases/latest/download/panelsolar.apk**
   Si te pide iniciar sesión en GitHub, hazlo: el repositorio es tuyo.
2. Abre el archivo `panelsolar.apk` descargado. Android pedirá permitir "instalar apps de origen desconocido" para tu navegador: acéptalo.
3. **Solo la primera vez:** si tenías una versión anterior instalada desde un .zip de Actions, desinstálala antes, porque cambió la llave de firma. De aquí en adelante cada versión nueva se instala encima y **conserva tus datos**.
4. Es una versión de prueba (*debug*): es normal que pese ~100 MB y que arranque un poco lento. El número de versión (0.1.N) aparece en la página de Releases del repositorio.

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

Firma / fecha: ____________________
