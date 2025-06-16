import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/vacation_type_enum.dart';

class VacationTypeFormatter {
  static String getVacationTypeFormatted({
    required VacationTypeEnum vacationTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (vacationTypeEnum) {
      case VacationTypeEnum.collective:
        return appLocalizations.collective;
      case VacationTypeEnum.individual:
        return appLocalizations.individual;
    }
  }
}
