import '../../infra/models/payroll_employee_model.dart';

class PayrollEmployeeModelMapper {
  PayrollEmployeeModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PayrollEmployeeModel(
      id: map['id'],
    );
  }
}
