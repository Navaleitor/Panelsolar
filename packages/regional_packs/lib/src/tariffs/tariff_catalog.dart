import 'dart:convert';

import 'package:regional_packs/src/tariffs/tariff.dart';

/// Conjunto de tarifas de un paquete regional, leído de JSON y validado.
class TariffCatalog {
  /// Crea el catálogo y lo valida (ver [validate]).
  new(List<Tariff> tariffs) : tariffs = List.unmodifiable(tariffs) {
    final problems = validate(this.tariffs);
    if (problems.isNotEmpty) {
      throw FormatException('Catálogo de tarifas inválido: $problems');
    }
  }

  /// Lee el catálogo de un texto JSON con la forma `{"tariffs": [...]}`.
  factory fromJsonString(String source) {
    final data = jsonDecode(source);
    if (data is! Map<String, Object?> || data['tariffs'] is! List) {
      throw const FormatException('Se esperaba {"tariffs": [...]}');
    }
    return TariffCatalog([
      for (final item in data['tariffs']! as List)
        Tariff.fromJson((item as Map).cast<String, Object?>()),
    ]);
  }

  /// Tarifas en el orden del archivo.
  final List<Tariff> tariffs;

  /// Busca por código (`null` si no existe).
  Tariff? byCode(String? code) {
    if (code == null) return null;
    for (final t in tariffs) {
      if (t.code == code) return t;
    }
    return null;
  }

  /// Devuelve la lista de problemas (vacía = válido):
  /// códigos únicos con prefijo `PAÍS-SUMINISTRADOR-`, nombres no vacíos,
  /// límites positivos y temperaturas en rango razonable.
  static List<String> validate(List<Tariff> tariffs) {
    final problems = <String>[];
    final seen = <String>{};
    for (final t in tariffs) {
      if (!seen.add(t.code)) problems.add('código repetido ${t.code}');
      if (!t.code.startsWith('${t.country}-${t.utility}-')) {
        problems.add('${t.code}: debe empezar con ${t.country}-${t.utility}-');
      }
      if (t.shortName.trim().isEmpty ||
          t.nameEs.trim().isEmpty ||
          t.nameEn.trim().isEmpty) {
        problems.add('${t.code}: nombre vacío');
      }
      final limit = t.highConsumptionLimitKwhPerMonth;
      if (limit != null && limit <= 0) {
        problems.add('${t.code}: límite de alto consumo no positivo');
      }
      final temp = t.minSummerAvgTempC;
      if (temp != null && (temp < 0 || temp > 50)) {
        problems.add('${t.code}: temperatura fuera de rango');
      }
    }
    return problems;
  }
}
