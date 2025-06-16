import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/email_type_enum.dart';

abstract class EnumEmailTypeStringFormatter {
  static String getEmailTypeString({
    EmailTypeEnum? emailTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (emailTypeEnum) {
      case EmailTypeEnum.personal:
        return appLocalizations.infoTypeOfPersonal;
      default:
        return appLocalizations.infoTypeOfProfessional;
    }
  }
}
