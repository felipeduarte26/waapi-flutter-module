import '../entities/multi_employee_sync.dart';
import '../entities/page_entity.dart';
import '../entities/page_response_entity.dart';

abstract class IEmployeeSyncService {
  Future<PageResponseEntity<MultiEmployeeSync>> getEmployees({
    required PageEntity pageEntity,
    String? employeeIdFilter,
  });
}
