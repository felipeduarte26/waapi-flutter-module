import '../../infra/models/employee_model.dart';

class EmployeeModelMapper {
  EmployeeModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EmployeeModel(
      employeeId: map['employeeId'] ?? '',
      username: map['userName'] ?? '',
      name: map['name'] ?? '',
      photoLink: map['photoLink'] ?? '',
    );
  }
}
