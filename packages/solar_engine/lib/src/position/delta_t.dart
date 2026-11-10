/// ΔT = TT − UT (segundos): diferencia entre el tiempo dinámico terrestre y el
/// tiempo universal. Polinomios de Espenak y Meeus (NASA, "Polynomial
/// Expressions for Delta T"), igual que `pvlib.spa.calculate_deltat`.
///
/// Solo se implementan los tramos desde 1900; fuera de ellos se usa la
/// parábola de largo plazo −20 + 32·u², u = (y − 1820)/100.
/// Ficha: docs/formulas/01-posicion-solar-spa.md
double deltaTSeconds(int year, int month) {
  final y = year + (month - 0.5) / 12;
  if (year >= 2150 || year < 1900) {
    final u = (y - 1820) / 100;
    return -20 + 32 * u * u;
  }
  if (year >= 2050) {
    final u = (y - 1820) / 100;
    return -20 + 32 * u * u - 0.5628 * (2150 - y);
  }
  if (year >= 2005) {
    final t = y - 2000;
    return 62.92 + 0.32217 * t + 0.005589 * t * t;
  }
  if (year >= 1986) {
    final t = y - 2000;
    return 63.86 +
        0.3345 * t -
        0.060374 * t * t +
        0.0017275 * t * t * t +
        0.000651814 * t * t * t * t +
        0.00002373599 * t * t * t * t * t;
  }
  if (year >= 1961) {
    final t = y - 1975;
    return 45.45 + 1.067 * t - t * t / 260 - t * t * t / 718;
  }
  if (year >= 1941) {
    final t = y - 1950;
    return 29.07 + 0.407 * t - t * t / 233 + t * t * t / 2547;
  }
  if (year >= 1920) {
    final t = y - 1920;
    return 21.20 + 0.84493 * t - 0.076100 * t * t + 0.0020936 * t * t * t;
  }
  final t = y - 1900;
  return -2.79 +
      1.494119 * t -
      0.0598939 * t * t +
      0.0061966 * t * t * t -
      0.000197 * t * t * t * t;
}
