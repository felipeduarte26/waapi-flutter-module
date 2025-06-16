import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/gender_type_enum.dart';

class EnumGenderStringFormatter {
  static String getEnumGenderTypeString({
    required GenderTypeEnum genderTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (genderTypeEnum) {
      case GenderTypeEnum.male:
        return appLocalizations.male;
      case GenderTypeEnum.female:
        return appLocalizations.female;
    }
  }
}
