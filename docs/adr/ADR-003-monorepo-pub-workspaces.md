# ADR-003 — Monorepo con Dart pub workspaces (sin melos)

- Estado: aceptado (2026-11-10, F0)
- Contexto: el plan (B.2) pide un monorepo con `app/` y 5 paquetes en `packages/`. Hay dos opciones habituales: **melos** (herramienta externa) o **pub workspaces** (integrado en Dart ≥ 3.6).
- Decisión: **pub workspaces**. El `pubspec.yaml` de la raíz lista los paquetes en `workspace:` y cada paquete declara `resolution: workspace`.
  - Un solo `flutter pub get` en la raíz resuelve todo y genera **un solo** `pubspec.lock` (versiones idénticas en todos los paquetes).
  - Los scripts que melos daría (analizar/probar todo) viven en `.github/workflows/ci.yml` como bucles de shell de pocas líneas.
- Por qué no melos: es una herramienta más que instalar y mantener; desde melos 7 se apoya en pub workspaces de todos modos. Para 6 paquetes no aporta lo suficiente.
- Consecuencias:
  - Todos los paquetes comparten restricciones de versión: si un paquete Dart puro pide `test` muy nuevo, choca con el `test_api` fijado por `flutter_test`. Regla: subir versiones de herramientas de prueba solo cuando Flutter estable lo permita.
  - Versión de Flutter fijada en CI: **3.47.9** (Dart 3.13.7). Para actualizarla: cambiar `FLUTTER_VERSION` en `ci.yml`, correr CI y anotar aquí.
  - Si en el futuro hay muchos paquetes o publicación a pub.dev, se puede añadir melos encima sin reestructurar.
