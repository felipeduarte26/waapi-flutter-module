import '../../domain/entities/employees_by_hire_date_entity.dart';
import '../models/employees_by_hire_date_model.dart';
import 'employee_model_adapter.dart';

class EmployeesByHireDateModelAdapter {
  final EmployeeModelAdapter _employeeModelAdapter;

  const EmployeesByHireDateModelAdapter({
    required EmployeeModelAdapter employeeModelAdapter,
  }) : _employeeModelAdapter = employeeModelAdapter;

  EmployeesByHireDateEntity fromModel({
    required EmployeesByHireDateModel employeesByHireDateModel,
  }) {
    return EmployeesByHireDateEntity(
      hireDate: employeesByHireDateModel.hireDate,
      employees: employeesByHireDateModel.employees.map((employeeModel) {
        return _employeeModelAdapter.fromModel(
          employeeModel: employeeModel,
        );
      }).toList(),
    );
  }
}
