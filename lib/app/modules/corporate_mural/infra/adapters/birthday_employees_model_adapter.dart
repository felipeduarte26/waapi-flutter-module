import '../../domain/entities/birthday_employees_entity.dart';
import '../models/birthday_employees_model.dart';
import 'employees_by_birthday_model_adapter.dart';

class BirthdayEmployeesModelAdapter {
  final EmployeesByBirthdayModelAdapter _employeesByBirthdayModelAdapter;

  const BirthdayEmployeesModelAdapter({
    required EmployeesByBirthdayModelAdapter employeesByBirthdayModelAdapter,
  }) : _employeesByBirthdayModelAdapter = employeesByBirthdayModelAdapter;

  BirthdayEmployeesEntity fromModel({
    required BirthdayEmployeesModel birthdayEmployeesModel,
  }) {
    return BirthdayEmployeesEntity(
      employeesByBirthday: birthdayEmployeesModel.employeesByBirthday.map((employeesByBirthdayModel) {
        return _employeesByBirthdayModelAdapter.fromModel(
          employeesByBirthdayModel: employeesByBirthdayModel,
        );
      }).toList(),
    );
  }
}
