import '../../../external/drift/collector_database.dart';

abstract class IManagerEmployeeRepository {
  Future<bool> exist({
    required String managerId,
    required String employeeId,
  });

  Future<int> insert({
    required String managerId,
    required String employeeId,
  });

  Future<bool> update({
    required String managerId,
    required String employeeId,
  });

  Future<bool> save({
    required String managerId,
    required String employeeId,
  });

  Future<void> deleteByEmployeeId({required String employeeId});

  Future<bool> existManagerByEmployeeId({
    required String employeeId,
  });

  Future<List<EmployeeManagersTableData>> getAll();

  Future<void> deleteAll();

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });

  EmployeeManagersTableData convertToTable({
    required String managerId,
    required String employeeId,
  });
}
