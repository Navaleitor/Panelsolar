import 'dart:math' as math;
import 'dart:typed_data';

/// Cierre de componentes de irradiancia: GHI = DNI·cos θz + DHI.
///
/// En NASA POWER las tres series vienen de productos distintos y no siempre
/// cumplen esa igualdad (en Bogotá y CDMX la suma da ≈ 90 % de la GHI, lo
/// que subestima la energía ~9 %; ver docs/pruebas/validacion-motor.md).
/// Se conserva la GHI (la variable mejor medida) y la DHI, y se recalcula
/// la directa: DNI = (GHI − DHI)/cos θz, igual que la práctica habitual de
/// "completar" irradiancias (pvlib `complete_irradiance`).
///
/// - Con cenit > [maxZenith] o Sol bajo el horizonte: DNI = 0 y DHI = GHI.
/// - DNI se limita a la extraterrestre normal [dniExtra].
/// - Solo se cuentan como corregidas las horas cuya directa cambió más de
///   max(5 % de la GHI, 10 W/m²) en el plano horizontal.
///
/// Devuelve cuántas horas se corrigieron.
int closeIrradianceComponents({
  required Float64List ghi,
  required Float64List dni,
  required Float64List dhi,
  required Float64List cosZenith,
  required Float64List dniExtra,
  double maxZenith = 87,
}) {
  final minCos = math.cos(maxZenith * math.pi / 180);
  var changed = 0;
  for (var i = 0; i < ghi.length; i++) {
    final g = ghi[i];
    final c = cosZenith[i];
    double newDni;
    double newDhi;
    if (c <= minCos) {
      newDni = 0;
      newDhi = g;
    } else {
      newDhi = math.min(dhi[i], g);
      newDni = math.min((g - newDhi) / c, dniExtra[i]);
    }
    final before = dni[i] * math.max(0, c);
    final after = newDni * math.max(0, c);
    if ((after - before).abs() > math.max(0.05 * g, 10)) changed++;
    dni[i] = newDni;
    dhi[i] = newDhi;
  }
  return changed;
}
