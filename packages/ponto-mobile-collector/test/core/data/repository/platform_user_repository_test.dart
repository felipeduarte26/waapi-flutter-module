import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/platform_user.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/platform_user_repository.dart';
import 'package:test/test.dart';

import '../../../mocks/platform_user_employee_dto_mock.dart';
import '../../../mocks/platform_user_entity_mock.dart';

void main() {
  late CollectorDatabase database;
  late PlatformUserRepository repository;

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

      repository = PlatformUserRepository(
        database: database,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('PlatformUserRepository', () {
    test('findById test', () async {
      await repository.save(platformUser: platformUserMock);

      clock.PlatformUserEmployeeDto? platformUserEmployeeDtoOut =
          await repository.findById(platformUserId: platformUserMock.id!);

      expect(platformUserMock.id, platformUserEmployeeDtoOut!.id);
      expect(platformUserMock.platformUserName, platformUserEmployeeDtoOut.username);
    });

    test('findByUserName test', () async {
      await repository.save(platformUser: platformUserMock);

      PlatformUser? platformUserEmployeeDtoOut =
          await repository.findByUserName(
        username: platformUserMock.platformUserName!,
      );

      expect(platformUserMock.id, platformUserEmployeeDtoOut!.id);
      expect(platformUserMock.platformUserName, platformUserEmployeeDtoOut.platformUserName);
    });

    test('getAll test', () async {
      await repository.save(platformUser: platformUserMock);

      List<clock.PlatformUserEmployeeDto>? platformUserEmployeeDtoOut =
          await repository.getAll();

      expect(platformUserMock.id, platformUserEmployeeDtoOut.first.id);
      expect(
        platformUserMock.platformUserName,
        platformUserEmployeeDtoOut.first.username,
      );
    });

    test('exist test', () async {
      await repository.save(platformUser: platformUserMock);

      var platformUserEmployeeDtoOut =
          await repository.exist(platformUserId: platformUserMock.id!);

      expect(true, platformUserEmployeeDtoOut);
    });

    test('update test', () async {
      await repository.save(platformUser: platformUserMock);

      var platformUserEmployeeDtoOut =
          await repository.update(platformUser: platformUserMock);

      expect(true, platformUserEmployeeDtoOut);
    });

    test('deleteAll test', () async {
      await repository.save(platformUser: platformUserMock);

      await repository.deleteAll();

      final platformUserEmployeeDtoOut =
          await repository.exist(platformUserId: platformUserDtoMock.id!);

      expect(platformUserEmployeeDtoOut, false);
    });
  });
}
