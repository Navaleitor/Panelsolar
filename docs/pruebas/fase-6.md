# Aceptación — Fase F6 (Operación: instalación, mantenimiento, producción y respaldo)

Lista para el dueño. Marca cada casilla en tu teléfono Android (8.0 o superior). Si algo falla, abre un *issue* con la plantilla **Error (bug)**: qué hiciste, qué pasó, qué esperabas y una captura.

## 0. Instalar el APK
- **Tras integrar F6 en la rama base** (lo normal): abre el enlace fijo
  **https://github.com/Navaleitor/Panelsolar/releases/latest/download/panelsolar.apk**
  e instálalo **encima** de la versión anterior, sin desinstalar (así se prueba que la base se actualiza conservando tus datos).
- **Antes de integrar** (opcional): GitHub → **Actions** → **CI** → ejecución de la rama `fase-6-operacion` con ✅ → **Artifacts** → `panelsolar-debug-<código>`.

- [ ] La app abre sin errores y tus clientes y proyectos de antes siguen ahí.
- [ ] **Ajustes** → abajo, **Base de datos** dice **Funcionando · esquema v6**.
- [ ] Antes de seguir, haz un respaldo .zip (sección 4.1) y guárdalo: es tu red de seguridad.

## 1. Instalación y puesta en marcha
Abre un proyecto. En la ficha aparecen tres tarjetas nuevas: **Instalación**, **Mantenimiento** y **Producción**.
- [ ] **Instalación** → **Agregar** equipo: tipo *Inversor*, marca, modelo, número de serie y **Garantía hasta** (fecha). Al guardar se ve en la lista con "S/N …" y "Garantía hasta …".
- [ ] Intenta guardar un equipo sin marca: pide "Obligatorio".
- [ ] Pon a otro equipo una garantía ya vencida: muestra "Garantía vencida" y un ⚠.
- [ ] Toca un equipo → cámbialo → se actualiza. Ícono 🗑 lo borra (pide confirmación).
- [ ] **Puesta en marcha** → **Agregar** string: Voc esperado 400, medido 396; Isc esperado 10, medido 9.6; polaridad **Bien** → se ve ✓ verde y "(-1 %)".
- [ ] Agrega otro string con Voc medido 360 (−10 %): sale el ícono rojo.
- [ ] Llena aislamiento (p. ej. 40 MΩ a 1000 V), tierra y etiquetado → **Guardar**. Abajo dice "la app sugiere: …" (con el string malo: *Con observaciones*).
- [ ] Elige el **Resultado** (Pendiente / Aprobado / Con observaciones) → Guardar → al volver, la tarjeta de Instalación muestra ese estado.
- [ ] Ya guardado, **Fotos de evidencia** → Agregar → cámara: la foto aparece en miniatura y también en la galería del proyecto (etapa Instalación).

## 2. Mantenimiento
- [ ] Tarjeta **Mantenimiento** → "Este proyecto aún no tiene plan" → **Crear plan desde la plantilla**: aparecen 5 servicios (limpieza, inspección visual, apriete, inversor, protecciones) con "Cada N meses · Próxima: fecha".
- [ ] Toca un servicio → cambia la frecuencia o la próxima fecha → se actualiza. 🗑 lo borra.
- [ ] **Agregar** un servicio *Termografía* cada 24 meses.
- [ ] **Registrar visita**: fecha, técnico, marca los servicios hechos, notas → **Guardar** → se abre la visita → agrega 1–2 fotos.
- [ ] De regreso, en la **Bitácora** aparece la visita; los servicios marcados ahora tienen la próxima fecha recorrida.
- [ ] Pestaña **Mantenimiento** (barra inferior): calendario con *Vencidas*, *Próximos 30 días* y *Más adelante*. Tocar una fila abre el mantenimiento del proyecto.
- [ ] Ícono de la plantilla (arriba a la derecha) → cambia "Limpieza" a cada 3 meses, apaga o prende servicios; en un proyecto nuevo, el plan sale con esos cambios.
- [ ] **Recordatorios**: Ajustes → *Recordatorios de mantenimiento* encendido (Android 13+ pide permiso de notificaciones: acepta). Pon la próxima fecha de un servicio a **7 días** de hoy: al día siguiente a las 9:00 (aprox.) llega la notificación "Mantenimiento: …". *(Android puede retrasarla unos minutos.)*
- [ ] Apaga los recordatorios: ya no llegan.

