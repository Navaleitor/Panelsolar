import 'dart:convert';
import 'dart:io';

/// Caché comprimida (JSON + gzip) por proyecto en el almacenamiento local.
///
/// Estructura: `<raíz>/<proyecto>/<clave>.json.gz`. Los datos de clima se
/// descargan una sola vez por proyecto y quedan disponibles sin conexión
/// (plan A.4 "offline-first" y B.5).
class ProjectCache {
  /// Crea la caché en el directorio [root] (la app usa el directorio de
  /// soporte de la aplicación).
  new(this.root);

  /// Directorio raíz.
  final Directory root;

  static final _safe = RegExp('[^A-Za-z0-9_.-]');

  File _file(String projectId, String key) => File(
    '${root.path}/${projectId.replaceAll(_safe, '_')}/'
    '${key.replaceAll(_safe, '_')}.json.gz',
  );

  /// Guarda [json] comprimido.
  Future<void> write(String projectId, String key, Object json) async {
    final f = _file(projectId, key);
    await f.parent.create(recursive: true);
    final tmp = File('${f.path}.tmp');
    await tmp.writeAsBytes(gzip.encode(utf8.encode(jsonEncode(json))));
    await tmp.rename(f.path);
  }

  /// Lee un valor guardado o nulo si no existe o está dañado.
  Future<Object?> read(String projectId, String key) async {
    final f = _file(projectId, key);
    if (!f.existsSync()) return null;
    try {
      return jsonDecode(utf8.decode(gzip.decode(await f.readAsBytes())));
    } on FormatException {
      return null;
    }
  }

  /// Tamaño en bytes del archivo de [key] (0 si no existe).
  int sizeOf(String projectId, String key) {
    final f = _file(projectId, key);
    return f.existsSync() ? f.lengthSync() : 0;
  }

  /// Borra toda la caché de un proyecto.
  Future<void> clearProject(String projectId) async {
    final dir = Directory('${root.path}/${projectId.replaceAll(_safe, '_')}');
    if (dir.existsSync()) await dir.delete(recursive: true);
  }
}
