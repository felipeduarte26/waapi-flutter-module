import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/employees_by_hire_date_model.dart';
import 'employee_model_mapper.dart';

class EmployeesByHireDateModelMapper {
  final EmployeeModelMapper _employeeModelMapper;

  const EmployeesByHireDateModelMapper({
    required EmployeeModelMapper employeeModelMapper,
  }) : _employeeModelMapper = employeeModelMapper;

  EmployeesByHireDateModel fromMap({
    required Map<String, dynamic> employeesByHireDateMap,
  }) {
    return EmployeesByHireDateModel(
      hireDate: DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: employeesByHireDateMap['hireDate'] ?? '',
      ),
      employees: (employeesByHireDateMap['employees'] as List).map(
        (employee) {
          return _employeeModelMapper.fromMap(
            map: employee,
          );
        },
      ).toList(),
    );
  }
}
