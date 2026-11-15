# Guía: activar el respaldo en Google Drive (lo hace el dueño, una vez)

El respaldo en **.zip funciona sin esto**. Esta guía solo hace falta para el botón *Respaldar en Google Drive* de Ajustes. Mientras no se haga, la app muestra "Falta configurar la cuenta de Google de la app".

Tiempo: unos 20 minutos. Costo: gratis. Necesitas tu cuenta de Google (la misma de Play Console es buena idea).

## Qué vamos a crear
1. Un **proyecto** en Google Cloud con la **API de Google Drive** activada.
2. La **pantalla de consentimiento** (lo que ve el usuario al iniciar sesión).
3. Dos **IDs de cliente OAuth**: uno *Android* (amarra la app a su firma) y uno *Web* (Android lo pide para el inicio de sesión).

La app solo pide el permiso `drive.appdata`: una carpeta **oculta y privada** de la app dentro del Drive del usuario. No ve sus otros archivos. Es un permiso **no restringido** (no requiere la auditoría de seguridad pagada de Google; ver ADR-004).

## Paso 1. Proyecto y API
1. Entra a <https://console.cloud.google.com> e inicia sesión.
2. Arriba, en el selector de proyectos → **Proyecto nuevo** → nombre `Panelsolar` → **Crear**. Asegúrate de que quede seleccionado.
3. Menú ☰ → **APIs y servicios → Biblioteca** → busca **Google Drive API** → **Habilitar**.

## Paso 2. Pantalla de consentimiento
1. Menú ☰ → **APIs y servicios → Pantalla de consentimiento de OAuth** (en algunas cuentas aparece como **Google Auth Platform**) → **Comenzar**.
2. *Información de la app*: nombre `Panelsolar`, correo de asistencia: el tuyo.
3. *Público*: **Externo**.
4. *Información de contacto*: tu correo → acepta las políticas → **Crear**.
5. En **Acceso a los datos** (o *Permisos*) → **Agregar o quitar permisos** → busca `drive.appdata` (".../auth/drive.appdata — Ver y administrar sus propios datos de configuración en tu Google Drive") → márcalo → **Actualizar** → **Guardar**.
6. En **Público** → **Usuarios de prueba** → **Agregar usuarios** → tu correo de Gmail (y el de quien vaya a probar). Mientras la app esté "En prueba", solo esos correos pueden iniciar sesión.

## Paso 3. ID de cliente Android
1. Menú ☰ → **APIs y servicios → Credenciales** (o *Clientes*) → **Crear credenciales → ID de cliente de OAuth**.
2. Tipo: **Android**. Nombre: `Panelsolar Android (pruebas)`.
3. Nombre del paquete: `com.panelsolar.app`
4. Huella SHA-1 (de la llave de pruebas fija, ADR-006):
   ```
   C6:08:46:AE:2B:FD:6C:64:78:A1:0C:E8:C4:55:CF:3D:89:83:DC:06
   ```
5. **Crear**. No hay que copiar nada de este.

## Paso 4. ID de cliente Web (el que necesita la app)
1. Otra vez **Crear credenciales → ID de cliente de OAuth**.
2. Tipo: **Aplicación web**. Nombre: `Panelsolar servidor`. No llenes URIs.
3. **Crear** → copia el **ID de cliente** (termina en `.apps.googleusercontent.com`). **No** hace falta el "secreto".
4. Pégalo en el chat de Claude: "Este es el ID web de Google para el respaldo: ...". Claude lo pone en `app/lib/features/backup/data/drive/drive_auth.dart` (`googleServerClientId`). No es un dato secreto: es seguro guardarlo en el repositorio.

## Paso 5. Probar
1. Instala el APK nuevo.
2. Ajustes → **Respaldar en Google Drive** → elige tu cuenta → acepta el permiso.
3. **Respaldar ahora** → en "Últimos respaldos" debe aparecer *Google Drive · Manual* con ✓.
4. Para probar la restauración: en otro teléfono (o tras desinstalar), Ajustes → **Restaurar desde Google Drive**.

En tu Drive web no verás carpeta nueva (es oculta). Puedes verla en drive.google.com → ⚙ Configuración → **Administrar apps** → Panelsolar ("datos ocultos de la app").

## Cuando se publique en Google Play (F7)
- Play firma la app con **otra llave**. En Play Console → *Integridad de la app* → copia el **SHA-1 de la llave de firma de apps** y crea **otro** ID de cliente Android con ese SHA-1 (mismo paquete).
- En la pantalla de consentimiento → **Publicar app** (pasar de "En prueba" a "En producción") para que cualquier usuario pueda entrar. Con solo `drive.appdata` Google normalmente pide verificar la marca (nombre, logo, política de privacidad), no una auditoría de seguridad.

## Si algo falla
| Mensaje / síntoma | Causa probable |
|---|---|
| "Falta configurar la cuenta de Google de la app" | Falta el paso 4 (ID web en el código). |
| Al elegir cuenta vuelve sin hacer nada / error 10 (DEVELOPER_ERROR) | SHA-1 o paquete mal escritos en el paso 3. |
| "Acceso bloqueado: la app no completó la verificación" | Tu correo no está en *Usuarios de prueba* (paso 2.6). |
| El respaldo diario no aparece | Solo corre con Wi-Fi y batería suficiente, una vez al día; Android puede retrasarlo. Usa "Respaldar ahora" para probar. |
