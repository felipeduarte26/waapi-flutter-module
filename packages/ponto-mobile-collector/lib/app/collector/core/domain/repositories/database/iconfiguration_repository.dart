import '../../../external/drift/collector_database.dart';
import '../../entities/configuration.dart';

abstract class IConfigurationRepository {
  Future<bool> exist({required String employeeId});

  Future<int> insert({
    required Configuration config,
    required String employeeId,
    String? username,
  });

  Future<bool> update({
    required Configuration config,
    required String employeeId,
    String? username,
  });

  Future<bool> save({
    required Configuration config,
    required String employeeId,
    String? username,
  });

  Future<List<Configuration>> getAll();

  Future<Configuration?> findByEmployeeId({
    required String employeeId,
  });

  Future<Configuration?> findByUsername({
    required String username,
  });

  Future<String?> findIdByUsername({
    required String username,
  });

  ConfigurationTableData convertToTable({
    required Configuration config,
    required String employeeId,
  });

  Configuration converToDto({
    required ConfigurationTableData tableData,
  });

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });
}
