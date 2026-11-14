/// Claves de `app_settings` del respaldo.
abstract final class BackupSettingKeys {
  /// `true` si el respaldo en Drive está activado.
  static const driveEnabled = 'backup.drive.enabled';

  /// Correo de la cuenta de Google conectada.
  static const driveEmail = 'backup.drive.email';

  /// Frecuencia automática: nombre de un valor de [BackupFrequency].
  static const driveFrequency = 'backup.drive.frequency';

  /// Sal fija del cifrado en Drive (los blobs se reutilizan entre
  /// respaldos mientras no cambie la contraseña).
  static const driveSalt = 'backup.drive.salt';
}

/// Cada cuánto corre el respaldo automático en Drive.
enum BackupFrequency {
  /// Diario (por omisión), solo con Wi-Fi y batería suficiente.
  daily,

  /// Semanal.
  weekly,

  /// Solo con el botón "Respaldar ahora" y al finalizar un proyecto.
  manual,
}
