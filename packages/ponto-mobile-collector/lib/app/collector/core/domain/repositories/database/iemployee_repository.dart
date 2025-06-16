import '../../../../../../ponto_mobile_collector.dart';
import '../../../external/drift/collector_database.dart';
import '../../entities/company.dart';
import '../../entities/fence.dart';

abstract class IEmployeeRepository {
  Future<bool> exist({
    String? employeeId,
  });

  Future<int> insert({
    required Employee employee,
  });

  Future<bool> update({
    required Employee employee,
  });

  Future<bool> save({required Employee employee});

  Future<List<Employee>> getAll();

  Future<Employee?> findById({required String id});

  Future<List<Employee>?> findByIds({required List<String> ids});

  Future<Employee?> findByIdAndEnabled({required String id});

  Future<Employee?> findByFaceRegistered({
    required String faceRegistered,
  });

  Future<Employee?> findByMail({required String mail});

  Future<Employee?> findByCpf({required String cpf});

  Future<List<Employee>?> findByName({
    required String name,
  });

  Future<Employee?> findByEmployeeCodeAndEnable({required String employeeCode});

  Future<Employee?> findByNfcCodeAndEnable({required String nfcCode});

  Future<List<Employee?>> findByFaceRegisteredNotEmpty();

  Future<void> deleteAll();

  EmployeeTableData convertToTable({
    required Employee employee,
  });

  Future<bool> updateFaceRegisteredByEmployeeId({required String employeeId});

  Future<List<Employee>> findEmployeesByManager({
    required String managerId,
  });

  Future<Employee?> findFirst();

  Employee convertToEmployee(
      {required EmployeeTableData tableData,
      required Company company,
      required List<Fence> fences,});
      
  Future<void> disableAll();

  Future<List<EmployeeTableData>> getAllEnabled();

  Future<List<EmployeeTableData>> getAllDisabled();

  Future<void> deleteByIds({
    required List<String> ids,
  });

  Future<bool> saveEmployeeBatch({
    required List<Employee> employees,
  });
}
