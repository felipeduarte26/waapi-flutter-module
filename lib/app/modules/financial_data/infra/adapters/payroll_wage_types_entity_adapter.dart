import '../../domain/entities/payroll_wage_types_entity.dart';
import '../models/payroll_wage_types_model.dart';
import 'payroll_wage_type_entity_adapter.dart';

class PayrollWageTypesEntityAdapter {
  PayrollWageTypesEntity fromModel({
    required PayrollWageTypesModel payrollWageTypesModel,
  }) {
    return PayrollWageTypesEntity(
      id: payrollWageTypesModel.id,
      wageType: PayrollWageTypeEntityAdapter().fromModel(
        payrollWageTypeModel: payrollWageTypesModel.wageType!,
      ),
      referenceValue: payrollWageTypesModel.referenceValue,
      actualValue: payrollWageTypesModel.actualValue,
    );
  }
}
