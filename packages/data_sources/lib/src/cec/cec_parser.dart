import 'package:data_sources/src/cec/cec_records.dart';
import 'package:data_sources/src/cec/csv_lines.dart';

/// Lee los CSV del catálogo CEC que publica NREL SAM (`CEC Modules.csv` y
/// `CEC Inverters.csv`, licencia BSD-3 de SAM; datos públicos de la
/// California Energy Commission). Las 3 primeras líneas son encabezado,
/// unidades y nombres internos de SAM. Las filas incompletas se saltan.
abstract final class CecParser {
  /// Paneles.
  static List<CecModule> modules(String csv) {
    final rows = _rows(csv);
    if (rows.isEmpty) return const [];
    final h = _index(rows.first);
    final out = <CecModule>[];
    for (final r in rows.skip(3)) {
      double n(String k) => _num(r, h[k]);
      final voc = n('V_oc_ref');
      final isc = n('I_sc_ref');
      final pmax = n('STC');
      final vmp = n('V_mp_ref');
      final imp = n('I_mp_ref');
      if ([voc, isc, pmax, vmp, imp].any((v) => !(v > 0)) || vmp >= voc) {
        continue;
      }
      out.add(
        CecModule(
          name: _str(r, h['Name']),
          manufacturer: _str(r, h['Manufacturer']),
          technology: _technology(_str(r, h['Technology'])),
          bifacial: _str(r, h['Bifacial']) == '1',
          pmaxW: pmax,
          vocV: voc,
          iscA: isc,
          vmpV: vmp,
          impA: imp,
          betaVocPct: n('beta_oc') / voc * 100,
          alphaIscPct: n('alpha_sc') / isc * 100,
          gammaPmaxPct: n('gamma_pmp').isNaN ? -0.35 : n('gamma_pmp'),
          lengthM: n('Length').isNaN ? 0 : n('Length'),
          widthM: n('Width').isNaN ? 0 : n('Width'),
          cells: n('N_s').isNaN ? 0 : n('N_s').round(),
        ),
      );
    }
    return out;
  }

  /// Inversores.
  static List<CecInverter> inverters(String csv) {
    final rows = _rows(csv);
    if (rows.isEmpty) return const [];
    final h = _index(rows.first);
    final out = <CecInverter>[];
    for (final r in rows.skip(3)) {
      double n(String k) => _num(r, h[k]);
      final pac = n('Paco');
      final vmax = n('Vdcmax');
      final lo = n('Mppt_low');
      final hi = n('Mppt_high');
      if (!(pac > 0) || !(vmax > 0) || !(hi > lo)) continue;
      final name = _str(r, h['Name']);
      final colon = name.indexOf(':');
      final maker = colon < 0 ? name : name.substring(0, colon).trim();
      final model = colon < 0 ? name : name.substring(colon + 1).trim();
      out.add(
        CecInverter(
          name: name,
          manufacturer: maker,
          model: model,
          acVoltageV: n('Vac').isNaN ? 240 : n('Vac'),
          pacW: pac,
          pdcW: n('Pdco'),
          vdcMaxV: vmax,
          idcMaxA: n('Idcmax'),
          mpptMinV: lo,
          mpptMaxV: hi,
        ),
      );
    }
    return out;
  }

  /// Filtra por texto (todas las palabras, sin distinguir mayúsculas).
  static List<T> search<T>(
    List<T> items,
    String query,
    String Function(T) text, {
    int limit = 50,
  }) {
    final words = query.toLowerCase().split(RegExp(r'\s+'))
      ..removeWhere((w) => w.isEmpty);
    final out = <T>[];
    for (final it in items) {
      final t = text(it).toLowerCase();
      if (words.every(t.contains)) {
        out.add(it);
        if (out.length >= limit) break;
      }
    }
    return out;
  }

  static List<List<String>> _rows(String csv) => [
    for (final line in csv.split(RegExp(r'\r?\n')))
      if (line.trim().isNotEmpty) splitCsvLine(line),
  ];

  static Map<String, int> _index(List<String> header) => {
    for (final (i, k) in header.indexed) k.trim(): i,
  };

  static String _str(List<String> r, int? i) =>
      i == null || i >= r.length ? '' : r[i].trim();

  static double _num(List<String> r, int? i) =>
      double.tryParse(_str(r, i)) ?? double.nan;

  static CecTechnology _technology(String t) {
    final s = t.toLowerCase();
    if (s.contains('mono')) return CecTechnology.mono;
    if (s.contains('multi') || s.contains('poly')) return CecTechnology.poly;
    if (s.contains('cdte') ||
        s.contains('cigs') ||
        s.contains('a-si') ||
        s.contains('thin')) {
      return CecTechnology.thinFilm;
    }
    return CecTechnology.other;
  }
}
