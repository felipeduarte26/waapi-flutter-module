import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/company_type_enum.dart';

abstract class EnumCompanyTypeStringFormatter {
  static String getCompanyTypeEnumString({
    required CompanyTypeEnum companyTypeEnum,
    required AppLocalizations appLocalizations,
  }) {
    switch (companyTypeEnum) {
      case CompanyTypeEnum.headOffice:
        return appLocalizations.headquarters;
      case CompanyTypeEnum.branchOffice:
        return appLocalizations.branch;
    }
  }
}
