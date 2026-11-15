import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/installation/domain/commissioning_evaluation.dart';
import 'package:panelsolar/features/installation/domain/warranty.dart';
import 'package:persistence/persistence.dart';

StringTest string({
  double? expVoc = 400,
  double? voc = 398,
  double? expIsc = 10,
  double? isc = 9.5,
  bool? polarity = true,
}) => StringTest(
  id: 's',
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
  projectId: 'p',
  label: 'S1',
  sortOrder: 0,
  expectedVocV: expVoc,
  measuredVocV: voc,
  expectedIscA: expIsc,
  measuredIscA: isc,
  polarityOk: polarity,
);

CommissioningRecord record({
  bool? polarity = true,
  double? insulation = 40,
  bool? grounding = true,
  bool? labeling = true,
}) => CommissioningRecord(
  id: 'c',
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
  projectId: 'p',
  status: CommissioningStatus.pending,
  polarityOk: polarity,
  insulationMohm: insulation,
  groundingOk: grounding,
  labelingOk: labeling,
);

void main() {
  test('desviación en % y tolerancias de Voc (±5 %) e Isc (±10 %)', () {
    expect(deviationPct(400, 380), closeTo(-5, 1e-9));
    expect(deviationPct(0, 10), isNull);
    expect(evaluateMeasurement(400, 380, 5), MeasurementVerdict.ok);
    expect(evaluateMeasurement(400, 379, 5), MeasurementVerdict.outOfRange);
    expect(evaluateMeasurement(null, 379, 5), MeasurementVerdict.incomplete);
    expect(evaluateString(string()), MeasurementVerdict.ok);
    expect(evaluateString(string(isc: 8.9)), MeasurementVerdict.outOfRange);
    expect(
      evaluateString(string(polarity: null)),
      MeasurementVerdict.incomplete,
    );
    expect(
      evaluateString(string(polarity: false)),
      MeasurementVerdict.outOfRange,
    );
  });

  test('aislamiento mínimo 1 MΩ', () {
    expect(evaluateInsulation(1), MeasurementVerdict.ok);
    expect(evaluateInsulation(0.8), MeasurementVerdict.outOfRange);
    expect(evaluateInsulation(null), MeasurementVerdict.incomplete);
  });

  test('estado sugerido', () {
    expect(suggestStatus(null, []), CommissioningStatus.pending);
    expect(suggestStatus(record(), []), CommissioningStatus.pending);
    expect(suggestStatus(record(), [string()]), CommissioningStatus.approved);
    expect(
      suggestStatus(record(insulation: 0.5), [string()]),
      CommissioningStatus.observations,
    );
    expect(
      suggestStatus(record(labeling: null), [string()]),
      CommissioningStatus.pending,
    );
    // Una falla manda aunque falten datos.
    expect(
      suggestStatus(record(labeling: null), [string(voc: 300)]),
      CommissioningStatus.observations,
    );
  });

  test('estado de la garantía', () {
    final today = DateTime(2026, 11, 14);
    expect(warrantyState(null, today), WarrantyState.unknown);
    expect(
      warrantyState(DateTime.utc(2026, 11, 13), today),
      WarrantyState.expired,
    );
    expect(
      warrantyState(DateTime.utc(2027, 1, 10), today),
      WarrantyState.expiringSoon,
    );
    expect(warrantyState(DateTime.utc(2036), today), WarrantyState.active);
  });
}
