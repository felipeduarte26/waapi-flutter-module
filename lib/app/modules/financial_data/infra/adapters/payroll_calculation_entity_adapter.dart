import '../../domain/entities/payroll_calculation_entity.dart';
import '../models/payroll_calculation_model.dart';

class PayrollCalculationEntityAdapter {
  PayrollCalculationEntity fromModel({
    required PayrollCalculationModel payrollCalculationModel,
  }) {
    return PayrollCalculationEntity(
      id: payrollCalculationModel.id,
      paymentDate: payrollCalculationModel.paymentDate,
      paymentReference: payrollCalculationModel.paymentReference,
      type: payrollCalculationModel.type,
    );
  }
}
