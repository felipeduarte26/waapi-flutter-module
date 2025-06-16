import 'package:equatable/equatable.dart';

import 'payroll_wage_type_model.dart';

class PayrollWageTypesModel extends Equatable {
  final String? id;
  final PayrollWageTypeModel? wageType;
  final double? referenceValue;
  final double? actualValue;

  const PayrollWageTypesModel({
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
