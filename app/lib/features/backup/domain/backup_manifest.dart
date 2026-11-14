import 'dart:convert';

/// Archivo (foto o documento) dentro de un respaldo.
class BackupFileEntry {
  const new({required this.path, required this.sha256, required this.size});

  factory fromJson(Map<String, Object?> json) => BackupFileEntry(
    path: json['path']! as String,
    sha256: json['sha256']! as String,
    size: json['size']! as int,
  );

  /// Ruta relativa a la carpeta de la app (igual que en la base).
  final String path;

  /// SHA-256 del archivo original (sin cifrar).
  final String sha256;

  /// Tamaño en bytes del original.
  final int size;

  Map<String, Object?> toJson() => {
    'path': path,
    'sha256': sha256,
    'size': size,
  };
}

/// `manifest.json` de un respaldo: se guarda **sin cifrar** para mostrar
/// la vista previa antes de pedir la contraseña. No lleva datos
/// personales: solo fechas, versiones, conteos y hashes.
class BackupManifest {
  const new({
    required this.createdAt,
    required this.appVersion,
    required this.schemaVersion,
    required this.encrypted,
    required this.filesIncluded,
    required this.counts,
    required this.files,
    this.kdfSalt,
    this.kdfIterations,
    this.formatVersion = currentFormat,
  });

  factory fromJson(Map<String, Object?> json) {
    final format = json['format'] as int? ?? 0;
    if (format < 1 || format > currentFormat) {
      throw const FormatException('Formato de respaldo no compatible');
    }
    return BackupManifest(
      formatVersion: format,
      createdAt: DateTime.parse(json['createdAt']! as String).toUtc(),
      appVersion: json['appVersion']! as String,
      schemaVersion: json['schemaVersion']! as int,
      encrypted: json['encrypted']! as bool,
      filesIncluded: json['filesIncluded'] as bool? ?? true,
      kdfSalt: json['kdfSalt'] as String?,
      kdfIterations: json['kdfIterations'] as int?,
      counts: (json['counts']! as Map<String, Object?>).map(
        (k, v) => MapEntry(k, v! as int),
      ),
      files: [
        for (final f in json['files']! as List<Object?>)
          BackupFileEntry.fromJson(f! as Map<String, Object?>),
      ],
    );
  }

  /// Lee el manifiesto desde texto JSON.
  factory decode(String text) =>
      BackupManifest.fromJson(jsonDecode(text) as Map<String, Object?>);

  /// Versión del formato del .zip (subirla si cambia la estructura).
  static const int currentFormat = 1;

  /// Nombre del manifiesto dentro del .zip.
  static const String entryName = 'manifest.json';

  final int formatVersion;
  final DateTime createdAt;
  final String appVersion;

  /// Versión del esquema de la base respaldada.
  final int schemaVersion;

  /// Si la base y los archivos van cifrados (AES-256-GCM).
  final bool encrypted;

  /// `false` en Drive: los archivos se suben aparte (incrementales).
  final bool filesIncluded;

  /// Sal de PBKDF2 en base64 (solo si está cifrado).
  final String? kdfSalt;

  /// Iteraciones de PBKDF2 (solo si está cifrado).
  final int? kdfIterations;

  /// Registros activos por tabla (clientes, proyectos, fotos, ...).
  final Map<String, int> counts;

  /// Fotos y documentos del respaldo.
  final List<BackupFileEntry> files;

  Map<String, Object?> toJson() => {
    'format': formatVersion,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'appVersion': appVersion,
    'schemaVersion': schemaVersion,
    'encrypted': encrypted,
    'filesIncluded': filesIncluded,
    'kdfSalt': ?kdfSalt,
    'kdfIterations': ?kdfIterations,
    'counts': counts,
    'files': [for (final f in files) f.toJson()],
  };

  /// Texto JSON con sangría (legible si alguien abre el .zip).
  String encode() => const JsonEncoder.withIndent('  ').convert(toJson());
}
