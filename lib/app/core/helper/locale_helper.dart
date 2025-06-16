import 'package:flutter/material.dart';

abstract class LocaleHelper {
  static String languageAndCountryCode({required Locale locale}) {
    if (locale.languageCode.length < 5) return locale.languageCode.substring(0, 2);

    return locale.languageCode.substring(0, 5).replaceAll('_', '-');
  }
}
