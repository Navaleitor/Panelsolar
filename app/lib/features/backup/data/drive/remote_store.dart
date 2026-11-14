import 'dart:io';
import 'dart:typed_data';

/// Archivo en la carpeta privada de la app en la nube.
typedef RemoteFile = ({String id, String name, DateTime createdAt, int? size});

/// Almacén remoto plano (sin carpetas). La implementación real es
/// `DriveRemoteStore` (`appDataFolder` de Google Drive); en pruebas se usa
/// uno en memoria.
abstract interface class RemoteStore {
  /// Todos los archivos.
  Future<List<RemoteFile>> list();

  /// Sube [file] con el nombre [name].
  Future<void> upload(String name, File file);

  /// Sube [bytes] con el nombre [name].
  Future<void> uploadBytes(String name, Uint8List bytes);

  /// Contenido del archivo [id].
  Future<Uint8List> download(String id);

  /// Borra el archivo [id].
  Future<void> delete(String id);
}
