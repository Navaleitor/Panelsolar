/// Tipo de protección o dispositivo.
enum ProtectionKind {
  /// Fusible de string (CD).
  stringFuse,

  /// Desconectador de CD.
  dcDisconnect,

  /// Dispositivo de protección contra sobretensiones en CD.
  dcSpd,

  /// Interruptor termomagnético de CA a la salida del inversor.
  acBreaker,

  /// DPS en CA.
  acSpd,

  /// Conductor de puesta a tierra de equipos.
  groundingConductor,
}

/// Una protección sugerida.
class ProtectionSuggestion {
  /// Crea la sugerencia.
  const new({
    required this.kind,
    required this.required,
    this.ratingA,
    this.voltageV,
    this.quantity = 1,
    this.conductorLabel,
  });

  /// Tipo.
  final ProtectionKind kind;

  /// `false` = no hace falta (p. ej. fusibles con ≤ 2 strings).
  final bool required;

  /// Corriente nominal (A).
  final double? ratingA;

  /// Tensión mínima (V).
  final double? voltageV;

  /// Cantidad.
  final int quantity;

  /// Calibre (solo conductor de tierra).
  final String? conductorLabel;
}

/// Entrada para las protecciones de un inversor.
class ProtectionInput {
  /// Crea la entrada.
  const new({
    required this.moduleIscA,
    required this.stringsInParallel,
    required this.totalStrings,
    required this.maxStringVocV,
    required this.inverterAcCurrentA,
    required this.gridVoltageV,
    required this.standardRatingsA,
    required this.groundingTable,
    this.fuseRatingsA,
    this.moduleMaxSeriesFuseA,
  });

  /// Isc del panel (A).
  final double moduleIscA;

  /// Mayor número de strings en paralelo en una misma entrada.
  final int stringsInParallel;

  /// Strings en total del inversor.
  final int totalStrings;

  /// Voc máximo del string con frío (V).
  final double maxStringVocV;

  /// Corriente AC máxima de salida del inversor (A).
  final double inverterAcCurrentA;

  /// Tensión de la red (V).
  final double gridVoltageV;

  /// Capacidades comerciales de interruptores y desconectadores (A), en
  /// orden.
  final List<double> standardRatingsA;

  /// Capacidades comerciales de fusibles (A), en orden; si es nula se usa
  /// [standardRatingsA].
  final List<double>? fuseRatingsA;

  /// Tabla de conductor de tierra: (protección máxima A, calibre), en orden.
  final List<(double, String)> groundingTable;

  /// Fusible máximo en serie del panel (A).
  final double? moduleMaxSeriesFuseA;
}

/// Protecciones sugeridas (B.6 punto 16). Siempre indicativas.
/// Ficha: docs/formulas/25-protecciones-y-tierra.md
abstract final class ProtectionSizing {
  /// Factor de corriente continua de la norma: 1.25 × 1.25 = 1.5625.
  static const double continuousFactor = 1.25 * 1.25;

  /// La capacidad comercial más pequeña ≥ [amps]; la mayor si ninguna.
  static double roundUp(double amps, List<double> ratings) {
    for (final r in ratings) {
      if (r >= amps - 1e-9) return r;
    }
    return ratings.isEmpty ? amps : ratings.last;
  }

  /// `true` si hacen falta fusibles de string: más de 2 en paralelo.
  static bool stringFusesRequired(int parallel) => parallel > 2;

  /// Lista de protecciones.
  static List<ProtectionSuggestion> suggest(ProtectionInput i) {
    final fuseMin = i.moduleIscA * continuousFactor;
    var fuse = roundUp(fuseMin, i.fuseRatingsA ?? i.standardRatingsA);
    final maxFuse = i.moduleMaxSeriesFuseA;
    if (maxFuse != null && fuse > maxFuse) fuse = maxFuse;
    final needFuses = stringFusesRequired(i.stringsInParallel);
    // El desconectador lleva todos los strings del inversor.
    final dcCurrent = i.moduleIscA * continuousFactor * i.totalStrings;
    final acBreaker = roundUp(i.inverterAcCurrentA * 1.25, i.standardRatingsA);
    final grounding = groundingFor(acBreaker, i.groundingTable);
    return [
      ProtectionSuggestion(
        kind: ProtectionKind.stringFuse,
        required: needFuses,
        ratingA: fuse,
        voltageV: i.maxStringVocV,
        // Un fusible en positivo y otro en negativo por string.
        quantity: needFuses ? i.totalStrings * 2 : 0,
      ),
      ProtectionSuggestion(
        kind: ProtectionKind.dcDisconnect,
        required: true,
        ratingA: roundUp(dcCurrent, i.standardRatingsA),
        voltageV: i.maxStringVocV,
      ),
      ProtectionSuggestion(
        kind: ProtectionKind.dcSpd,
        required: true,
        // IEC 61643-31: Ucpv ≥ 1.2 × Voc máx del string.
        voltageV: i.maxStringVocV * 1.2,
      ),
      ProtectionSuggestion(
        kind: ProtectionKind.acBreaker,
        required: true,
        ratingA: acBreaker,
        voltageV: i.gridVoltageV,
      ),
      ProtectionSuggestion(
        kind: ProtectionKind.acSpd,
        required: true,
        // Uc ≥ 1.1 × tensión de fase a neutro (o de la red si es monofásica).
        voltageV: i.gridVoltageV * 1.1,
      ),
      ProtectionSuggestion(
        kind: ProtectionKind.groundingConductor,
        required: true,
        ratingA: acBreaker,
        conductorLabel: grounding,
      ),
    ];
  }

  /// Calibre de tierra para una protección de [ratingA] A.
  static String? groundingFor(double ratingA, List<(double, String)> table) {
    for (final (limit, label) in table) {
      if (ratingA <= limit + 1e-9) return label;
    }
    return table.isEmpty ? null : table.last.$2;
  }
}
