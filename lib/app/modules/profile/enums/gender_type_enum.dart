import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum GenderTypeEnum {
  female,
  male;

  String nameTranslate(AppLocalizations appLocalizations) {
    switch (this) {
      case female:
        return appLocalizations.female;
      case male:
        return appLocalizations.male;
    }
  }
}
