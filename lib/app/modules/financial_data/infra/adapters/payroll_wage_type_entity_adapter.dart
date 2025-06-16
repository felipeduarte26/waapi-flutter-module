import '../../domain/entities/payroll_wage_type_entity.dart';
import '../models/payroll_wage_type_model.dart';

class PayrollWageTypeEntityAdapter {
  PayrollWageTypeEntity fromModel({
    required PayrollWageTypeModel payrollWageTypeModel,
  }) {
    return PayrollWageTypeEntity(
      id: payrollWageTypeModel.id,
      name: payrollWageTypeModel.name,
      kind: payrollWageTypeModel.kind,
      type: payrollWageTypeModel.type,
    );
  }
}
