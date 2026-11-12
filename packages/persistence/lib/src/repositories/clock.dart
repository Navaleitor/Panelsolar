/// Hora actual en UTC (todas las fechas de la base van en UTC).
DateTime utcNow() => DateTime.now().toUtc();

/// Convierte el texto de búsqueda del usuario en un patrón `LIKE`
/// (`%texto%`), escapando los comodines `%` y `_` con `\`.
String likePattern(String query) {
  final escaped = query
      .trim()
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');
  return '%$escaped%';
}
