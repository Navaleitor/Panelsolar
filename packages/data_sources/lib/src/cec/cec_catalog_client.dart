import 'dart:convert';
import 'dart:io';

import 'package:data_sources/src/cec/cec_parser.dart';
import 'package:data_sources/src/cec/cec_records.dart';
import 'package:data_sources/src/http/retrying_get.dart';
import 'package:http/http.dart' as http;

/// Catálogo CEC listo para buscar.
typedef CecCatalog = ({List<CecModule> modules, List<CecInverter> inverters});

/// Descarga (una vez) y lee el catálogo CEC de NREL SAM. Se guarda
/// comprimido en [cacheDir]; después funciona sin conexión.
class CecCatalogClient {
  /// Crea el cliente.
  new({required this.client, required this.cacheDir});

  /// Cliente HTTP.
  final http.Client client;

  /// Carpeta de la caché.
  final Directory cacheDir;

  /// Archivo de paneles en el repositorio de SAM (≈ 6 MB).
  static final Uri modulesUri = Uri.parse(
    'https://raw.githubusercontent.com/NREL/SAM/develop/deploy/libraries/'
    'CEC%20Modules.csv',
  );

  /// Archivo de inversores (≈ 0.4 MB).
  static final Uri invertersUri = Uri.parse(
    'https://raw.githubusercontent.com/NREL/SAM/develop/deploy/libraries/'
    'CEC%20Inverters.csv',
  );

  /// Atribución.
  static const String attribution =
      'Catálogo CEC (California Energy Commission) vía NREL SAM (BSD-3)';

  /// Carga el catálogo; con [forceRefresh] lo vuelve a descargar.
  Future<CecCatalog> load({bool forceRefresh = false}) async {
    final m = await _text('cec_modules.csv.gz', modulesUri, forceRefresh);
    final i = await _text('cec_inverters.csv.gz', invertersUri, forceRefresh);
    return (modules: CecParser.modules(m), inverters: CecParser.inverters(i));
  }

  /// `true` si ya está en la caché.
  bool get isCached =>
      File('${cacheDir.path}/cec_modules.csv.gz').existsSync() &&
      File('${cacheDir.path}/cec_inverters.csv.gz').existsSync();

  Future<String> _text(String name, Uri uri, bool force) async {
    final f = File('${cacheDir.path}/$name');
    if (!force && f.existsSync()) {
      return utf8.decode(gzip.decode(await f.readAsBytes()));
    }
    final r = await retryingGet(client, uri);
    if (r.statusCode != 200) {
      throw DataSourceException(
        'No se pudo descargar el catálogo CEC.',
        statusCode: r.statusCode,
      );
    }
    await cacheDir.create(recursive: true);
    await f.writeAsBytes(gzip.encode(r.bodyBytes));
    return utf8.decode(r.bodyBytes, allowMalformed: true);
  }
}
