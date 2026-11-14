/// Lee un número decimal escrito por el usuario: acepta coma o punto
/// decimal (`12,5` o `12.5`). Devuelve `null` si está vacío o no es número.
double? parseDecimal(String text) {
  var t = text.trim().replaceAll(' ', '');
  if (t.isEmpty) return null;
  if (t.contains(',') && !t.contains('.')) t = t.replaceAll(',', '.');
  t = t.replaceAll(',', '');
  final value = double.tryParse(t);
  return (value == null || value.isNaN || value.isInfinite) ? null : value;
}

/// Texto editable de un número (sin separador de miles) o vacío.
String decimalText(double? value) {
  if (value == null) return '';
  if (value == value.roundToDouble()) return value.toStringAsFixed(0);
  return value.toString();
}
