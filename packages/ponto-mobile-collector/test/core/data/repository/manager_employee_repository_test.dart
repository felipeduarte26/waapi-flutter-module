import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/employee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/manager_employee_repository.dart';
import 'package:test/test.dart';

import '../../../mocks/employee_dto_mock.dart';
import '../../../mocks/employee_entity_mock.dart';
import '../../../mocks/manager_employee_dto_mock.dart';

class MockEmployeeRepository extends Mock implements EmployeeRepository {}

void main() {
  late CollectorDatabase database;
  late ManagerEmployeeRepository repository;
  late EmployeeRepository employeeRepository;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      employeeRepository = MockEmployeeRepository();

      database = CollectorDatabase(
        database: openConnection(),
      );

      when(
        () => employeeRepository.findById(id: employeeDtoMock.id),
      ).thenAnswer((invocation) => Future.value(employeeEntityMock));

      repository = ManagerEmployeeRepository(
        database: database,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('ManagerRepository', () {
    test('exist test', () async {
      await repository.save(
        managerId: managerMock.id!,
        employeeId: employeeDtoMock.id,
      );

      var managerEmployeeDtoOut = await repository.exist(
        managerId: managerMock.id!,
        employeeId: employeeDtoMock.id,
      );

      expect(true, managerEmployeeDtoOut);
    });

    test('existManagerByEmployeeId test', () async {
      await repository.save(
        employeeId: employeeDtoMock.id,
        managerId: managerMock.id!,
      );

      bool existManagerByEmployeeId = await repository.existManagerByEmployeeId(
        employeeId: employeeDtoMock.id,
      );

      bool updateSuccess = await repository.update(
        managerId: managerMock.id!,
        employeeId: employeeDtoMock.id,
      );

      expect(updateSuccess, true);

      expect(true, existManagerByEmployeeId);
    });

    test('deleteByEmployeeId test', () async {
      await repository.save(
        employeeId: employeeDtoMock.id,
        managerId: managerMock.id!,
      );

      await repository.deleteByEmployeeId(employeeId: employeeDtoMock.id);

      var existManagerByEmployeeId = await repository.existManagerByEmployeeId(
        employeeId: employeeDtoMock.id,
      );
      expect(false, existManagerByEmployeeId);
    });

    test('deleteAll test', () async {
      await repository.save(
        employeeId: employeeDtoMock.id,
        managerId: managerMock.id!,
      );

      await repository.deleteAll();

      final allManagers = await repository.getAll();
      expect(allManagers, isEmpty);
    });

    test('deleteByEmployeeIds test', () async {
      await repository.save(
        employeeId: '1',
        managerId: '1',
      );
      await repository.deleteByEmployeeIds(employeeIds: []);

      final managers = await repository.getAll();

      expect(managers, isNotEmpty);
    });
  });
}
