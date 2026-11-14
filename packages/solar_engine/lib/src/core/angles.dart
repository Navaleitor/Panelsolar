import 'dart:math' as math;

/// Utilidades de ángulos. Internamente el motor trabaja en grados para las
/// entradas/salidas (convención de pvlib) y en radianes solo dentro de las
/// funciones trigonométricas.

/// Grados → radianes.
double degToRad(double degrees) => degrees * math.pi / 180;

/// Radianes → grados.
double radToDeg(double radians) => radians * 180 / math.pi;

/// Coseno de un ángulo en grados.
double cosd(double degrees) => math.cos(degToRad(degrees));

/// Seno de un ángulo en grados.
double sind(double degrees) => math.sin(degToRad(degrees));

/// Tangente de un ángulo en grados.
double tand(double degrees) => math.tan(degToRad(degrees));

/// Módulo positivo (como `%` de Python): el resultado tiene el signo de [m].
double positiveMod(double value, double m) {
  final r = value % m;
  return r < 0 ? r + m : r;
}

/// Limita [value] al intervalo [[lo], [hi]].
double clampDouble(double value, double lo, double hi) =>
    value < lo ? lo : (value > hi ? hi : value);
