import 'package:drift/native.dart';
import 'package:persistence/persistence.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late ClientRepository clients;
  late ProjectRepository projects;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    clients = ClientRepository(db);
    projects = ProjectRepository(db);
  });

  tearDown(() => db.close());

  group('ClientRepository', () {
    test('create limpia espacios y convierte vacíos en null', () async {
      final c = await clients.create(name: '  Ana López ', phone: '  ');
      expect(c.name, 'Ana López');
      expect(c.phone, isNull);
      expect(c.deletedAt, isNull);
    });

    test('watchActive ordena por nombre sin distinguir mayúsculas', () async {
      await clients.create(name: 'beto');
      await clients.create(name: 'Ana');
      await clients.create(name: 'Carlos');
      final list = await clients.watchActive().first;
      expect(list.map((c) => c.name), ['Ana', 'beto', 'Carlos']);
    });

    test(
      'la búsqueda filtra por nombre, teléfono, correo o dirección',
      () async {
        await clients.create(name: 'Ana López', phone: '8112345678');
        await clients.create(name: 'Beto', email: 'beto@solar.mx');
        await clients.create(name: 'Carla', address: 'Av. Constitución 100');

        Future<List<String>> search(String q) async =>
            (await clients.watchActive(query: q).first)
                .map((c) => c.name)
                .toList();

        expect(await search('lópez'), ['Ana López']);
        expect(await search('1234'), ['Ana López']);
        expect(await search('SOLAR.MX'), ['Beto']);
        expect(await search('constitución'), ['Carla']);
        expect(await search('%'), isEmpty);
      },
    );

    test('update renueva updatedAt', () async {
      final c = await clients.create(name: 'Ana');
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await clients.update(c.id, name: 'Ana María', email: 'ana@x.mx');
      final updated = await clients.findById(c.id);
      expect(updated!.name, 'Ana María');
      expect(updated.email, 'ana@x.mx');
      expect(updated.updatedAt.isAfter(c.updatedAt), isTrue);
    });

    test('softDelete oculta al cliente y a sus proyectos y recibos', () async {
      final c = await clients.create(name: 'Ana');
      await projects.create(
        clientId: c.id,
        name: 'Casa',
        projectDate: DateTime.utc(2026),
      );
      await UtilityBillRepository(db).create(
        clientId: c.id,
        periodStart: DateTime.utc(2026),
        periodEnd: DateTime.utc(2026, 2, 28),
        billingPeriod: BillingPeriod.bimonthly,
        energyKwh: 500,
      );

      await clients.softDelete(c.id);

      expect(await clients.watchActive().first, isEmpty);
      expect(await projects.watchByClient(c.id).first, isEmpty);
      expect(
        await UtilityBillRepository(db).watchByClient(c.id).first,
        isEmpty,
      );
      expect((await clients.findById(c.id))!.deletedAt, isNotNull);
    });
  });

  group('ProjectRepository', () {
    late Client ana;
    late Client beto;

    setUp(() async {
      ana = await clients.create(name: 'Ana');
      beto = await clients.create(name: 'Beto');
    });

    test('create usa estado prospecto por defecto', () async {
      final p = await projects.create(
        clientId: ana.id,
        name: 'Casa',
        projectDate: DateTime.utc(2026, 5),
      );
      expect(p.status, ProjectStatus.prospect);
      expect(p.projectDate, DateTime.utc(2026, 5));
    });

    test('un cliente puede tener varios proyectos', () async {
      await projects.create(
        clientId: ana.id,
        name: 'Casa',
        projectDate: DateTime.utc(2026),
      );
      await projects.create(
        clientId: ana.id,
        name: 'Negocio',
        projectDate: DateTime.utc(2026, 6),
      );
      final list = await projects.watchByClient(ana.id).first;
      expect(list.map((p) => p.name), ['Negocio', 'Casa']);
    });

    test('watchActive une el cliente y filtra por estado y texto', () async {
      final p1 = await projects.create(
        clientId: ana.id,
        name: 'Casa Cumbres',
        projectDate: DateTime.utc(2026),
      );
      await projects.create(
        clientId: beto.id,
        name: 'Bodega',
        projectDate: DateTime.utc(2026, 2),
        status: ProjectStatus.quoted,
      );

      final all = await projects.watchActive().first;
      expect(all.map((e) => e.project.name), ['Bodega', 'Casa Cumbres']);
      expect(all.last.client.name, 'Ana');

      final quoted = await projects
          .watchActive(status: ProjectStatus.quoted)
          .first;
      expect(quoted.map((e) => e.project.name), ['Bodega']);

      final byClient = await projects.watchActive(query: 'ana').first;
      expect(byClient.single.project.id, p1.id);
    });

    test('update cambia estado y fecha; softDelete lo oculta', () async {
      final p = await projects.create(
        clientId: ana.id,
        name: 'Casa',
        projectDate: DateTime.utc(2026),
      );
      await projects.update(
        p.id,
        name: 'Casa',
        status: ProjectStatus.installed,
        projectDate: DateTime.utc(2026, 9, 15),
      );
      final updated = await projects.findById(p.id);
      expect(updated!.status, ProjectStatus.installed);
      expect(updated.projectDate, DateTime.utc(2026, 9, 15));

      await projects.softDelete(p.id);
      expect(await projects.watchActive().first, isEmpty);
    });

    test('rechaza un proyecto de un cliente inexistente', () async {
      await expectLater(
        projects.create(
          clientId: 'no-existe',
          name: 'X',
          projectDate: DateTime.utc(2026),
        ),
        throwsA(isA<SqliteException>()),
      );
    });
  });
}
