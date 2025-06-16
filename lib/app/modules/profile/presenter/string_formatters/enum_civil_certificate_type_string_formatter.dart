import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/civil_certificate_type_enum.dart';

abstract class EnumCivilCertificateTypeStringFormatter {
  static String getEnumCivilCertificateTypeString({
    required CivilCertificateTypeEnum civilCertificateTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (civilCertificateTypeEnum) {
      case CivilCertificateTypeEnum.birth:
        return appLocalizations.birthCertificate;
      case CivilCertificateTypeEnum.marriage:
        return appLocalizations.marriageCertificate;
      case CivilCertificateTypeEnum.religiousMarriage:
        return appLocalizations.religiousMarriageCertificate;
      case CivilCertificateTypeEnum.death:
        return appLocalizations.deathCertificate;
      case CivilCertificateTypeEnum.stillbirth:
        return appLocalizations.stillbirthCertificate;
      case CivilCertificateTypeEnum.registrationBanns:
        return appLocalizations.registrationBannsCertificate;
      case CivilCertificateTypeEnum.indigenousPersonsBirthCertificate:
        return appLocalizations.indigenousPersonsBirthCertificate;
      case CivilCertificateTypeEnum.others:
        return appLocalizations.othersCertificate;
    }
  }
}
