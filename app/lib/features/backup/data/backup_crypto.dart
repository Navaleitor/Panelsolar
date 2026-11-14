import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// Contraseña incorrecta o archivo dañado (falla la verificación de
/// AES-GCM).
class WrongPasswordException implements Exception {
  const new();

  @override
  String toString() => 'WrongPasswordException';
}

/// Cifrado de respaldos: AES-256-GCM con llave derivada por
/// PBKDF2-HMAC-SHA256 (plan A.4). Ficha: `docs/formulas/cifrado-respaldo.md`.
///
/// Cada archivo se cifra por separado: `nonce (12 B) ‖ cifrado ‖ etiqueta
/// (16 B)`. Así no hace falta tener todo el respaldo en memoria.
class BackupCipher {
  new _(this._key);

  /// Iteraciones de PBKDF2 por omisión.
  static const int defaultIterations = 150000;

  static final _aes = AesGcm.with256bits();

  final SecretKey _key;

  /// Sal aleatoria de 16 bytes en base64.
  static String newSalt() {
    final rnd = Random.secure();
    return base64Encode(List<int>.generate(16, (_) => rnd.nextInt(256)));
  }

  /// Deriva la llave de [password] con [saltBase64] (en otro *isolate*
  /// para no congelar la pantalla).
  static Future<BackupCipher> derive(
    String password,
    String saltBase64, {
    int iterations = defaultIterations,
  }) async {
    final keyBytes = await Isolate.run(
      () => _deriveBytes(password, saltBase64, iterations),
    );
    return BackupCipher._(SecretKey(keyBytes));
  }

  static Future<List<int>> _deriveBytes(
    String password,
    String saltBase64,
    int iterations,
  ) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: 256,
    );
    final key = await pbkdf2.deriveKeyFromPassword(
      password: password,
      nonce: base64Decode(saltBase64),
    );
    return await key.extractBytes();
  }

  /// Cifra [plain] con un nonce nuevo.
  Future<Uint8List> encrypt(List<int> plain) async {
    final box = await _aes.encrypt(plain, secretKey: _key);
    return box.concatenation();
  }

  /// Descifra lo producido por [encrypt]. Lanza [WrongPasswordException]
  /// si la contraseña no corresponde o el contenido se alteró.
  Future<Uint8List> decrypt(List<int> data) async {
    if (data.length < _aes.nonceLength + _aes.macAlgorithm.macLength) {
      throw const WrongPasswordException();
    }
    try {
      final box = SecretBox.fromConcatenation(
        data,
        nonceLength: _aes.nonceLength,
        macLength: _aes.macAlgorithm.macLength,
      );
      return Uint8List.fromList(await _aes.decrypt(box, secretKey: _key));
    } on SecretBoxAuthenticationError {
      throw const WrongPasswordException();
    }
  }
}
