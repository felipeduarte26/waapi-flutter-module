import '../../infra/models/birthday_employees_model.dart';
import 'employees_by_birthday_model_mapper.dart';

class BirthdayEmployeesModelMapper {
  final EmployeesByBirthdayModelMapper _employeesByBirthdayModelMapper;

  const BirthdayEmployeesModelMapper({
    required EmployeesByBirthdayModelMapper employeesByBirthdayModelMapper,
  }) : _employeesByBirthdayModelMapper = employeesByBirthdayModelMapper;

  BirthdayEmployeesModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return BirthdayEmployeesModel(
      employeesByBirthday: (map['employeesByBirthday'] as List).map(
        (employeeByBirthday) {
          return _employeesByBirthdayModelMapper.fromMap(
            map: employeeByBirthday,
          );
        },
      ).toList(),
    );
  }
}
