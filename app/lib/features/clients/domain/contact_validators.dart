/// Errores posibles al capturar datos de contacto.
enum ContactFieldError {
  /// Campo obligatorio vacío.
  required,

  /// Correo con formato inválido.
  invalidEmail,

  /// Teléfono con caracteres no válidos o muy corto.
  invalidPhone,
}

/// Reglas de validación de los datos de contacto de un cliente (sin UI).
abstract final class ContactValidators {
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final _phoneChars = RegExp(r'^[0-9+()\-.\s]+$');

  /// Nombre obligatorio.
  static ContactFieldError? name(String? value) =>
      (value == null || value.trim().isEmpty)
      ? ContactFieldError.required
      : null;

  /// Correo opcional; si se escribe, debe tener forma `a@b.c`.
  static ContactFieldError? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null;
    return _email.hasMatch(v) ? null : ContactFieldError.invalidEmail;
  }

  /// Teléfono opcional; solo dígitos, espacios, `+ - ( ) .` y al menos 7
  /// dígitos.
  static ContactFieldError? phone(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null;
    final digits = v.replaceAll(RegExp('[^0-9]'), '').length;
    return (_phoneChars.hasMatch(v) && digits >= 7)
        ? null
        : ContactFieldError.invalidPhone;
  }
}
