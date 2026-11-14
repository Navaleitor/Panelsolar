import 'dart:io';

import 'package:data_sources/data_sources.dart';
import 'package:data_sources/src/cec/csv_lines.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

void main() {
  group('Catálogo CEC (NREL SAM)', () {
    final modules = CecParser.modules(fixture('cec_modules_sample.csv'));
    final inverters = CecParser.inverters(fixture('cec_inverters_sample.csv'));

    test('lee paneles y salta filas incompletas', () {
      expect(modules, hasLength(4));
      final a = modules.first;
      expect(a.manufacturer, 'Ablytek');
      expect(a.model, '6MN6A270');
      expect(a.technology, CecTechnology.mono);
      expect(
        (a.pmaxW, a.vocV, a.iscA, a.vmpV, a.impA),
        (270, 38.63, 9.34, 30.72, 8.81),
      );
      expect(a.betaVocPct, closeTo(-0.12118231 / 38.63 * 100, 1e-9));
      expect(a.gammaPmaxPct, -0.4509);
      expect(a.betaVmpPctEstimate, closeTo(-0.4509 - a.alphaIscPct, 1e-12));
      expect((a.lengthM, a.widthM, a.cells), (1.64, 0.992, 60));
      expect(modules[1].bifacial, isTrue);
      expect(modules[2].technology, CecTechnology.poly);
      expect(modules[3].technology, CecTechnology.thinFilm);
      expect(modules[3].lengthM, 0);
    });

    test('lee inversores, separa marca y modelo y detecta micros', () {
      expect(inverters, hasLength(3));
      final abb = inverters.first;
      expect(abb.manufacturer, 'ABB');
      expect(abb.model, 'PVI-30-OUTD-S-US-A {208V}');
      expect(
        (abb.pacW, abb.vdcMaxV, abb.mpptMinV, abb.mpptMaxV),
        (3000, 480, 100, 480),
      );
      expect(abb.efficiencyPct, closeTo(3000 / 3142.3 * 100, 1e-9));
      expect(abb.isMicro, isFalse);
      expect(inverters[1].isMicro, isTrue);
      expect(inverters[2].manufacturer, 'Comma, Inc');
    });

    test('búsqueda por palabras', () {
      final r = CecParser.search(modules, 'ably 270', (m) => m.name);
      expect(r.single.manufacturer, 'Ablytek');
      expect(CecParser.search(modules, '', (m) => m.name), hasLength(4));
      expect(
        CecParser.search(modules, '', (m) => m.name, limit: 2),
        hasLength(2),
      );
      expect(CecParser.search(modules, 'zzz', (m) => m.name), isEmpty);
      expect(CecParser.modules(''), isEmpty);
      expect(CecParser.inverters(''), isEmpty);
    });

    test('CSV con comillas', () {
      expect(splitCsvLine('a,"b, c","d ""e"""'), ['a', 'b, c', 'd "e"']);
    });
  });

  group('Descarga y caché', () {
    late Directory dir;
    setUp(() => dir = Directory.systemTemp.createTempSync('cec'));
    tearDown(() => dir.deleteSync(recursive: true));

    test('descarga una vez y luego lee de la caché', () async {
      var calls = 0;
      final client = MockClient((r) async {
        calls++;
        final name = r.url.path.contains('Modules')
            ? 'cec_modules_sample.csv'
            : 'cec_inverters_sample.csv';
        return http.Response(fixture(name), 200);
      });
      final c = CecCatalogClient(client: client, cacheDir: dir);
      expect(c.isCached, isFalse);
      final a = await c.load();
      expect(a.modules, hasLength(4));
      expect(c.isCached, isTrue);
      final b = await c.load();
      expect(b.inverters, hasLength(3));
      expect(calls, 2);
      await c.load(forceRefresh: true);
      expect(calls, 4);
      expect(CecCatalogClient.attribution, contains('CEC'));
    });

    test('error HTTP → DataSourceException', () async {
      final c = CecCatalogClient(
        client: MockClient((_) async => http.Response('no', 404)),
        cacheDir: dir,
      );
      expect(c.load(), throwsA(isA<DataSourceException>()));
    });
  });
}
