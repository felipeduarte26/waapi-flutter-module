import '../../domain/entities/employees_by_year_hire_entity.dart';
import '../models/employees_by_year_hire_model.dart';
import 'employees_by_hire_date_model_adapter.dart';

class EmployeesByYearHireEntityAdapter {
  final EmployeesByHireDateModelAdapter _employeesByHireDateModelAdapter;

  const EmployeesByYearHireEntityAdapter({
    required EmployeesByHireDateModelAdapter employeesByHireDateModelAdapter,
  }) : _employeesByHireDateModelAdapter = employeesByHireDateModelAdapter;

  EmployeesByYearHireEntity fromModel({
    required EmployeesByYearHireModel employeesByYearHireModel,
  }) {
    return EmployeesByYearHireEntity(
      yearsCount: employeesByYearHireModel.yearsCount,
      employeesByHireDateEntity: employeesByYearHireModel.employeesByHireDateModel.map((employeesByHireDateModel) {
        return _employeesByHireDateModelAdapter.fromModel(
          employeesByHireDateModel: employeesByHireDateModel,
        );
      }).toList(),
    );
  }
}
