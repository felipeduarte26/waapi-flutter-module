import '../../../external/drift/collector_database.dart';

abstract class IEmployeeFenceRepository {
  Future<bool> exist({
    required String employeeId,
    required String fenceId,
  });

  Future<int> insert({
    required String employeeId,
    required String fenceId,
  });

  Future<bool> save({required String employeeId, required String fenceId});

  Future<List<String>> findAllByEmployeeId({required String employeeId});

  Future<void> deleteAll();

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });

  EmployeeFenceTableData convertToTable({
    required String employeeId,
    required String fenceId,
  });
}
