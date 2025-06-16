import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/visa_type_enum.dart';

abstract class EnumVisaTypeStringFormatter {
  static String getEnumVisaTypeString({
    required VisaTypeEnum visaTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (visaTypeEnum) {
      case VisaTypeEnum.permanent:
        return appLocalizations.permanentVisa;
      case VisaTypeEnum.temporary:
        return appLocalizations.temporaryVisa;
      case VisaTypeEnum.exiled:
        return appLocalizations.exiledVisa;
      case VisaTypeEnum.refugee:
        return appLocalizations.refugeeVisa;
      case VisaTypeEnum.boundaryCountryResident:
        return appLocalizations.boundaryCountryResidentVisa;
      case VisaTypeEnum.disabledPerson:
        return appLocalizations.disabledPersonVisa;
      case VisaTypeEnum.temporaryResidentIrregular:
        return appLocalizations.temporaryResidentIrregularVisa;
      case VisaTypeEnum.permanentResidentChildren:
        return appLocalizations.permanentResidentChildrenVisa;
      case VisaTypeEnum.mercosulBenefit:
        return appLocalizations.mercosulBenefitVisa;
      case VisaTypeEnum.diplomacy:
        return appLocalizations.diplomacyVisa;
      case VisaTypeEnum.friendshipTreatyPortugal:
        return appLocalizations.friendshipTreatyPortugalVisa;
      case VisaTypeEnum.requestingRefuge:
        return appLocalizations.requestingRefugee;
      case VisaTypeEnum.othercondition:
        return appLocalizations.otherConditionVisa;
    }
  }
}
