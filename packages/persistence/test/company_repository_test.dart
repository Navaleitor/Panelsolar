import 'package:drift/native.dart';
import 'package:persistence/persistence.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late CompanyRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = CompanyRepository(db);
  });

  tearDown(() => db.close());

  test('create asigna UUID v4 y fechas UTC', () async {
    final company = await repo.create(name: 'Solar del Norte');

    expect(
      company.id,
      matches(RegExp('^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-')),
    );
    expect(company.createdAt.isUtc, isTrue);
    expect(company.updatedAt.isUtc, isTrue);
    expect(company.deletedAt, isNull);
  });

  test('rename renueva updatedAt sin tocar createdAt', () async {
    final company = await repo.create(name: 'A');
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await repo.rename(company.id, 'B');

    final updated = await repo.findById(company.id);
    expect(updated!.name, 'B');
    expect(updated.createdAt, company.createdAt);
    expect(updated.updatedAt.isAfter(company.updatedAt), isTrue);
  });

  test('softDelete oculta el registro pero no lo borra', () async {
    final keep = await repo.create(name: 'Activa');
    final gone = await repo.create(name: 'Borrada');
    await repo.softDelete(gone.id);

    final active = await repo.listActive();
    expect(active.map((c) => c.id), [keep.id]);

    final stillStored = await repo.findById(gone.id);
    expect(stillStored, isNotNull);
    expect(stillStored!.deletedAt, isNotNull);
  });

  test('el esquema actual es la versión 3', () {
    expect(db.schemaVersion, 3);
  });
}
