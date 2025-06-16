import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/salary_type_enum.dart';

abstract class EnumSalaryTypeStringFormatter {
  static String getEnumSalaryTypeString({
    required SalaryTypeEnum salaryTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (salaryTypeEnum) {
      case SalaryTypeEnum.hourly:
        return appLocalizations.salaryTypeHourly;
      case SalaryTypeEnum.daily:
        return appLocalizations.salaryTypeDaily;
      case SalaryTypeEnum.weekly:
        return appLocalizations.salaryTypeWeekly;
      case SalaryTypeEnum.monthly:
        return appLocalizations.salaryTypeMonthly;
      case SalaryTypeEnum.fortnightly:
        return appLocalizations.salaryTypeBiweekly;
      case SalaryTypeEnum.takers:
        return appLocalizations.salaryTypeSkilled;
      case SalaryTypeEnum.dynamic:
        return appLocalizations.salaryTypeVariable;
    }
  }
}
