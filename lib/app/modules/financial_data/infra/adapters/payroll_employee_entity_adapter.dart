import '../../domain/entities/payroll_employee_entity.dart';
import '../models/payroll_employee_model.dart';

class PayrollEmployeeEntityAdapter {
  PayrollEmployeeEntity fromMap({
    required PayrollEmployeeModel payrollEmployeeModel,
  }) {
    return PayrollEmployeeEntity(
      id: payrollEmployeeModel.id,
    );
  }
}
