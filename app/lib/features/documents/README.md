# Documentos

Archivos adjuntos a cada proyecto (contrato, trámite de interconexión, garantías…) en **PDF o imagen** (JPG, PNG, WEBP).

## Estado
**F1 completa.**

## Pantallas
| Dónde | Archivo | Qué hace |
|---|---|---|
| Ficha del proyecto | `presentation/documents_section.dart` | Lista; "Agregar" abre el selector de archivos; tocar abre el archivo con la app del teléfono; menú ⋮ → Renombrar / Borrar. |

## Qué pasa al agregar (`data/document_importer.dart`)
1. Se detecta el tipo por la **firma del archivo** (`%PDF`, JPEG, PNG, WEBP), no solo por la extensión (`domain/document_type.dart`). Otros tipos se rechazan con aviso.
2. Hash SHA-256, copia a `projects/<id>/documents/<hash>.<ext>` (ruta relativa) y registro en la tabla `documents`. Título = nombre del archivo sin extensión.

## Capas
- `domain/document_type.dart` — detección de tipo y título por defecto.
- `data/` — importador y providers (`documentPickerProvider` usa `file_picker`; `fileOpenerProvider` usa `open_filex`). En pruebas se reemplazan por falsos.
- `presentation/` — sección de la ficha.

## Cómo probar
```bash
cd app
flutter test test/features/documents
```
