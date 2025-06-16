import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PaymentTypeEnum {
  empty,
  money,
  check,
  bankDeposit,
  moneyOrder;

  String name(AppLocalizations appLocalizations) {
    switch (this) {
      case empty:
        return '';
      case money:
        return appLocalizations.money;
      case check:
        return appLocalizations.check;
      case bankDeposit:
        return appLocalizations.bankDeposit;
      case moneyOrder:
        return appLocalizations.paymentOrder;
    }
  }
}
