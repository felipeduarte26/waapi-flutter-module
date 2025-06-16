import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/overnight_repository.dart';

import '../../../../../../mocks/employee_dto_mock.dart';
import '../../../../../../mocks/overnight_entity_mock.dart';

void main() {
  late CollectorDatabase database;
  late OvernightRepository overnightRepository;
  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () async {
      database = CollectorDatabase(
        database: openConnection(),
      );

      final clock.EmployeeDto(
        :id,
        :name!,
        cpf: cpfNumber,
        company: clock.CompanyDto(
          id: companyId!,
        )!,
        :employeeType,
      ) = employeeDtoMock;
      database.into(database.employeeTable).insert(
            EmployeeTableCompanion.insert(
              id: id,
              name: name,
              cpfNumber: cpfNumber,
              companyId: companyId,
              employeeType: employeeType,
            ),
          );

      overnightRepository = OvernightRepository(
        database: database,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('OvernightRepository', () {
    test('insert should return the number of rows inserted', () async {
      bool isEmpty = (await overnightRepository.getAll()).isEmpty;
      expect(isEmpty, isTrue);
    });

    test('update should return true', () async {
      bool isUpdated = await overnightRepository.update(
        overnightEntity: overnightEntityMock,
      );
      expect(isUpdated, isFalse);
    });

    test('save should return true', () async {
      bool isSaved = await overnightRepository.save(
        overnightEntity: overnightEntityMock,
      );
      expect(isSaved, isTrue);
    });

    test('exist should return true', () async {
      await overnightRepository.save(
        overnightEntity: overnightEntityMock,
      );
      bool exist = await overnightRepository.exist(id: overnightEntityMock.id);
      expect(exist, isTrue);
    });

    test('insert should return the number of rows inserted', () async {
      int rowsInserted = await overnightRepository.insert(
        overnightEntity: overnightEntityMock,
      );
      expect(rowsInserted, 1);
    });

    test('findById should return the overnight', () async {
      await overnightRepository.save(
        overnightEntity: overnightEntityMock,
      );
      final overnightEnity = await overnightRepository.findById(
        id: overnightEntityMock.id,
      );
      expect(overnightEnity!.id, overnightEntityMock.id);
    });

    test('findNotSynchronized should return the overnight', () async {
      await overnightRepository.save(
        overnightEntity: overnightEntityMock,
      );
      final overnights = await overnightRepository.findNotSynchronized();
      expect(overnights.first.id, overnightEntityMock.id);
    });

    test('findByDateAndEmployee should return the overnight', () async {
      await overnightRepository.save(
        overnightEntity: overnightEntityMock,
      );
      final overnights = await overnightRepository.findByDateAndEmployee(
        dateToCompare: overnightEntityMock.date,
        employeeId: overnightEntityMock.employee.id,
      );
      expect(overnights.first.id, overnightEntityMock.id);
    });

    test('findByEmployee should return the overnights for the given employee',
        () async {
      await overnightRepository.save(
        overnightEntity: overnightEntityMock,
      );
      final overnights = await overnightRepository.findByEmployee(
        employeeId: overnightEntityMock.employee.id,
      );
      expect(overnights.first.id, overnightEntityMock.id);
    });

    test('deleteByEmployeeIds test', () async {
      await overnightRepository.save(
        overnightEntity: overnightEntityMock,
      );
      await overnightRepository.deleteByEmployeeIds(employeeIds: []);

      final overnights = await overnightRepository.getAll();

      expect(overnights, isNotEmpty);
    });
  });
}
