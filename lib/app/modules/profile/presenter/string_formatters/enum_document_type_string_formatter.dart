import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/document_type_enum.dart';

abstract class EnumDocumentTypeStringFormatter {
  static String getEnumDocumentTypeString({
    required DocumentTypeEnum documentTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (documentTypeEnum) {
      case DocumentTypeEnum.cdi:
        return appLocalizations.cdi;
      case DocumentTypeEnum.civilCertificate:
        return appLocalizations.civilCertificates;
      case DocumentTypeEnum.cnh:
        return appLocalizations.cnh;
      case DocumentTypeEnum.cns:
        return appLocalizations.cns;
      case DocumentTypeEnum.cpf:
        return appLocalizations.cpf;
      case DocumentTypeEnum.ctps:
        return appLocalizations.ctps;
      case DocumentTypeEnum.nis:
        return appLocalizations.nis;
      case DocumentTypeEnum.passport:
        return appLocalizations.passport;
      case DocumentTypeEnum.rg:
        return appLocalizations.rg;
      case DocumentTypeEnum.ric:
        return appLocalizations.ric;
      case DocumentTypeEnum.rne:
        return appLocalizations.rne;
      case DocumentTypeEnum.visa:
        return appLocalizations.visa;
      case DocumentTypeEnum.voterRegistrationCard:
        return appLocalizations.voterRegistrationCard;
    }
  }
}