## 3. Producción
- [ ] Tarjeta **Producción** → ⚙ (arriba): potencia **5** kWp, umbral **15** %.
- [ ] Si el proyecto tiene ubicación y kWp, al abrir **Agregar lectura** el campo *kWh esperados* ya trae un número "Propuesto por el motor solar" (requiere red la primera vez o haber abierto antes *Clima y producción*). Se puede cambiar.
- [ ] **Agregar lectura**: mes pasado, real 600, esperado 650, irradiación 150 → en la lista: "Esperado 650 kWh (-7.7 %) · PR 80 %".
- [ ] Otra lectura con real 450 y esperado 650 → aparece el aviso rojo "1 mes por debajo de lo esperado" y la barra de ese mes en rojo en la gráfica.
- [ ] La gráfica muestra barras **Real** junto a **Esperado** por mes.
- [ ] Tocar una lectura permite corregirla; 🗑 la borra.
- [ ] En la ficha del proyecto, la tarjeta de Producción muestra el último mes y "Bajo el umbral" si aplica.

## 4. Respaldo
### 4.1 Archivo .zip (sin Google)
- [ ] Ajustes → **Exportar a archivo .zip** → deja la contraseña vacía → **Continuar** → elige dónde guardarlo (Descargas o Drive) → "Respaldo guardado".
- [ ] Repite con contraseña (mínimo 6 caracteres, escrita dos veces). Si no coinciden, avisa.
- [ ] En "Últimos respaldos" aparece *.zip · Manual* con ✓.
- [ ] **Prueba fuerte (respaldar → borrar → restaurar)**: borra un cliente de prueba; luego **Restaurar desde archivo .zip** → elige el .zip con contraseña → la vista previa muestra fecha, versión y cuántos clientes/proyectos/fotos trae y "Cifrado: pide contraseña".
- [ ] Escribe una contraseña equivocada → **Restaurar** → confirma → "Contraseña incorrecta" (tus datos no cambian).
- [ ] Con la contraseña correcta → confirma → vuelve a Clientes y el cliente borrado **regresó**, con sus proyectos y fotos.
- [ ] Al terminar, el aviso dice que tus datos anteriores quedaron guardados. En Ajustes aparece **Deshacer la última restauración** → vista previa → Restaurar → vuelves a como estabas antes de restaurar (el cliente borrado desaparece otra vez).
- [ ] Un archivo que no es respaldo (cualquier otro .zip) → "no es un respaldo de Panelsolar".

### 4.2 Google Drive (solo después de la guía)
Primero sigue [`docs/guias/respaldo-google.md`](../guias/respaldo-google.md) y pásale a Claude el ID web. Hasta entonces, Ajustes muestra "Falta configurar la cuenta de Google de la app" (correcto).
- [ ] **Respaldar en Google Drive** → elige tu cuenta → acepta. Aparece tu correo.
- [ ] **Respaldar ahora** → "Respaldo en Drive listo (N archivos nuevos)". Repite: ahora "0 archivos nuevos" (solo sube fotos nuevas).
- [ ] **Contraseña del respaldo en Drive**: pon una → dice "Cifrado activado".
- [ ] Respaldo automático: deja **Diario** y el teléfono con Wi-Fi y cargado una noche → al día siguiente hay un registro *Google Drive · Automático* ✓.
- [ ] Pasa un proyecto a **Instalado** (botón "Pasar a…") → aparece *Google Drive · Proyecto finalizado* ✓.
- [ ] **Restaurar desde Google Drive** → elige el respaldo más reciente → vista previa → contraseña → restaura igual que el .zip.
- [ ] **Desconectar Google Drive** → pide confirmación y vuelve a mostrar "Respaldar en Google Drive".

## 5. Idioma
- [ ] Con el teléfono en inglés, las pantallas nuevas salen en inglés.

---
Firma del dueño: ______________________  Fecha: __________
