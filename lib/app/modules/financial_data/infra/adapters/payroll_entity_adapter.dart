import '../../domain/entities/historical_job_position_entity.dart';
import '../../domain/entities/payroll_entity.dart';
import '../models/historical_job_position_model.dart';
import '../models/payroll_model.dart';
import 'historical_job_position_entity_adapter.dart';
import 'payroll_calculation_entity_adapter.dart';
import 'payroll_details_entity_adapter.dart';
import 'payroll_employee_entity_adapter.dart';
import 'payroll_wage_types_entity_adapter.dart';

class PayrollEntityAdapter {
  PayrollEntity fromModel({
    required PayrollModel payrollModel,
    List<HistoricalJobPositionModel>? historicalJobPositionModel,
  }) {
    return PayrollEntity(
      id: payrollModel.id,
      calculation: PayrollCalculationEntityAdapter().fromModel(
        payrollCalculationModel: payrollModel.calculation!,
      ),
      employee: PayrollEmployeeEntityAdapter().fromMap(
        payrollEmployeeModel: payrollModel.employee!,
      ),
      details: PayrollDetailsEntityAdapter().fromModel(
        payrollDetailsModel: payrollModel.details!,
      ),
      netValue: payrollModel.netValue,
      referenceSalary: payrollModel.referenceSalary,
      amountDependentsForIncomeTax: payrollModel.amountDependentsForIncomeTax,
      amountDependentsForFamilySalary: payrollModel.amountDependentsForFamilySalary,
      baseValueINSS: payrollModel.baseValueINSS,
      baseValueIR: payrollModel.baseValueIR,
      baseValueFGTS: payrollModel.baseValueFGTS,
      currency: payrollModel.currency,
      wageTypes: payrollModel.wageTypes
          ?.map(
            (wageTypes) => PayrollWageTypesEntityAdapter().fromModel(
              payrollWageTypesModel: wageTypes,
            ),
          )
          .toList(),
      valueFGTS: payrollModel.valueFGTS,
      historicalJobPositions: getHistoricalJobPositionAtDate(
        historicalJobPositions: historicalJobPositionModel,
        payrollDate: payrollModel.calculation!.paymentDate,
      ),
    );
  }

  HistoricalJobPositionEntity? getHistoricalJobPositionAtDate({
    List<HistoricalJobPositionModel>? historicalJobPositions,
    DateTime? payrollDate,
  }) {
    if (historicalJobPositions == null || payrollDate == null) {
      return null;
    }
    historicalJobPositions.sort((a, b) => b.jobStartDate.compareTo(a.jobStartDate));
    for (var historicalJobPosition in historicalJobPositions) {
      if (historicalJobPosition.jobStartDate.isBefore(payrollDate) ||
          historicalJobPosition.jobStartDate.isAtSameMomentAs(payrollDate)) {
        return HistoricalJobPositionEntityAdapter().fromModel(historicalJobPositionModel: historicalJobPosition);
      }
    }
    return null;
  }
}
