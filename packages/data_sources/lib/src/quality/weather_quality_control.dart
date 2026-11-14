import 'dart:math' as math;
import 'dart:typed_data';

import 'package:data_sources/src/quality/component_closure.dart';
import 'package:data_sources/src/quality/quality_report.dart';
import 'package:solar_engine/solar_engine.dart';

/// Control de calidad de series meteorológicas (plan B.5):
/// huecos, valores negativos, GHI mayor que la extraterrestre y cierre de
/// componentes (GHI = DNI·cos θz + DHI).
abstract final class WeatherQualityControl {
  /// Tolerancia sobre la extraterrestre horizontal (W/m²).
  static const double extraterrestrialTolerance = 5;

  /// Revisa y limpia [series]. Si la serie es cronológica, primero rellena
  /// las horas que falten. Devuelve la serie limpia y el informe.
  static ({WeatherSeries series, QualityReport report}) check(
    WeatherSeries series,
    Site site,
  ) {
    final grid = _regularize(series);
    final s = grid.series;
    final n = s.length;
    final step = s.stepMinutes * 60;
    // Coseno del cenit en los bordes (n + 1) y a la mitad de cada hora.
    final edgeCos = Float64List(n + 1);
    final midCos = Float64List(n);
    final dniExtra = Float64List(n);
    double cosAt(int epoch) => cosd(
      Spa.compute(
        timeUtc: DateTime.fromMillisecondsSinceEpoch(epoch * 1000, isUtc: true),
        latitude: site.latitude,
        longitude: site.longitude,
        elevation: site.elevation,
        pressureHpa: site.pressureHpa,
        temperatureC: site.meanTemperatureC,
      ).apparentZenith,
    );
    for (var i = 0; i <= n; i++) {
      final start = i < n
          ? s.startEpochSeconds[i]
          : s.startEpochSeconds[n - 1] + step;
      edgeCos[i] = cosAt(start);
      if (i < n) {
        midCos[i] = cosAt(start + s.sampleOffsetMinutes * 60);
        dniExtra[i] = extraterrestrialNormal(dayOfYear(s.sampleTimeUtc(i)));
      }
    }
    final missing = <String, int>{};
    var negatives = 0;
    var aboveExtra = 0;
    final ghi = Float64List.fromList(s.ghi);
    final dni = Float64List.fromList(s.dni);
    final dhi = Float64List.fromList(s.dhi);
    final temp = Float64List.fromList(s.tempAir);
    final wind = Float64List.fromList(s.windSpeed);
    bool night(int i) => edgeCos[i] <= 0 && edgeCos[i + 1] <= 0;
    for (final (name, col) in [('ghi', ghi), ('dni', dni), ('dhi', dhi)]) {
      missing[name] = _fillIrradiance(col, night);
      for (var i = 0; i < n; i++) {
        if (col[i] < 0) {
          col[i] = 0;
          negatives++;
        }
      }
    }
    for (var i = 0; i < n; i++) {
      final maxCos = math.max(math.max(edgeCos[i], edgeCos[i + 1]), midCos[i]);
      final limit =
          dniExtra[i] * math.max(0, maxCos) + extraterrestrialTolerance;
      if (ghi[i] > limit) {
        ghi[i] = limit;
        aboveExtra++;
      }
    }
    final closed = closeIrradianceComponents(
      ghi: ghi,
      dni: dni,
      dhi: dhi,
      cosZenith: midCos,
      dniExtra: dniExtra,
    );
    missing['tempAir'] = _interpolate(temp);
    missing['windSpeed'] = _interpolate(wind);
    for (var i = 0; i < n; i++) {
      if (wind[i] < 0) {
        wind[i] = 0;
        negatives++;
      }
    }
    final albedo = s.albedo == null ? null : _fillWithMean(s.albedo!);
    final cleaned = WeatherSeries(
      startEpochSeconds: s.startEpochSeconds,
      ghi: ghi,
      dni: dni,
      dhi: dhi,
      tempAir: temp,
      windSpeed: wind,
      albedo: albedo,
      stepMinutes: s.stepMinutes,
      sampleOffsetMinutes: s.sampleOffsetMinutes,
    );
    return (
      series: cleaned,
      report: QualityReport(
        records: n,
        missingRecords: grid.added,
        missingValues: missing,
        negativeValues: negatives,
        ghiAboveExtraterrestrial: aboveExtra,
        componentsClosed: closed,
      ),
    );
  }

