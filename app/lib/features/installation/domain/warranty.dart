/// Estado de la garantía de un equipo en una fecha dada.
enum WarrantyState {
  /// Sin fecha capturada.
  unknown,

  /// Vigente.
  active,

  /// Vence en los próximos 90 días.
  expiringSoon,

  /// Vencida.
  expired,
}

/// Clasifica la garantía que vence en [until].
WarrantyState warrantyState(DateTime? until, DateTime today) {
  if (until == null) return WarrantyState.unknown;
  final day = DateTime.utc(today.year, today.month, today.day);
  if (until.isBefore(day)) return WarrantyState.expired;
  if (until.difference(day).inDays <= 90) return WarrantyState.expiringSoon;
  return WarrantyState.active;
}
