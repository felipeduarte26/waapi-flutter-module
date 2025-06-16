import 'package:equatable/equatable.dart';

import '../../../../core/enums/currency_type_enum.dart';
import 'historical_job_position_model.dart';
import 'payroll_calculation_model.dart';
import 'payroll_details_model.dart';
import 'payroll_employee_model.dart';
import 'payroll_wage_types_model.dart';

class PayrollModel extends Equatable {
  final String? id;
  final PayrollCalculationModel? calculation;
  final PayrollEmployeeModel? employee;
  final PayrollDetailsModel? details;
  final double? netValue;
  final double? referenceSalary;
  final int? amountDependentsForIncomeTax; // quantidadeDependentesParaImpostoRenda
  final int? amountDependentsForFamilySalary; //quantidadeDependentesParaSalarioFamilia;
  final double? baseValueINSS;
  final double? baseValueIR;
  final double? baseValueFGTS;
  final CurrencyTypeEnum? currency;
  final List<PayrollWageTypesModel>? wageTypes;
  final double? valueFGTS;
  final List<HistoricalJobPositionModel>? historicalJobPositions;

  const PayrollModel({
    this.id,
    this.calculation,
    this.employee,
    this.details,
    this.netValue,
    this.referenceSalary,
    this.amountDependentsForIncomeTax,
    this.amountDependentsForFamilySalary,
    this.baseValueINSS,
    this.baseValueIR,
    this.baseValueFGTS,
    this.currency,
    this.wageTypes,
    this.valueFGTS,
    this.historicalJobPositions,
  });

  @override
  List<Object?> get props => [
        id,
        calculation,
        employee,
        details,
        netValue,
        referenceSalary,
        amountDependentsForIncomeTax,
        amountDependentsForFamilySalary,
        baseValueINSS,
        baseValueIR,
        baseValueFGTS,
        currency,
        wageTypes,
        valueFGTS,
        historicalJobPositions,
      ];
}