  /// Compara la irradiación global horizontal anual y la temperatura
  /// media (año típico) de dos series del mismo sitio.
  static CrossSourceCheck compareAnnual(
    WeatherSeries primary,
    WeatherSeries reference,
    Site site, {
    double threshold = 10,
  }) {
    final p = ClimateStatistics.compute(site, primary).annual;
    final r = ClimateStatistics.compute(site, reference).annual;
    return CrossSourceCheck(
      primaryAnnualGhi: p.irradiation,
      referenceAnnualGhi: r.irradiation,
      primaryMeanTemp: p.tempMean,
      referenceMeanTemp: r.tempMean,
      threshold: threshold,
    );
  }

  /// Si la serie es cronológica con paso fijo, inserta las horas faltantes
  /// (con `NaN`). Las series no cronológicas (TMY) se dejan igual.
  static ({WeatherSeries series, int added}) _regularize(WeatherSeries s) {
    final step = s.stepMinutes * 60;
    final t = s.startEpochSeconds;
    for (var i = 1; i < t.length; i++) {
      if (t[i] <= t[i - 1]) return (series: s, added: 0);
    }
    if (t.isEmpty) return (series: s, added: 0);
    final n = (t.last - t.first) ~/ step + 1;
    if (n == t.length) return (series: s, added: 0);
    final epochs = [for (var i = 0; i < n; i++) t.first + i * step];
    Float64List spread(Float64List src) {
      final out = Float64List(n)..fillRange(0, n, double.nan);
      for (var i = 0; i < t.length; i++) {
        out[(t[i] - t.first) ~/ step] = src[i];
      }
      return out;
    }

    return (
      series: WeatherSeries(
        startEpochSeconds: epochs,
        ghi: spread(s.ghi),
        dni: spread(s.dni),
        dhi: spread(s.dhi),
        tempAir: spread(s.tempAir),
        windSpeed: spread(s.windSpeed),
        albedo: s.albedo == null ? null : spread(s.albedo!),
        stepMinutes: s.stepMinutes,
        sampleOffsetMinutes: s.sampleOffsetMinutes,
      ),
      added: n - t.length,
    );
  }

  /// Rellena irradiancia: de noche 0; de día el promedio de la misma hora
  /// del día anterior y siguiente; si no hay, interpolación lineal.
  static int _fillIrradiance(Float64List v, bool Function(int) isNight) {
    var count = 0;
    final missing = <int>[];
    for (var i = 0; i < v.length; i++) {
      if (!v[i].isNaN) continue;
      count++;
      if (isNight(i)) {
        v[i] = 0;
        continue;
      }
      final prev = i >= 24 ? v[i - 24] : double.nan;
      final next = i + 24 < v.length ? v[i + 24] : double.nan;
      final valid = [prev, next].where((x) => !x.isNaN).toList();
      if (valid.isNotEmpty) {
        v[i] = valid.reduce((a, b) => a + b) / valid.length;
      } else {
        missing.add(i);
      }
    }
    if (missing.isNotEmpty) _interpolate(v);
    return count;
  }

  /// Interpolación lineal entre vecinos válidos; extremos con el vecino más
  /// cercano. Devuelve cuántos valores se rellenaron.
  static int _interpolate(Float64List v) {
    var count = 0;
    var lastValid = -1;
    for (var i = 0; i <= v.length; i++) {
      if (i < v.length && v[i].isNaN) continue;
      final gap = i - lastValid - 1;
      if (gap > 0) {
        count += gap;
        for (var k = lastValid + 1; k < i; k++) {
          if (lastValid < 0 && i >= v.length) {
            v[k] = 0;
          } else if (lastValid < 0) {
            v[k] = v[i];
          } else if (i >= v.length) {
            v[k] = v[lastValid];
          } else {
            final f = (k - lastValid) / (i - lastValid);
            v[k] = v[lastValid] + (v[i] - v[lastValid]) * f;
          }
        }
      }
      lastValid = i;
    }
    return count;
  }

  static Float64List _fillWithMean(Float64List v) {
    final valid = v.where((x) => !x.isNaN && x >= 0 && x <= 1);
    final mean = valid.isEmpty
        ? double.nan
        : valid.reduce((a, b) => a + b) / valid.length;
    return Float64List.fromList([
      for (final x in v)
        if (x.isNaN || x < 0 || x > 1) mean else x,
    ]);
  }
}
