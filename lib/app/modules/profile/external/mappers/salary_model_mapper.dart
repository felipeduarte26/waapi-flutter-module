import '../../../../core/enums/currency_type_enum.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/salary_type_enum.dart';
import '../../infra/models/salary_model.dart';

class SalaryModelMapper {
  SalaryModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SalaryModel(
      salaryValue: map['salaryValue'] is num ? double.parse(map['salaryValue'].toString()) : 0,
      spendingMoney: map['spendingMoney'] is num ? double.parse(map['spendingMoney'].toString()) : 0,
      currencyType: EnumHelper<CurrencyTypeEnum>().stringToEnum(
        stringToParse: map['currencyType'],
        values: CurrencyTypeEnum.values,
      ),
      salaryType: EnumHelper<SalaryTypeEnum>().stringToEnum(
        stringToParse: map['salaryType'],
        values: SalaryTypeEnum.values,
      ),
      salaryUpdateDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['salaryUpdateDate'],
      ),
      insalubrityPremium: map['insalubrityPremium'] is num ? double.parse(map['insalubrityPremium'].toString()) : 0,
      riskPremium: map['riskPremium'] is num ? double.parse(map['riskPremium'].toString()) : 0,
    );
  }
}
