import 'package:equatable/equatable.dart';

import '../../../../core/enums/currency_type_enum.dart';
import '../../enums/salary_type_enum.dart';

class SalaryModel extends Equatable {
  final double? salaryValue;
  final double? spendingMoney;
  final CurrencyTypeEnum? currencyType;
  final SalaryTypeEnum? salaryType;
  final DateTime? salaryUpdateDate;
  final double? insalubrityPremium;
  final double? riskPremium;

  const SalaryModel({
    this.salaryValue,
    this.spendingMoney,
    this.currencyType,
    this.salaryType,
    this.salaryUpdateDate,
    this.insalubrityPremium,
    this.riskPremium,
  });

  @override
  List<Object?> get props {
    return [
      salaryValue,
      spendingMoney,
      currencyType,
      salaryType,
      salaryUpdateDate,
      insalubrityPremium,
      riskPremium,
    ];
  }
}
