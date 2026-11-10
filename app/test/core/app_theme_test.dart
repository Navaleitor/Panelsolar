import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/core/theme/app_theme.dart';

/// Razón de contraste WCAG entre dos colores.
double contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final (hi, lo) = la > lb ? (la, lb) : (lb, la);
  return (hi + 0.05) / (lo + 0.05);
}

void main() {
  for (final (name, theme) in [
    ('claro', AppTheme.light()),
    ('oscuro', AppTheme.dark()),
  ]) {
    group('tema $name', () {
      test('usa Material 3', () => expect(theme.useMaterial3, isTrue));

      test('texto sobre fondo cumple WCAG AAA (≥ 7:1)', () {
        final s = theme.colorScheme;
        expect(contrast(s.onSurface, s.surface), greaterThanOrEqualTo(7));
        expect(contrast(s.onPrimary, s.primary), greaterThanOrEqualTo(7));
      });
    });
  }

  test('el tema oscuro es oscuro', () {
    expect(AppTheme.dark().colorScheme.brightness, Brightness.dark);
  });
}
