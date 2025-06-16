import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/marital_status_enum.dart';

class EnumMaritalStatusStringFormatter {
  static String getEnumMaritalStatusTypeString({
    required MaritalStatusEnum maritalStatusEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (maritalStatusEnum) {
      case MaritalStatusEnum.single:
        return appLocalizations.maritalStatusSingle;
      case MaritalStatusEnum.married:
        return appLocalizations.maritalStatusMarried;
      case MaritalStatusEnum.divorced:
        return appLocalizations.maritalStatusDivorced;
      case MaritalStatusEnum.widower:
        return appLocalizations.maritalStatusWidower;
      case MaritalStatusEnum.separated:
        return appLocalizations.maritalStatusSeparated;
      case MaritalStatusEnum.concubinage:
        return appLocalizations.concubine;
      case MaritalStatusEnum.stableUnion:
        return appLocalizations.maritalStatusStableUnion;
      case MaritalStatusEnum.other:
        return appLocalizations.other;
    }
  }
}
