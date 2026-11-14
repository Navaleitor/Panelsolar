import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Guarda la contraseña del respaldo automático en Drive (el respaldo
/// diario corre sin que el usuario la escriba). Va en el almacén cifrado
/// del sistema (Android Keystore), nunca en la base.
abstract interface class SecretStore {
  Future<String?> drivePassword();
  Future<void> setDrivePassword(String? password);
}

/// [SecretStore] con `flutter_secure_storage`.
class SecureSecretStore implements SecretStore {
  new([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const _key = 'backup.drive.password';

  @override
  Future<String?> drivePassword() => _storage.read(key: _key);

  @override
  Future<void> setDrivePassword(String? password) => password == null
      ? _storage.delete(key: _key)
      : _storage.write(key: _key, value: password);
}
