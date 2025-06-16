import '../../domain/entities/salary_entity.dart';
import '../../infra/models/salary_model.dart';

class SalaryEntityAdapter {
  SalaryEntity fromModel({
    required SalaryModel salaryModel,
  }) {
    return SalaryEntity(
      currencyType: salaryModel.currencyType,
      insalubrityPremium: salaryModel.insalubrityPremium,
      riskPremium: salaryModel.riskPremium,
      salaryType: salaryModel.salaryType,
      salaryUpdateDate: salaryModel.salaryUpdateDate,
      salaryValue: salaryModel.salaryValue,
      spendingMoney: salaryModel.spendingMoney,
    );
  }
}
