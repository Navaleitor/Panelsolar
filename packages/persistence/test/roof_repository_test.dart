import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:persistence/persistence.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late String projectId;

  setUp(() async {
    db = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    final client = await ClientRepository(db).create(name: 'Ana');
    projectId = (await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa',
      projectDate: DateTime.utc(2026, 11, 14),
    )).id;
  });

  tearDown(() => db.close());

  group('RoofImageRepository', () {
    test('imagen → calibración → norte; una imagen nueva los borra', () async {
      final repo = RoofImageRepository(db);
      expect(await repo.getForProject(projectId), isNull);
      await repo.saveImage(
        projectId: projectId,
        filePath: 'projects/p/roof/a.jpg',
        sha256: 'aa',
        widthPx: 2000,
        heightPx: 1500,
      );
      await repo.saveCalibration(
        projectId: projectId,
        metersPerPixel: 0.025,
        calibrationLine: '{"a":[0,0],"b":[400,0],"m":10}',
      );
      final north = await repo.saveNorth(
        projectId: projectId,
        northAngleDeg: 372,
        source: NorthSource.compass,
        magneticDeclinationDeg: 4.4,
      );
      expect(north.mode, RoofMode.image);
      expect(north.metersPerPixel, 0.025);
      expect(north.northAngleDeg, 12);
      expect(north.northSource, NorthSource.compass);

      final replaced = await repo.saveImage(
        projectId: projectId,
        filePath: 'projects/p/roof/b.jpg',
        sha256: 'bb',
        widthPx: 1000,
        heightPx: 1000,
      );
      expect(replaced.id, north.id);
      expect(replaced.metersPerPixel, isNull);
      expect(replaced.northSource, NorthSource.imageUp);
      expect(
        () => repo.saveCalibration(
          projectId: projectId,
          metersPerPixel: 0,
          calibrationLine: '{}',
        ),
        throwsArgumentError,
      );
    });

    test('modo croquis sin imagen', () async {
      final r = await RoofImageRepository(db).startSketch(projectId);
      expect(r.mode, RoofMode.sketch);
      expect(r.filePath, isNull);
      expect(r.northAngleDeg, 0);
    });
  });

  group('RoofPlaneRepository', () {
    test('alta, edición, orden y borrado lógico', () async {
      final repo = RoofPlaneRepository(db);
      final a = await repo.add(
        projectId: projectId,
        name: ' Agua sur ',
        polygon: '[[0,0],[10,0],[10,4],[0,4]]',
        tiltDeg: 15,
        tiltSource: TiltSource.inclinometer,
      );
      await repo.add(projectId: projectId, name: 'Agua norte', polygon: '[]');
      expect(a.name, 'Agua sur');
      await repo.update(
        a.copyWith(
          edgeSetbackM: 0.5,
          walkways: '[{"a":[0,2],"b":[10,2],"w":0.6}]',
        ),
      );
      final list = await repo.listByProject(projectId);
      expect(list.map((p) => p.name), ['Agua sur', 'Agua norte']);
      expect(list.first.edgeSetbackM, 0.5);
      expect(list.first.tiltSource, TiltSource.inclinometer);
      await repo.softDelete(a.id);
      expect(await repo.listByProject(projectId), hasLength(1));
      expect(
        () => repo.add(
          projectId: projectId,
          name: 'x',
          polygon: '[]',
          tiltDeg: 90,
        ),
        throwsArgumentError,
      );
    });
  });

  group('ObstacleRepository', () {
    test('tinaco de 1100 L', () async {
      final repo = ObstacleRepository(db);
      final o = await repo.add(
        projectId: projectId,
        kind: ObstacleKind.waterTank,
        outline: ObstacleOutline.circle,
        centerX: 3,
        centerY: 2,
        widthM: 1.1,
        heightM: 1.7,
        heightSource: HeightSource.typical,
        tankLiters: 1100,
      );
      await repo.update(
        o.copyWith(heightM: 1.85, heightSource: HeightSource.tape),
      );
      final list = await repo.listByProject(projectId);
      expect(list.single.heightM, 1.85);
      expect(list.single.tankLiters, 1100);
      await repo.softDelete(o.id);
      expect(await repo.listByProject(projectId), isEmpty);
      expect(
        () => repo.add(
          projectId: projectId,
          kind: ObstacleKind.antenna,
          outline: ObstacleOutline.point,
          widthM: 0,
          heightM: 3,
          heightSource: HeightSource.typical,
        ),
        throwsArgumentError,
      );
    });
  });

  group('HorizonProfileRepository', () {
    test('un solo terreno por proyecto y varios obstáculos lejanos', () async {
      final repo = HorizonProfileRepository(db);
      final t1 = await repo.saveTerrain(
        projectId: projectId,
        points: '[[0,1]]',
      );
      final t2 = await repo.saveTerrain(
        projectId: projectId,
        points: '[[0,2]]',
      );
      expect(t2.id, t1.id);
      expect(t2.points, '[[0,2]]');
      final tree = await repo.addManual(
        projectId: projectId,
        name: 'Árbol',
        points: '[[170,20],[190,20]]',
      );
      await repo.updatePoints(tree.id, '[[170,25],[190,25]]');
      final list = await repo.listByProject(projectId);
      expect(list.map((h) => h.source), [
        HorizonSource.terrain,
        HorizonSource.manual,
      ]);
      expect(list.last.points, '[[170,25],[190,25]]');
      await repo.softDelete(tree.id);
      expect(await repo.listByProject(projectId), hasLength(1));
    });
  });
}
