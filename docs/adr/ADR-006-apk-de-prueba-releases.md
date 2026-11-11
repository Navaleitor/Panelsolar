# ADR-006 — APK de prueba vía Releases con llave debug fija

- Estado: **aceptado** por el dueño (2026-11-10)
- Contexto: el dueño prueba la app instalando el APK en su Android. Bajarlo desde GitHub Actions obligaba a buscar la ejecución, descargar un .zip y descomprimirlo. Además, cada ejecución de CI firmaba con una llave debug aleatoria, así que Android no dejaba instalar una versión encima de otra ("App no instalada") y había que desinstalar, perdiendo los datos.

## Decisión
1. **Llave debug fija** en `app/android/keystore/panelsolar-debug.jks` (PKCS12, alias `androiddebugkey`, contraseñas `android`), versionada en el repo y usada por `signingConfigs.debug` en `app/android/app/build.gradle.kts`. Es una llave de pruebas sin valor secreto. **No se cambia.**
2. **Versión automática** en CI: `--build-number=<run_number>` y `--build-name=0.1.<run_number>`. Cada APK es más nuevo que el anterior.
3. **Release automática** (job `release-apk` en `.github/workflows/ci.yml`):
   - Solo corre en push a la rama base `ccr-4f7d63d4-px61ld` y con CI en verde.
   - Publica `panelsolar.apk` en la Release `build-<run_number>`, marcada como *latest*.
   - Conserva las últimas 10 releases de prueba.
   - Las ramas de fase siguen dejando su APK como artefacto en Actions.
4. **Enlace fijo:** `https://github.com/Navaleitor/Panelsolar/releases/latest/download/panelsolar.apk`.

## Consecuencias
- Las versiones se instalan una encima de otra y conservan los datos del dueño.
- Si el repositorio es privado, el enlace pide iniciar sesión en GitHub.
- Para Google Play (F7) se crea una llave de subida distinta, guardada en GitHub Secrets; esta llave debug nunca se sube a Play.
