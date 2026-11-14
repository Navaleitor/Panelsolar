/// Modelo eléctrico simplificado de sombra con diodos bypass
/// (B.7.1 paso 5). Cada panel tiene [sectionsPerPanel] secciones; una
/// sección con sombra queda limitada a la luz de sombra (solo difusa).
/// Ficha: docs/formulas/27-sombra-por-panel-y-diodos.md
abstract final class BypassModel {
  /// Secciones (diodos) por panel.
  static const int sectionsPerPanel = 3;

  /// Potencia relativa (1 = panel sin sombra ni obstáculos) de una cadena
  /// de secciones en serie con irradiancias relativas [sections].
  ///
  /// El inversor elige la corriente que da más potencia: con corriente c,
  /// solo aportan las secciones que dan al menos c; las demás se puentean
  /// con su diodo. P = máx_c [c · (# secciones con g ≥ c)] / secciones
  /// por panel.
  static double seriesPower(List<double> sections) {
    if (sections.isEmpty) return 0;
    final sorted = [...sections]..sort((a, b) => b.compareTo(a));
    var best = 0.0;
    for (var k = 0; k < sorted.length; k++) {
      final p = sorted[k] * (k + 1);
      if (p > best) best = p;
    }
    return best / sectionsPerPanel;
  }
}
