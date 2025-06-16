import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_platform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/employee_platform_user_repository.dart';
import 'package:test/test.dart';

void main() {
  late CollectorDatabase database;
  late IEmployeePlatformUserRepository repository;

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
      repository = EmployeePlatformUserRepository(
        database: database,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  test(
    'EmployeePlatformUserRepository test.',
    () async {
      // Insert initial data
      const platformUserId = 'platformUserId1';
      const employeeId = 'employeeId1';

      EmployeePlatformUsersTableData employeePlatformUserData =
          const EmployeePlatformUsersTableData(
        platforUsersId: platformUserId,
        employeeId: employeeId,
      );

      await database
          .into(database.employeePlatformUsersTable)
          .insert(employeePlatformUserData);

      // Test exist method
      bool exists = await repository.exist(
        platformUserId: platformUserId,
        employeeId: employeeId,
      );
      expect(exists, true);

      // Test insert method
      const newPlatformUserId = 'platformUserId2';
      const newEmployeeId = 'employeeId2';
      int insertedId = await repository.insert(
        platformUserId: newPlatformUserId,
        employeeId: newEmployeeId,
      );
      expect(insertedId, 2);

      // Test save method
      /// insert
      const savePlatformUserId = 'platformUserId3';
      const saveEmployeeId = 'employeeId3';
      bool saveSuccess = await repository.save(
        platformUserId: savePlatformUserId,
        employeeId: saveEmployeeId,
      );
      expect(saveSuccess, true);

      /// update
      saveSuccess = await repository.save(
        platformUserId: savePlatformUserId,
        employeeId: saveEmployeeId,
      );
      expect(saveSuccess, true);

      // Test update method
      const updatedPlatformUserId = 'platformUserIdUpdated';
      bool updateSuccess = await repository.update(
        platformUserId: platformUserId,
        employeeId: employeeId,
        newPlatformUserId: updatedPlatformUserId,
      );
      expect(updateSuccess, true);

      EmployeePlatformUsersTableData? updatedData =
          await repository.findByPlatformUserId(
        platformUserId: updatedPlatformUserId,
      );

      expect(updatedData!.platforUsersId, updatedPlatformUserId);
      expect(updatedData.employeeId, employeeId);

      // Test findByPlatformUserId method
      EmployeePlatformUsersTableData? foundData =
          await repository.findByPlatformUserId(
        platformUserId: platformUserId,
      );

      expect(foundData, null);

      // Test deleteAll method
      await repository.deleteAll();
      final exist = await repository.exist(
        platformUserId: platformUserId,
        employeeId: employeeId,
      );

      expect(exist, false);
    },
  );

  test(
    'deleteByEmployeeIds test',
    () async {
      await repository.save(
        platformUserId: '1',
        employeeId: '1',
      );
      await repository.deleteByEmployeeIds(employeeIds: []);

      final isEmployeePlatformUserExists = await repository.exist(
        platformUserId: '1',
        employeeId: '1',
      );

      expect(isEmployeePlatformUserExists, isTrue);
    },
  );
}
