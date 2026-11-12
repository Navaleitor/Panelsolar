# Fotos

Fotos de cada proyecto por etapa: **levantamiento, instalación, mantenimiento**. Desde la cámara o la galería (varias a la vez).

## Estado
**F1 completa.**

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| (ficha del proyecto) | `presentation/photos_summary_card.dart` | Cuántas fotos hay por etapa. |
| `/projects/:id/photos` | `presentation/photos_page.dart` | Pestañas por etapa, cuadrícula, botón "Agregar foto" (cámara/galería). |
| `/projects/:id/photos/:photoId` | `presentation/photo_view_page.dart` | Foto con zoom, tamaño, fecha, GPS, descripción editable, borrar. |

## Qué pasa al agregar una foto (`data/photo_importer.dart`)
1. **Compresión** en segundo plano (`compute`) con `data/photo_processor.dart`: se endereza según el EXIF, lado mayor ≤ **1600 px**, JPEG **80 %** (plan A.4). El JPEG final no lleva EXIF.
2. **GPS**: se lee del EXIF (grados/minutos/segundos + hemisferio). Si la foto viene de la cámara y no trae GPS, se usa la última posición conocida del teléfono. Desde galería sin GPS → queda sin ubicación.
3. **Hash SHA-256** del JPEG final: si el proyecto ya tiene esa foto, no se duplica.
4. Se guarda en `projects/<id>/photos/<hash>.jpg` (ruta relativa) y se registra en la tabla `photos`.

## Capas
- `domain/processed_photo.dart` — resultado de la compresión.
- `data/` — procesador, importador, providers (importador, `ImagePicker`).
- `presentation/` — pantallas.

## Cómo probar
```bash
cd app
flutter test test/features/photos
```
