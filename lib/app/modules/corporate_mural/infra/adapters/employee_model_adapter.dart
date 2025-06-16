import '../../domain/entities/employee_entity.dart';
import '../models/employee_model.dart';

class EmployeeModelAdapter {
  EmployeeEntity fromModel({
    required EmployeeModel employeeModel,
  }) {
    return EmployeeEntity(
      employeeId: employeeModel.employeeId,
      username: employeeModel.username,
      name: employeeModel.name,
      photoLink: employeeModel.photoLink,
    );
  }
}
