import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/stability_type_enum.dart';

abstract class EnumStabilityTypeStringFormatter {
  static String getStabilityType({
    required StabilityTypeEnum stabilityTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (stabilityTypeEnum) {
      case StabilityTypeEnum.notStable:
        return appLocalizations.notStable;
      case StabilityTypeEnum.electedCipa:
        return appLocalizations.electedCipa;
      case StabilityTypeEnum.maternityAssistance:
        return appLocalizations.maternityAssistance;
      case StabilityTypeEnum.unionMandate:
        return appLocalizations.unionMandate;
      case StabilityTypeEnum.governmentEmployee:
        return appLocalizations.governmentEmployee;
      case StabilityTypeEnum.returnHolidays:
        return appLocalizations.returnHolidays;
      case StabilityTypeEnum.sickPay:
        return appLocalizations.sickPay;
      case StabilityTypeEnum.nearRetirement:
        return appLocalizations.nearRetirement;
      case StabilityTypeEnum.collectiveAgreement:
        return appLocalizations.collectiveAgreement;
      case StabilityTypeEnum.previousTimeFgtsOption:
        return appLocalizations.previousTimeFgtsOption;
      case StabilityTypeEnum.notOptingFgts:
        return appLocalizations.notOptionFgts;
      case StabilityTypeEnum.cipaEmployer:
        return appLocalizations.cipaEmployer;
      case StabilityTypeEnum.memberOfComissionForPriorConciliation:
        return appLocalizations.memberOfComissionForPriorConciliation;
      case StabilityTypeEnum.memberOfFgtsCuratorCouncil:
        return appLocalizations.memberOfFgtsCuratorCouncil;
      case StabilityTypeEnum.memberOfNationalCouncilOfSocialSecurity:
        return appLocalizations.memberOfNationalCouncilOfSocialSecurity;
      case StabilityTypeEnum.educationAid:
        return appLocalizations.educationAid;
      case StabilityTypeEnum.consumerCooperative:
        return appLocalizations.consumerCooperative;
      case StabilityTypeEnum.creditUnion:
        return appLocalizations.creditUnion;
      case StabilityTypeEnum.personWithDisability:
        return appLocalizations.personWithDisability;
      case StabilityTypeEnum.cooperativeOfSyndicate:
        return appLocalizations.cooperativeOfSyndicate;
      case StabilityTypeEnum.cipatr:
        return appLocalizations.cipatr;
      case StabilityTypeEnum.paternityLeave:
        return appLocalizations.paternityLeave;
      case StabilityTypeEnum.electoralMandate:
        return appLocalizations.electoralMandate;
      case StabilityTypeEnum.cipaCandidate:
        return appLocalizations.cipaCandidate;
      case StabilityTypeEnum.electAlternateCipa:
        return appLocalizations.electAlternateCipa;
    }
  }
}
