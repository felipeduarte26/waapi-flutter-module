import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/fence.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/perimeter.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/geometric_form_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/location_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

class MockFencePerimeterRepository extends Mock
    implements IFencePerimeterRepository {}

class MockPerimeterRepository extends Mock implements IPerimeterRepository {}

class MockEmployeeFenceRepository extends Mock
    implements IEmployeeFenceRepository {}

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
    'FenceRepository test.',
    () async {
      IFencePerimeterRepository mockFencePerimeterRepository =
          MockFencePerimeterRepository();

      IPerimeterRepository mockPerimeterRepository = MockPerimeterRepository();

      IEmployeeFenceRepository mockEmployeeFenceRepository =
          MockEmployeeFenceRepository();

      IFenceRepository repository = FenceRepository(
        database: database,
        employeeFenceRepository: mockEmployeeFenceRepository,
        perimeterRepository: mockPerimeterRepository,
        fencePerimeterRepository: mockFencePerimeterRepository,
      );

      LocationDto location = LocationDto(
        latitude: 123,
        longitude: 321,
        dateAndTime: DateTime.now(),
      );

      Perimeter perimeter1 = Perimeter(
        id: 'f0f71ac8-6340-40cf-9e3c-e4ff43f4401a',
        radius: 2.0,
        type: GeometricFormType.circle,
        startPoint: location,
      );

      Fence fence1 = Fence(
        id: 'dbedac01-3583-4878-a190-8f2f184502c3',
        name: 'Fence 1 Company',
        perimeters: [perimeter1],
      );

      Fence fence2 = Fence(
        id: '652c82a8-e55e-4662-a9eb-646a86766b42',
        name: 'Fence 2 Company',
        perimeters: [perimeter1],
      );

      String employeeId = 'c629e735-fd26-47d4-9771-19a6e120a3a5';

      when(() => mockPerimeterRepository.save(perimeter: perimeter1))
          .thenAnswer((invocation) => Future.value(true));

      when(
        () => mockPerimeterRepository.findAllByFenceId(
          fenceId: any(named: 'fenceId'),
        ),
      ).thenAnswer((invocation) => Future.value([perimeter1]));

      when(
        () => mockFencePerimeterRepository.save(
          fenceId: any(named: 'fenceId'),
          perimeterId: any(named: 'perimeterId'),
        ),
      ).thenAnswer((invocation) => Future.value(true));

      when(
        () => mockEmployeeFenceRepository.findAllByEmployeeId(
          employeeId: employeeId,
        ),
      ).thenAnswer((invocation) => Future.value([fence1.id.toString(), fence2.id.toString()]));

      List<Fence> fences = [fence1, fence2];

      bool isEmpty = (await repository.getAll()).isEmpty;
      bool successSavaAll = await repository.saveAll(fences: fences);
      //fence1.name = 'New Fence Name';
      bool successUpdate = await repository.saveAll(fences: [fence1]);
      List<Fence> allFencesFromBase = await repository.getAll();
      List<Fence> fencesFromEmployeeId =
          await repository.findAllByEmployeeId(
        employeeId: employeeId,
      );

      expect(isEmpty, true);
      expect(successSavaAll, true);
      expect(successUpdate, true);
      expect(allFencesFromBase.first.id, fence1.id);
      expect(allFencesFromBase.first.name, fence1.name);
      expect(allFencesFromBase.first.perimeters!.length, 1);
      expect(allFencesFromBase.first.perimeters!.first.id, perimeter1.id);
      expect(
        allFencesFromBase.first.perimeters!.first.radius,
        perimeter1.radius,
      );
      expect(allFencesFromBase.first.perimeters!.first.type, perimeter1.type);
      expect(allFencesFromBase.length, 2);
      expect(fencesFromEmployeeId[0].id, fence2.id);
      expect(fencesFromEmployeeId[1].id, fence1.id);
    },
  );
}
