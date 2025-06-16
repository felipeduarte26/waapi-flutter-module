import '../../../external/drift/collector_database.dart';

abstract class IEmployeePlatformUserRepository {
  Future<bool> exist({
    required String platformUserId,
    required String employeeId,
  });

  Future<int> insert({
    required String platformUserId,
    required String employeeId,
  });

  Future<bool> save({
    required String platformUserId,
    required String employeeId,
  });

  Future<bool> update({
    required String platformUserId,
    required String employeeId,
    required String newPlatformUserId,
  });

  Future<EmployeePlatformUsersTableData?> findByPlatformUserId({
    required String platformUserId,
  });

  Future<void> deleteAll();

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });

  EmployeePlatformUsersTableData convertToTable({
    required String platformUserId,
    required String employeeId,
  });
}
