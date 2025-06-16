import 'dart:io';

abstract class LocaleHelper {
  static String get languageAndCountryCode {
    return Platform.localeName.substring(0, 2).replaceAll('_', '-');
  }
}
