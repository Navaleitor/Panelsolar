import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:panelsolar/features/backup/data/drive/remote_store.dart';

/// [RemoteStore] sobre la carpeta oculta de la app en Google Drive
/// (`appDataFolder`, scope `drive.appdata`, plan B.9). El usuario no la ve
/// en su Drive y otras apps no la pueden leer.
class DriveRemoteStore implements RemoteStore {
  new(http.Client client) : _api = drive.DriveApi(client);

  final drive.DriveApi _api;

  static const _space = 'appDataFolder';

  @override
  Future<List<RemoteFile>> list() async {
    final result = <RemoteFile>[];
    String? page;
    do {
      final list = await _api.files.list(
        spaces: _space,
        pageSize: 1000,
        pageToken: page,
        $fields: 'nextPageToken, files(id, name, createdTime, size)',
      );
      for (final f in list.files ?? const <drive.File>[]) {
        result.add((
          id: f.id!,
          name: f.name ?? '',
          createdAt: (f.createdTime ?? DateTime.now()).toUtc(),
          size: int.tryParse(f.size ?? ''),
        ));
      }
      page = list.nextPageToken;
    } while (page != null);
    return result;
  }

  @override
  Future<void> upload(String name, File file) async {
    await _api.files.create(
      drive.File(name: name, parents: [_space]),
      uploadMedia: drive.Media(file.openRead(), await file.length()),
    );
  }

  @override
  Future<void> uploadBytes(String name, Uint8List bytes) async {
    await _api.files.create(
      drive.File(name: name, parents: [_space]),
      uploadMedia: drive.Media(Stream.value(bytes), bytes.length),
    );
  }

  @override
  Future<Uint8List> download(String id) async {
    final media = await _api.files.get(
      id,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;
    final builder = BytesBuilder(copy: false);
    await media.stream.forEach(builder.add);
    return builder.takeBytes();
  }

  @override
  Future<void> delete(String id) => _api.files.delete(id);
}
