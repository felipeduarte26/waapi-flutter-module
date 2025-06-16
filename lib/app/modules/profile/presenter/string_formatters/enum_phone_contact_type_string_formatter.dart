import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/phone_contact_type_enum.dart';

abstract class EnumPhoneContactTypeStringFormatter {
  static String phoneContactTypeEnumToValue({
    required PhoneContactTypeEnum phoneContactTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (phoneContactTypeEnum) {
      case PhoneContactTypeEnum.personal:
        return appLocalizations.typePhonePersonal;
      case PhoneContactTypeEnum.professional:
        return appLocalizations.typePhoneProfessional;
      case PhoneContactTypeEnum.mobile:
        return appLocalizations.typePhoneCell;
    }
  }
}
