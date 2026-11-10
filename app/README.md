# app — aplicación Flutter

Solo UI y orquestación. Los cálculos viven en `packages/`.

## Estructura
```
lib/
├── main.dart              # arranque: ProviderScope + PanelsolarApp
├── app.dart               # MaterialApp.router: tema, idiomas, rutas
├── core/
│   ├── database/          # providers de la base (AppDatabase de packages/persistence)
│   ├── l10n/arb/          # textos es/en (EDITAR AQUÍ)
│   ├── l10n/gen/          # código generado por gen-l10n (no editar)
│   ├── router/            # go_router: rutas y barra inferior (AppShell)
│   ├── theme/             # tema Material 3 claro/oscuro de alto contraste
│   └── widgets/           # widgets compartidos (EmptyModuleView)
└── features/<modulo>/{data,domain,presentation}/ + README.md
```
Módulos actuales: `clients`, `projects`, `catalog`, `maintenance`, `settings`. Plantilla de README: `docs/plantillas/README-feature.md`.

## Textos (es/en)
1. Agrega la clave en `lib/core/l10n/arb/app_es.arb` (plantilla) **y** en `app_en.arb`.
2. `flutter pub get` (o cualquier `flutter run/test`) regenera `lib/core/l10n/gen/`.
3. Úsala con `AppLocalizations.of(context).<clave>`.

## Navegación
`core/router/app_router.dart`: un `StatefulShellRoute` con una rama por pestaña. Para una pantalla nueva dentro de un módulo, agrega un `GoRoute` hijo en la rama del módulo.

## Android
`applicationId` = `com.panelsolar.app`, `minSdk` = 26 (Android 8.0). Ver `android/app/build.gradle.kts`.

## Cómo probar
```bash
flutter pub get        # en la raíz del repo (workspace)
cd app
flutter analyze
flutter test
flutter build apk --debug   # requiere Android SDK; CI lo hace siempre
```
