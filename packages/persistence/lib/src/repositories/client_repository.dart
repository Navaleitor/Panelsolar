import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `clients`: búsqueda, alta, edición y borrado lógico.
class ClientRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Clientes activos ordenados por nombre. Si [query] no está vacío, filtra
  /// por nombre, teléfono, correo o dirección (sin distinguir mayúsculas).
  Stream<List<Client>> watchActive({String query = ''}) {
    final select = _db.select(_db.clients)
      ..where((c) => c.deletedAt.isNull())
      ..orderBy([(c) => OrderingTerm.asc(c.name.collate(Collate.noCase))]);
    if (query.trim().isNotEmpty) {
      final pattern = likePattern(query);
      Expression<bool> like(GeneratedColumn<String> col) =>
          col.like(pattern, escapeChar: r'\');
      select.where(
        (c) => like(c.name) | like(c.phone) | like(c.email) | like(c.address),
      );
    }
    return select.watch();
  }

  /// Observa un cliente por `id` (también si está borrado).
  Stream<Client?> watchById(String id) => (_db.select(
    _db.clients,
  )..where((c) => c.id.equals(id))).watchSingleOrNull();

  /// Busca un cliente por `id` (también si está borrado).
  Future<Client?> findById(String id) => (_db.select(
    _db.clients,
  )..where((c) => c.id.equals(id))).getSingleOrNull();

  /// Da de alta un cliente y devuelve el registro completo.
  Future<Client> create({
    required String name,
    String? phone,
    String? email,
    String? address,
    String? notes,
  }) {
    return _db
        .into(_db.clients)
        .insertReturning(
          ClientsCompanion.insert(
            name: name.trim(),
            phone: Value(_blankToNull(phone)),
            email: Value(_blankToNull(email)),
            address: Value(_blankToNull(address)),
            notes: Value(_blankToNull(notes)),
          ),
        );
  }

  /// Reemplaza los datos de contacto y renueva `updatedAt`.
  Future<void> update(
    String id, {
    required String name,
    String? phone,
    String? email,
    String? address,
    String? notes,
  }) async {
    await (_db.update(_db.clients)..where((c) => c.id.equals(id))).write(
      ClientsCompanion(
        name: Value(name.trim()),
        phone: Value(_blankToNull(phone)),
        email: Value(_blankToNull(email)),
        address: Value(_blankToNull(address)),
        notes: Value(_blankToNull(notes)),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico del cliente **y** de sus proyectos y recibos, en una
  /// sola transacción. Nada se borra físicamente.
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await _db.transaction(() async {
      await (_db.update(_db.clients)..where((c) => c.id.equals(id))).write(
        ClientsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
      );
      await (_db.update(
        _db.projects,
      )..where((p) => p.clientId.equals(id) & p.deletedAt.isNull())).write(
        ProjectsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
      );
      await (_db.update(
        _db.utilityBills,
      )..where((b) => b.clientId.equals(id) & b.deletedAt.isNull())).write(
        UtilityBillsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
      );
    });
  }
}

String? _blankToNull(String? value) {
  final trimmed = value?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}
