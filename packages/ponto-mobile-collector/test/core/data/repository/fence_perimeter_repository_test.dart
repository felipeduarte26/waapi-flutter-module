import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

void main() {
  late CollectorDatabase database;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      database = CollectorDatabase(
        database: openConnection(),
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  test(
    'FencePerimeterRepository test.',
    () async {
      String fenceId1 = '0a824bb0-f869-416b-97c5-9a3a9abbe228';
      String perimeterId1 = 'a674851f-887e-425a-b88c-dbbe399d3d7e';
      String perimeterId2 = '79677ede-e429-41ae-a43a-2ed6af07ba90';

      FenceTableData fence1 = FenceTableData(
        id: fenceId1,
        name: 'fence1',
      );

      PerimeterTableData perimeter1 = PerimeterTableData(
        id: perimeterId1,
        type: clock.GeometricFormType.circle.name,
        latitude: 1.0,
        longitude: 2.0,
        radius: 3.0,
        dateAndTime: DateTime.now(),
      );

      PerimeterTableData perimeter2 = PerimeterTableData(
        id: perimeterId2,
        type: clock.GeometricFormType.circle.name,
        latitude: 4.0,
        longitude: 5.0,
        radius: 6.0,
        dateAndTime: DateTime.now(),
      );

      await database.into(database.fenceTable).insert(fence1);
      await database.into(database.perimeterTable).insert(perimeter1);
      await database.into(database.perimeterTable).insert(perimeter2);

      IFencePerimeterRepository repository =
          FencePerimeterRepository(database: database);

      bool exist = await repository.exist(
        fenceId: fenceId1,
        perimeterId: perimeterId1,
      );

      bool insertValue1 = await repository.save(
        fenceId: fenceId1,
        perimeterId: perimeterId1,
      );

      bool insertValue2 = await repository.save(
        fenceId: fenceId1,
        perimeterId: perimeterId2,
      );

      List<String> foundFencePerimeter =
          (await repository.findAllByFenceId(fenceId: fenceId1));

      List<FencePerimeterTableData> fencesPerimeter = await repository.getAll();

      bool updateSucess = await repository.save(
        fenceId: fenceId1,
        perimeterId: perimeterId1,
      );

      expect(exist, false);
      expect(insertValue1, true);
      expect(insertValue2, true);
      expect(updateSucess, true);
      expect(foundFencePerimeter[0], perimeterId1);
      expect(foundFencePerimeter[1], perimeterId2);
      expect(foundFencePerimeter.length, 2);
      expect(fencesPerimeter.length, 2);
    },
  );
}
