// ignore_for_file: unused_local_variable

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/imanager_employee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/imanager_platform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/manager_repository.dart';
import 'package:test/test.dart';

import '../../../mocks/employee_dto_mock.dart';
import '../../../mocks/manager_employee_dto_mock.dart';
import '../../../mocks/manager_employee_entity_mock.dart';
import '../../../mocks/platform_user_employee_dto_mock.dart';

class MockManagerPlatformUserRepository extends Mock
    implements IManagerPlatformUserRepository {}

class MockManagerEmployeeRepository extends Mock
    implements IManagerEmployeeRepository {}

void main() {
  late IManagerPlatformUserRepository managerPlatformUserRepository;
  late IManagerEmployeeRepository managerEmployeeRepository;
  late CollectorDatabase database;
  late ManagerRepository repository;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      managerEmployeeRepository = MockManagerEmployeeRepository();
      managerPlatformUserRepository = MockManagerPlatformUserRepository();

      database = CollectorDatabase(
        database: openConnection(),
      );

      when(
        () => managerEmployeeRepository.save(
          employeeId: employeeDtoMock.id,
          managerId: managerEmployeeDtoMock.id!,
        ),
      ).thenAnswer(
        (invocation) => Future.value(true),
      );

      when(
        () => managerPlatformUserRepository.save(
          platformUserId: platformUserDtoMock.id!,
          managerId: managerEmployeeDtoMock.id!,
        ),
      ).thenAnswer(
        (invocation) => Future.value(true),
      );

      when(
        () => managerPlatformUserRepository.findPlatformUsersByManager(
          managerId: managerEmployeeDtoMock.id!,
        ),
      ).thenAnswer((invocation) => Future.value([platformUserDtoMock]));

      repository = ManagerRepository(
        database: database,
        managerEmployeeRepository: managerEmployeeRepository,
        managerPlatformUserRepository: managerPlatformUserRepository,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('ManagerRepository', () {
    test('findById test', () async {
      await repository.save(
        managerDto: managerEntityMock,
      );

      clock.ManagerEmployeeDto? managerEmployeeDtoOut =
          await repository.findById(id: managerMock.id!);

      expect(managerEntityMock.id, managerEmployeeDtoOut!.id);
      expect(managerEntityMock.mail, managerEmployeeDtoOut.mail);
      expect(
        managerEntityMock.platformUserName,
        managerEntityMock.platformUserName,
      );
    });

    test('findByMail test', () async {
      await repository.save(
        managerDto: managerEntityMock,
      );

      clock.ManagerEmployeeDto? managerEmployeeDtoOut =
          await repository.findByMail(mail: managerMock.mail!);

      expect(managerEntityMock.id, managerEmployeeDtoOut!.id);
      expect(managerEntityMock.mail, managerEmployeeDtoOut.mail);
      expect(
        managerEntityMock.platformUserName,
        managerEmployeeDtoOut.platformUserName,
      );
    });

    test('getAll test', () async {
      await repository.save(
        managerDto: managerEntityMock,
      );

      List<clock.ManagerEmployeeDto>? managerEmployeeDtoOut =
          await repository.getAll();

      expect(managerEntityMock.id, managerEmployeeDtoOut.first.id);
      expect(managerEntityMock.mail, managerEmployeeDtoOut.first.mail);
      expect(
        managerEntityMock.platformUserName,
        managerEmployeeDtoOut.first.platformUserName,
      );
    });

    test('exist test', () async {
      await repository.save(
        managerDto: managerEntityMock,
      );

      var managerEmployeeDtoOut =
          await repository.exist(managerId: managerMock.id!);

      expect(true, managerEmployeeDtoOut);
    });

    test('findByPlatformUserId test', () async {
      var manager = await repository.save(
        managerDto: managerEntityMock,
      );

      ManagersPlatformUsersTableData tableData = ManagersPlatformUsersTableData(
        managerId: managerMock.id!,
        platforUsersId: platformUserDtoMock.id!,
      );
      database.into(database.managersPlatformUsersTable).insert(tableData);

      var managerEmployeeDto = await repository.findByPlatformUserId(
          platformUserId: platformUserDtoMock.id!,);

      expect(managerEntityMock.id, managerEmployeeDto!.id);
      expect(managerEntityMock.mail, managerEmployeeDto.mail);
      expect(managerEntityMock.platformUserName, managerEmployeeDto.platformUserName);
    });

    test('update test', () async {
      await repository.save(
        managerDto: managerEntityMock,
      );

      var managerEmployeeDtoOut = await repository.update(manager: managerEntityMock);

      expect(true, managerEmployeeDtoOut);
    });

    test('deleteAll test', () async {
      int totalInitial = (await repository.getAll()).length;
      await repository.save(
        managerDto: managerEntityMock,
      );
      int totalAddOne = (await repository.getAll()).length;
      await repository.deleteAll();
      int totalRemoveAll = (await repository.getAll()).length;

      expect(totalInitial, 0);
      expect(totalAddOne, 1);
      expect(totalRemoveAll, 0);
    });
  });
}
