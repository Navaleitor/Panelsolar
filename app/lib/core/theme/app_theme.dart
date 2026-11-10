import 'package:flutter/material.dart';

/// Tema Material 3 de alto contraste, pensado para uso en exteriores
/// (plan A.4): colores con contraste máximo y controles grandes.
abstract final class AppTheme {
  /// Color base de la marca (ámbar solar).
  static const Color seed = Color(0xFFF2A900);

  /// Tamaño mínimo de los botones (más grande que el estándar de 40 px).
  static const Size minButtonSize = Size(64, 52);

  /// Tema claro.
  static ThemeData light() => _build(Brightness.light);

  /// Tema oscuro.
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
      // 1.0 = contraste alto (rango -1.0 a 1.0).
      contrastLevel: 1,
    );
    const buttonStyle = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(minButtonSize),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
    return ThemeData(
      colorScheme: scheme,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      filledButtonTheme: const FilledButtonThemeData(style: buttonStyle),
      elevatedButtonTheme: const ElevatedButtonThemeData(style: buttonStyle),
      outlinedButtonTheme: const OutlinedButtonThemeData(style: buttonStyle),
      textButtonTheme: const TextButtonThemeData(style: buttonStyle),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
