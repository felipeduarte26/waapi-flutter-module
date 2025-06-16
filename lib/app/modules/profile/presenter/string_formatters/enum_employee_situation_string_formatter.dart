import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/employee_situation_enum.dart';

abstract class EnumEmployeeSituationStringFormatter {
  static String getEmployeeSituation({
    required EmployeeSituationEnum employeeSituationEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (employeeSituationEnum) {
      case EmployeeSituationEnum.active:
        return appLocalizations.active;
      case EmployeeSituationEnum.leave:
        return appLocalizations.absent;
      case EmployeeSituationEnum.closed:
        return appLocalizations.terminated;
    }
  }
}
