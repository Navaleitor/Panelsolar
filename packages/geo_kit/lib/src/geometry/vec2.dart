import 'dart:math' as math;

import 'package:meta/meta.dart';

/// Punto o vector en el plano.
///
/// Se usa con dos convenciones (cada clase que lo recibe dice cuál):
/// - **Coordenadas locales del sitio** (metros): `x` = este, `y` = norte.
/// - **Píxeles de imagen**: `x` = a la derecha, `y` = hacia abajo.
@immutable
class Vec2 {
  /// Crea el punto (x, y).
  const new(this.x, this.y);

  /// Lee `[x, y]` de JSON.
  factory fromJson(Object? json) {
    final list = json! as List;
    return Vec2((list[0] as num).toDouble(), (list[1] as num).toDouble());
  }

  /// Origen (0, 0).
  static const Vec2 zero = Vec2(0, 0);

  /// Primera coordenada.
  final double x;

  /// Segunda coordenada.
  final double y;

  /// Suma.
  Vec2 operator +(Vec2 o) => Vec2(x + o.x, y + o.y);

  /// Resta.
  Vec2 operator -(Vec2 o) => Vec2(x - o.x, y - o.y);

  /// Producto por un escalar.
  Vec2 operator *(double k) => Vec2(x * k, y * k);

  /// Opuesto.
  Vec2 operator -() => Vec2(-x, -y);

  /// Longitud (norma euclidiana).
  double get length => math.sqrt(x * x + y * y);

  /// Producto punto.
  double dot(Vec2 o) => x * o.x + y * o.y;

  /// Producto cruz (componente z).
  double cross(Vec2 o) => x * o.y - y * o.x;

  /// Distancia a [o].
  double distanceTo(Vec2 o) => (this - o).length;

  /// Vector unitario en la misma dirección (cero si la longitud es cero).
  Vec2 get normalized {
    final l = length;
    return l == 0 ? Vec2.zero : Vec2(x / l, y / l);
  }

  /// Gira el vector [degrees] grados en sentido antihorario (ejes x→y).
  Vec2 rotated(double degrees) {
    final r = degrees * math.pi / 180;
    final c = math.cos(r);
    final s = math.sin(r);
    return Vec2(x * c - y * s, x * s + y * c);
  }

  /// Lista `[x, y]` para guardar en JSON.
  List<double> toJson() => [x, y];

  @override
  bool operator ==(Object other) =>
      other is Vec2 && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Vec2($x, $y)';
}
