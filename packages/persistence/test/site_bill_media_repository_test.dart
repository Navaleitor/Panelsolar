import 'package:drift/native.dart';
import 'package:persistence/persistence.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late Project project;
  late Client client;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    client = await ClientRepository(db).create(name: 'Ana');
    project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa',
      projectDate: DateTime.utc(2026),
    );
  });

  tearDown(() => db.close());

  group('SiteRepository', () {
    test('save crea y luego reemplaza el sitio del proyecto', () async {
      final repo = SiteRepository(db);
      expect(await repo.watchForProject(project.id).first, isNull);

      final first = await repo.save(
        projectId: project.id,
        latitude: 25.6866,
        longitude: -100.3161,
        source: LocationSource.gps,
        altitudeM: 540,
        timeZone: 'America/Monterrey',
        accuracyM: 8,
      );
      final second = await repo.save(
        projectId: project.id,
        latitude: 19.4326,
        longitude: -99.1332,
        source: LocationSource.mapLink,
        sourceText: 'https://maps.apple.com/?ll=19.4326,-99.1332',
      );

      expect(second.id, first.id);
      final site = await repo.watchForProject(project.id).first;
      expect(site!.latitude, 19.4326);
      expect(site.source, LocationSource.mapLink);
      expect(site.altitudeM, isNull);
    });

    test('rechaza coordenadas fuera de rango', () {
      final repo = SiteRepository(db);
      expect(
        () => repo.save(
          projectId: project.id,
          latitude: 91,
          longitude: 0,
          source: LocationSource.manual,
        ),
        throwsArgumentError,
      );
      expect(
        () => repo.save(
          projectId: project.id,
          latitude: 0,
          longitude: -181,
          source: LocationSource.manual,
        ),
        throwsArgumentError,
      );
    });
  });

  group('UtilityBillRepository', () {
    test('lista en orden cronológico y guarda importe en centavos', () async {
      final repo = UtilityBillRepository(db);
      await repo.create(
        clientId: client.id,
        periodStart: DateTime.utc(2026, 3),
        periodEnd: DateTime.utc(2026, 4, 30),
        billingPeriod: BillingPeriod.bimonthly,
        energyKwh: 620,
        amountCents: 154050,
        tariffCode: 'MX-CFE-1C',
      );
      await repo.create(
        clientId: client.id,
        periodStart: DateTime.utc(2026),
        periodEnd: DateTime.utc(2026, 2, 28),
        billingPeriod: BillingPeriod.bimonthly,
        energyKwh: 480,
      );
      final bills = await repo.watchByClient(client.id).first;
      expect(bills.map((b) => b.energyKwh), [480, 620]);
      expect(bills.last.amountCents, 154050);
      expect(bills.last.currency, 'MXN');
    });

    test('rechaza periodo invertido o kWh negativos', () {
      final repo = UtilityBillRepository(db);
      expect(
        () => repo.create(
          clientId: client.id,
          periodStart: DateTime.utc(2026, 3),
          periodEnd: DateTime.utc(2026, 2),
          billingPeriod: BillingPeriod.monthly,
          energyKwh: 1,
        ),
        throwsArgumentError,
      );
      expect(
        () => repo.create(
          clientId: client.id,
          periodStart: DateTime.utc(2026),
          periodEnd: DateTime.utc(2026, 1, 31),
          billingPeriod: BillingPeriod.monthly,
          energyKwh: -5,
        ),
        throwsArgumentError,
      );
    });

    test('update y softDelete', () async {
      final repo = UtilityBillRepository(db);
      final bill = await repo.create(
        clientId: client.id,
        periodStart: DateTime.utc(2026),
        periodEnd: DateTime.utc(2026, 1, 31),
        billingPeriod: BillingPeriod.monthly,
        energyKwh: 100,
      );
      await repo.update(
        bill.id,
        periodStart: DateTime.utc(2026),
        periodEnd: DateTime.utc(2026, 1, 31),
        billingPeriod: BillingPeriod.monthly,
        energyKwh: 150,
        tariffCode: 'MX-CFE-PDBT',
      );
      expect((await repo.findById(bill.id))!.energyKwh, 150);
      await repo.softDelete(bill.id);
      expect(await repo.watchByClient(client.id).first, isEmpty);
    });
  });

  group('PhotoRepository', () {
    test('filtra por etapa y detecta hash repetido', () async {
      final repo = PhotoRepository(db);
      await repo.add(
        projectId: project.id,
        stage: PhotoStage.survey,
        filePath: 'projects/p/photos/a.jpg',
        sha256: 'aaa',
        widthPx: 1600,
        heightPx: 1200,
        latitude: 25.7,
        longitude: -100.3,
      );
      final b = await repo.add(
        projectId: project.id,
        stage: PhotoStage.installation,
        filePath: 'projects/p/photos/b.jpg',
        sha256: 'bbb',
        widthPx: 1200,
        heightPx: 1600,
      );

      expect(await repo.watchByProject(project.id).first, hasLength(2));
      final survey = await repo
          .watchByProject(project.id, stage: PhotoStage.survey)
          .first;
      expect(survey.single.latitude, 25.7);
      expect(await repo.existsHash(project.id, 'aaa'), isTrue);
      expect(await repo.existsHash(project.id, 'zzz'), isFalse);

      await repo.updateCaption(b.id, '  Inversor  ');
      final installation = await repo
          .watchByProject(project.id, stage: PhotoStage.installation)
          .first;
      expect(installation.single.caption, 'Inversor');

      await repo.softDelete(b.id);
      expect(await repo.existsHash(project.id, 'bbb'), isFalse);
      expect(await repo.watchByProject(project.id).first, hasLength(1));
    });
  });

  group('DocumentRepository', () {
    test('add, rename y softDelete', () async {
      final repo = DocumentRepository(db);
      final doc = await repo.add(
        projectId: project.id,
        title: 'Contrato.pdf',
        kind: DocumentKind.pdf,
        filePath: 'projects/p/documents/x.pdf',
        mimeType: 'application/pdf',
        sizeBytes: 2048,
        sha256: 'ccc',
      );
      await repo.rename(doc.id, ' Contrato firmado ');
      final list = await repo.watchByProject(project.id).first;
      expect(list.single.title, 'Contrato firmado');
      expect(list.single.kind, DocumentKind.pdf);

      await repo.softDelete(doc.id);
      expect(await repo.watchByProject(project.id).first, isEmpty);
    });
  });
}
