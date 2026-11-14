/// Agrupa valores horarios por (año, mes) en hora estándar local y calcula
/// el "mes típico": el promedio de los meses completos de cada mes del año.
///
/// Un mes cuenta como completo si tiene al menos el 90 % de sus horas. Así
/// una serie de 5 años da el promedio de los 5 eneros, y un TMY (cada mes de
/// un año distinto) da cada mes tal cual, aunque el corrimiento de zona
/// horaria deje unas pocas horas sueltas en otro año.
class MonthlyAggregator {
  /// Crea el agregador para registros de [stepHours] horas.
  new({this.stepHours = 1});

  /// Duración de cada registro (h).
  final double stepHours;

  final Map<int, _Bucket> _buckets = {};

  /// Agrega [value] al mes local de [localTime]. Los `NaN` se ignoran.
  void add(DateTime localTime, double value) {
    if (value.isNaN) return;
    final key = localTime.year * 100 + localTime.month;
    (_buckets[key] ??= _Bucket()).add(value);
  }

  bool _isComplete(int key, _Bucket b) {
    final year = key ~/ 100;
    final month = key % 100;
    final days = DateTime.utc(year, month + 1, 0).day;
    return b.count * stepHours >= 0.9 * days * 24;
  }

  /// Claves (año·100 + mes) de los meses completos, ordenadas.
  List<int> get completeMonthKeys =>
      _buckets.entries
          .where((e) => _isComplete(e.key, e.value))
          .map((e) => e.key)
          .toList()
        ..sort();

  /// Suma del mes [key] (año·100 + mes), o nulo si no existe.
  double? sumOf(int key) => _buckets[key]?.sum;

  /// Mínimo del mes [key].
  double? minOf(int key) => _buckets[key]?.min;

  /// Máximo del mes [key].
  double? maxOf(int key) => _buckets[key]?.max;

  /// Promedio, para cada mes del año (índice 0 = enero), de la suma de los
  /// meses completos. `NaN` si un mes no tiene ningún dato completo.
  List<double> typicalMonthlySums() => _typical((b) => b.sum);

  /// Igual que [typicalMonthlySums] pero con el promedio de los valores.
  List<double> typicalMonthlyMeans() => _typical((b) => b.sum / b.count);

  List<double> _typical(double Function(_Bucket) f) {
    final acc = List<double>.filled(12, 0);
    final counts = List<int>.filled(12, 0);
    for (final e in _buckets.entries) {
      if (!_isComplete(e.key, e.value)) continue;
      final m = e.key % 100 - 1;
      acc[m] += f(e.value);
      counts[m]++;
    }
    return [
      for (var m = 0; m < 12; m++)
        if (counts[m] == 0) double.nan else acc[m] / counts[m],
    ];
  }

  /// Sumas por año calendario, solo para años con los 12 meses completos.
  Map<int, double> completeYearSums() {
    final byYear = <int, List<double>>{};
    for (final key in completeMonthKeys) {
      (byYear[key ~/ 100] ??= []).add(_buckets[key]!.sum);
    }
    return {
      for (final e in byYear.entries)
        if (e.value.length == 12) e.key: e.value.reduce((a, b) => a + b),
    };
  }
}

class _Bucket {
  double sum = 0;
  int count = 0;
  double min = double.infinity;
  double max = double.negativeInfinity;

  void add(double v) {
    sum += v;
    count++;
    if (v < min) min = v;
    if (v > max) max = v;
  }
}
