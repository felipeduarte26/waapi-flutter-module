import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SocialProfileTypeEnum {
  userProfile,
  corporateProfile,
  unknown;

  String translate(AppLocalizations appLocalizations) {
    switch (this) {
      case unknown:
        return '';
      case corporateProfile:
        return appLocalizations.corporateProfile;
      case userProfile:
        return appLocalizations.personalProfile;
    }
  }
}

extension SocialprofileTypeEnumExtension on SocialProfileTypeEnum {
  String get name {
    switch (this) {
      case SocialProfileTypeEnum.userProfile:
        return 'USER_PROFILE';
      case SocialProfileTypeEnum.corporateProfile:
        return 'CORPORATE_PROFILE';
      default:
        return '';
    }
  }
}
