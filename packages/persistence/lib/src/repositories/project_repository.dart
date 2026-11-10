import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Un proyecto junto con su cliente (para listas).
class ProjectWithClient {
  /// Agrupa un [project] con su [client].
  const new(this.project, this.client);

  /// El proyecto.
  final Project project;

  /// Su cliente.
  final Client client;
}

/// Acceso a `projects`: alta, edición, estado y borrado lógico.
class ProjectRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Proyectos activos (de clientes activos), del más reciente al más
  /// antiguo. Filtros opcionales por [status] y por texto [query] (nombre
  /// del proyecto o del cliente).
  Stream<List<ProjectWithClient>> watchActive({
    ProjectStatus? status,
    String query = '',
  }) {
    final p = _db.projects;
    final c = _db.clients;
    final select =
        _db.select(p).join([innerJoin(c, c.id.equalsExp(p.clientId))])
          ..where(p.deletedAt.isNull() & c.deletedAt.isNull())
          ..orderBy([OrderingTerm.desc(p.projectDate)]);
    if (status != null) {
      select.where(p.status.equalsValue(status));
    }
    if (query.trim().isNotEmpty) {
      final pattern = likePattern(query);
      select.where(
        p.name.like(pattern, escapeChar: r'\') |
            c.name.like(pattern, escapeChar: r'\'),
      );
    }
    return select.watch().map(
      (rows) => [
        for (final row in rows)
          ProjectWithClient(row.readTable(p), row.readTable(c)),
      ],
    );
  }

  /// Proyectos activos de un cliente, del más reciente al más antiguo.
  Stream<List<Project>> watchByClient(String clientId) {
    final select = _db.select(_db.projects)
      ..where((p) => p.clientId.equals(clientId) & p.deletedAt.isNull())
      ..orderBy([(p) => OrderingTerm.desc(p.projectDate)]);
    return select.watch();
  }

  /// Observa un proyecto por `id` (también si está borrado).
  Stream<Project?> watchById(String id) => (_db.select(
    _db.projects,
  )..where((p) => p.id.equals(id))).watchSingleOrNull();

  /// Busca un proyecto por `id` (también si está borrado).
  Future<Project?> findById(String id) => (_db.select(
    _db.projects,
  )..where((p) => p.id.equals(id))).getSingleOrNull();

  /// Da de alta un proyecto para [clientId].
  Future<Project> create({
    required String clientId,
    required String name,
    required DateTime projectDate,
    ProjectStatus status = ProjectStatus.prospect,
    String? notes,
  }) {
    return _db
        .into(_db.projects)
        .insertReturning(
          ProjectsCompanion.insert(
            clientId: clientId,
            name: name.trim(),
            projectDate: projectDate.toUtc(),
            status: Value(status),
            notes: Value(_blankToNull(notes)),
          ),
        );
  }

  /// Reemplaza los datos editables del proyecto y renueva `updatedAt`.
  Future<void> update(
    String id, {
    required String name,
    required ProjectStatus status,
    required DateTime projectDate,
    String? notes,
  }) async {
    await (_db.update(_db.projects)..where((p) => p.id.equals(id))).write(
      ProjectsCompanion(
        name: Value(name.trim()),
        status: Value(status),
        projectDate: Value(projectDate.toUtc()),
        notes: Value(_blankToNull(notes)),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico del proyecto.
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await (_db.update(_db.projects)..where((p) => p.id.equals(id))).write(
      ProjectsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }
}

String? _blankToNull(String? value) {
  final trimmed = value?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}
