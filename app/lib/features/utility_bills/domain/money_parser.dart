/// Convierte texto escrito por el usuario en número decimal. Acepta coma
/// o punto decimal y separadores de miles comunes (`1,540.50`,
/// `1540,5`, `1 540`). Devuelve `null` si no es un número.
double? parseDecimal(String text) {
  var t = text.trim().replaceAll(RegExp(r'[\s$]'), '');
  if (t.isEmpty) return null;
  final lastComma = t.lastIndexOf(',');
  final lastDot = t.lastIndexOf('.');
  if (lastComma > lastDot) {
    // La coma es decimal si tiene 1–2 dígitos después; si no, es de miles.
    final decimals = t.length - lastComma - 1;
    t = (decimals <= 2 && lastDot == -1)
        ? t.replaceAll('.', '').replaceAll(',', '.')
        : (lastDot == -1
              ? t.replaceAll(',', '')
              : t.replaceAll('.', '').replaceAll(',', '.'));
  } else {
    t = t.replaceAll(',', '');
  }
  final value = double.tryParse(t);
  return (value == null || !value.isFinite) ? null : value;
}

/// Convierte un importe escrito (`1,540.50`) en centavos (`154050`).
/// Vacío o inválido → `null`.
int? parseMoneyToCents(String text) {
  final value = parseDecimal(text);
  return value == null ? null : (value * 100).round();
}
