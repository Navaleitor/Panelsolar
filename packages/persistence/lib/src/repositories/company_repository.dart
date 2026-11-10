import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';

/// Acceso a la tabla `companies` respetando las convenciones base:
/// `updatedAt` se renueva en cada cambio y el borrado es lógico.
class CompanyRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Inserta una empresa nueva y devuelve su registro completo.
  Future<Company> create({required String name, String? phone, String? email}) {
    return _db
        .into(_db.companies)
        .insertReturning(
          CompaniesCompanion.insert(
            name: name,
            phone: Value(phone),
            email: Value(email),
          ),
        );
  }

  /// Empresas activas (sin borrado lógico), ordenadas por nombre.
  Future<List<Company>> listActive() {
    final query = _db.select(_db.companies)
      ..where((c) => c.deletedAt.isNull())
      ..orderBy([(c) => OrderingTerm.asc(c.name)]);
    return query.get();
  }

  /// Busca por `id`, incluidas las borradas lógicamente.
  Future<Company?> findById(String id) {
    final query = _db.select(_db.companies)..where((c) => c.id.equals(id));
    return query.getSingleOrNull();
  }

  /// Cambia el nombre y renueva `updatedAt`.
  Future<void> rename(String id, String name) async {
    await (_db.update(_db.companies)..where((c) => c.id.equals(id))).write(
      CompaniesCompanion(name: Value(name), updatedAt: Value(_now())),
    );
  }

  /// Borrado lógico: marca `deletedAt` y renueva `updatedAt`.
  Future<void> softDelete(String id) async {
    final now = _now();
    await (_db.update(_db.companies)..where((c) => c.id.equals(id))).write(
      CompaniesCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  DateTime _now() => DateTime.now().toUtc();
}
