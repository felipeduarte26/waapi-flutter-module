import 'package:intl/intl.dart';

import '../../../../core/constants/supported_locales.dart';
import '../../../../core/enums/currency_type_enum.dart';

abstract class SalaryDataFormatter {
  static String percentageFormat({
    required double value,
    required String locale,
    String mask = '##0.0000',
    String suffix = '%',
  }) {
    final numberFormatter = NumberFormat(mask, locale);
    final formattedNumber = numberFormatter.format(value);

    return '$formattedNumber$suffix';
  }

  static String salaryFormatter({
    required double salary,
    CurrencyTypeEnum? currencyTypeEnum,
  }) {
    String currencySymbol;
    String currencyLocale;

    switch (currencyTypeEnum) {
      case CurrencyTypeEnum.dolar:
        currencySymbol = 'US\$';
        currencyLocale = SupportedLocales.americanEnglish;
        break;
      case CurrencyTypeEnum.real:
        currencySymbol = 'R\$';
        currencyLocale = SupportedLocales.brazilianPortuguese;
        break;
      default:
        currencySymbol = '';
        currencyLocale = SupportedLocales.brazilianPortuguese;
        break;
    }

    final currencyFormatter = NumberFormat.currency(
      decimalDigits: 2,
      locale: currencyLocale,
      symbol: currencySymbol,
    );

    return currencyFormatter.format(salary);
  }
}
