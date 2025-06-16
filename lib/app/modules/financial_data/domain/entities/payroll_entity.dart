import 'package:equatable/equatable.dart';

import '../../../../core/enums/currency_type_enum.dart';
import 'historical_job_position_entity.dart';
import 'payroll_calculation_entity.dart';
import 'payroll_details_entity.dart';
import 'payroll_employee_entity.dart';
import 'payroll_wage_types_entity.dart';

class PayrollEntity extends Equatable {
  final String? id;
  final PayrollCalculationEntity? calculation;
  final PayrollEmployeeEntity? employee;
  final PayrollDetailsEntity? details;
  final double? netValue;
  final double? referenceSalary;
  final int? amountDependentsForIncomeTax; // quantidadeDependentesParaImpostoRenda
  final int? amountDependentsForFamilySalary; //quantidadeDependentesParaSalarioFamilia;
  final double? baseValueINSS;
  final double? baseValueIR;
  final double? baseValueFGTS;
  final CurrencyTypeEnum? currency;
  final List<PayrollWageTypesEntity>? wageTypes;
  final double? valueFGTS;
  final HistoricalJobPositionEntity? historicalJobPositions;

  const PayrollEntity({
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
  List<Object?> get props {
    return [
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
}
