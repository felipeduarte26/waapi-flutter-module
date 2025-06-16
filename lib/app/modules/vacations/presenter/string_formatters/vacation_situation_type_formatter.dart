import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/vacation_situation_type_enum.dart';

class VacationSituationTypeFormatter {
  static String getVacationSituationTypeFormatter({
    required VacationSituationTypeEnum vacationSituationTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (vacationSituationTypeEnum) {
      case VacationSituationTypeEnum.approved:
        return appLocalizations.approved;
      case VacationSituationTypeEnum.paid:
        return appLocalizations.vacationPaid;
      case VacationSituationTypeEnum.waitingApproval:
        return appLocalizations.waitingApproval;
      case VacationSituationTypeEnum.returnedToAdjustments:
        return appLocalizations.returnedAdjustment;
      case VacationSituationTypeEnum.underAnalysis:
        return appLocalizations.underAnalysis;
      case VacationSituationTypeEnum.vacationUpdate:
        return appLocalizations.changesInProcessing;
      case VacationSituationTypeEnum.expired:
        return appLocalizations.expired;
    }
  }
}
