import '../../domain/entities/employees_by_birthday_entity.dart';
import '../models/employees_by_birthday_model.dart';
import 'employee_model_adapter.dart';

class EmployeesByBirthdayModelAdapter {
  final EmployeeModelAdapter _employeeModelAdapter;

  const EmployeesByBirthdayModelAdapter({
    required EmployeeModelAdapter employeeModelAdapter,
  }) : _employeeModelAdapter = employeeModelAdapter;

  EmployeesByBirthdayEntity fromModel({
    required EmployeesByBirthdayModel employeesByBirthdayModel,
  }) {
    return EmployeesByBirthdayEntity(
      birthday: employeesByBirthdayModel.birthday,
      employees: employeesByBirthdayModel.employees.map((employeeModel) {
        return _employeeModelAdapter.fromModel(
          employeeModel: employeeModel,
        );
      }).toList(),
    );
  }
}
