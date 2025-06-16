import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum MaritalStatusEnum {
  single,
  married,
  divorced,
  widower,
  concubinage,
  separated,
  stableUnion,
  other;

  String nameTranslate(AppLocalizations appLocalizations) {
    switch (this) {
      case single:
        return appLocalizations.maritalStatusSingle;
      case married:
        return appLocalizations.maritalStatusMarried;
      case divorced:
        return appLocalizations.maritalStatusDivorced;
      case widower:
        return appLocalizations.maritalStatusWidower;
      case concubinage:
        return appLocalizations.concubine;
      case separated:
        return appLocalizations.maritalStatusSeparated;
      case stableUnion:
        return appLocalizations.maritalStatusStableUnion;
      case other:
        return appLocalizations.other;
      default:
        return '';
    }
  }
}
