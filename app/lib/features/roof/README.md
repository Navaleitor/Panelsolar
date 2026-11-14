# Techo

Módulo "Techo" de la ficha del proyecto (F3, plan B.4, B.7 y B.7.1): el usuario importa **su propia** imagen vista desde arriba (o dibuja un croquis con medidas de cinta), calibra la escala, orienta al norte, traza los planos con sus medidas, agrega obstáculos con altura y ve las sombras por fecha y hora y el mapa de calor anual. La app **no obtiene ni muestra imágenes de ningún proveedor** ([ADR-005](../../../../docs/adr/ADR-005-estrategia-techo-por-capas.md)).

## Estado
**F3 completa.** Pendiente para F4: colocar paneles usando el área útil y el mapa de calor; efecto eléctrico de la sombra (diodos) y difusa.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| (ficha del proyecto) | `presentation/widgets/roof_entry_card.dart` | Tarjeta "Techo": número de planos y área. |
| `/projects/:id/roof` | `presentation/roof_page.dart` | Base (imagen/croquis, escala), botones Importar (con aviso "Usa solo imágenes que tengas derecho a usar"), Croquis con cinta, Calibrar, Norte, lista de planos y obstáculos, accesos a Sombras y Horizonte. |
| `/projects/:id/roof/editor?tool=` | `presentation/editor/roof_editor_page.dart` | Lienzo con zoom y arrastre + herramientas: Calibrar, Verificar, Norte, Trazar, Obstáculos, Pasillos, Elegir. `tool` = nombre de `EditorTool`. |
| `/projects/:id/roof/shade` | `presentation/shade_page.dart` | Deslizadores de fecha y hora con la sombra de cada obstáculo; mapa de calor anual y pérdida por plano. |
| `/projects/:id/roof/horizon` | `presentation/horizon_page.dart` | Horizonte del terreno (PVGIS) y obstáculos lejanos medidos con el teléfono. |

## Cómo funciona (en corto)
- **Coordenadas:** todo se guarda en **metros locales del sitio** (x = este, y = norte). La imagen se relaciona con los metros por `ImageFrame` (escala + ángulo del norte, origen al centro). El croquis usa un lienzo virtual de 40 × 40 m a 2 cm/px (`RoofSpace`).
- **Recalibrar o girar el norte:** lo dibujado se queda "pegado" a la imagen (`domain/reframe.dart`): se vuelve a calcular en metros.
- **Calibrar:** dos toques + medida real → m/px. **Verificar:** otra línea → % de diferencia (aviso si > 5 %).
- **Norte:** flecha girable (deslizador) o "Confirmar con brújula": se tocan dos puntos de una orilla y se apoya el teléfono sobre ella; el rumbo se corrige con la declinación del WMM2025 en el sitio.
- **Trazar:** toques en cada esquina; imán a 90° y a vértices (`editor/drawing_state.dart`); medidas en vivo (lados, área, ángulos). El azimut se calcula de la arista del alero (por defecto la que mira al ecuador). Planos: inclinación a mano o con inclinómetro, retiro de borde, pasillos, dividir por diagonal, mover esquinas (Elegir → tocar esquina → tocar nuevo lugar).
- **Obstáculos:** 9 tipos de B.7.1 con forma y medidas típicas (`geo_kit` `ObstacleCatalog`; tinaco 450/750/1100/2500 L); altura típica, con cinta o con el teléfono (distancia × tan(ángulo) + ojos).
- **Sombras:** `solar_engine` (`ShadowCaster`, `ShadeHeatmapCalculator`) en un isolate; incluye horizonte combinado.

## Capas
- `domain/` — modelos (`roof_models.dart`), JSON (`roof_codec.dart`), lienzo (`roof_space.dart`), medidas (`plane_summary.dart`), `reframe.dart`, interfaz de sensores (`phone_sensors.dart`) y trabajo de sombras (`shade_job.dart`, función pura).
- `data/` — `roof_mappers.dart` (filas ↔ modelos), `roof_providers.dart` (Riverpod), `roof_editing_service.dart` (operaciones), `roof_image_importer.dart` (≤ 2400 px, JPEG 90 en `projects/<id>/roof/`), `sensors_plus_phone_sensors.dart`, `roof_data_providers.dart` (PVGIS, sensores, isolate).
- `presentation/` — pantallas, `editor/` (lienzo, pintor, herramientas), `sensors/` (diálogo de inclinómetro/brújula/cámara), `widgets/`.

Dependencias permitidas: `presentation → domain ← data`. Tablas: `roof_images`, `roof_planes`, `obstacles`, `horizon_profiles` (esquema v5, `packages/persistence`).

## Cómo probar
```bash
cd app
flutter test test/features/roof
```
Incluye la **prueba de aceptación** (techo de 12 × 9 m medido dentro de ±5 %) en `roof_editor_test.dart`. Los sensores, PVGIS y el isolate se sustituyen en `test/helpers/roof_fakes.dart`. Revisión en el teléfono: `docs/pruebas/fase-3.md`.

## Errores conocidos / notas
- La brújula del teléfono se desvía cerca de metal (tinacos, varillas): el diálogo lo avisa.
- Las vistas inclinadas no se detectan solas: la línea de verificación avisa si la escala no cuadra.
- Las huellas no convexas (edificio en "L") se sombrean con su envolvente convexa.
- El modelo WMM2025 vale hasta 2030.
