# Cifrado del respaldo (AES-256-GCM + PBKDF2)

- **Dónde**: `app/lib/features/backup/data/backup_crypto.dart` (F6).
- **Prueba**: `app/test/features/backup/backup_roundtrip_test.dart` y `drive_backup_service_test.dart`.
- **Fuente**: NIST SP 800-38D (GCM), RFC 8018 (PBKDF2), OWASP Password Storage Cheat Sheet.

## Procedimiento
1. Sal aleatoria de 16 bytes (`Random.secure`), guardada en `manifest.json` (no es secreta).
2. Llave de 256 bits = PBKDF2-HMAC-SHA256(contraseña, sal, 150 000 iteraciones).
3. Cada archivo del respaldo (base y cada foto/documento) se cifra por separado con AES-256-GCM y un nonce aleatorio de 12 bytes: `nonce ‖ cifrado ‖ etiqueta de 16 bytes`.
4. Al restaurar, si la etiqueta no coincide (contraseña incorrecta o archivo alterado) se rechaza antes de tocar los datos.

## Notas
- Sin la contraseña no hay forma de recuperar un respaldo cifrado.
- El manifiesto queda sin cifrar para la vista previa y solo trae fechas, versiones, conteos y hashes (sin nombres ni datos de clientes).
- Implementación en Dart puro (paquete `cryptography`): ~6 MB/s en una PC; en teléfono puede ser más lento con muchas fotos. Mejora futura: `cryptography_flutter` (AES nativo de Android).

## Caso de prueba
Respaldo cifrado con "clave secreta": restaurar con "otra" lanza `WrongPasswordException`; con la correcta, la base restaurada es idéntica tabla por tabla.
