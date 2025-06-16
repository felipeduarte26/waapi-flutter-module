import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/employees_by_birthday_model.dart';
import 'employee_model_mapper.dart';

class EmployeesByBirthdayModelMapper {
  final EmployeeModelMapper _employeeModelMapper;

  const EmployeesByBirthdayModelMapper({
    required EmployeeModelMapper employeeModelMapper,
  }) : _employeeModelMapper = employeeModelMapper;

  EmployeesByBirthdayModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EmployeesByBirthdayModel(
      birthday: DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: map['birthday'] ?? '',
      ),
      employees: (map['employees'] as List).map(
        (employee) {
          return _employeeModelMapper.fromMap(
            map: employee,
          );
        },
      ).toList(),
    );
  }
}
