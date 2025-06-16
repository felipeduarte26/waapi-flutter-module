import 'package:equatable/equatable.dart';

import 'payroll_wage_type_entity.dart';

class PayrollWageTypesEntity extends Equatable {
  final String? id;
  final PayrollWageTypeEntity? wageType;
  final double? referenceValue;
  final double? actualValue;

  const PayrollWageTypesEntity({
    this.id,
    this.wageType,
    this.referenceValue,
    this.actualValue,
  });

  @override
  List<Object?> get props => [
        id,
        wageType,
        referenceValue,
        actualValue,
      ];
}
