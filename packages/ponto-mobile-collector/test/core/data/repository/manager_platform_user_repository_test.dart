import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/manager_platform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/platform_user_repository.dart';
import 'package:test/test.dart';
import '../../../mocks/manager_employee_dto_mock.dart';
import '../../../mocks/platform_user_employee_dto_mock.dart';

class MockPlatformUserRepository extends Mock
    implements PlatformUserRepository {}

void main() {
  late CollectorDatabase database;
  late ManagerPlatformUserRepository repository;
  late PlatformUserRepository platformUserRepository;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      platformUserRepository = MockPlatformUserRepository();

      database = CollectorDatabase(
        database: openConnection(),
      );

      when(
        () => platformUserRepository.findById(
          platformUserId: platformUserDtoMock.id!,
        ),
      ).thenAnswer((invocation) => Future.value(platformUserDtoMock));

      repository = ManagerPlatformUserRepository(
        database: database,
        platformUserRepository: platformUserRepository,
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
        platformUserId: platformUserDtoMock.id!,
        managerId: managerMock.id!,
      );

      List<clock.PlatformUserEmployeeDto>? platformUsersDtoOut =
          await repository.findPlatformUsersByManager(
        managerId: managerMock.id!,
      );

      expect(platformUserDtoMock.id, platformUsersDtoOut.first.id);
      expect(platformUserDtoMock.username, platformUsersDtoOut.first.username);
    });

    test('exist test', () async {
      await repository.save(
        platformUserId: platformUserDtoMock.id!,
        managerId: managerMock.id!,
      );

      var managerEmployeeDtoOut =
          await repository.exist(managerId: managerMock.id!);

      expect(true, managerEmployeeDtoOut);
    });    
  });
}
