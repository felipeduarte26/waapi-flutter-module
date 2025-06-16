import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This extension is responsible for generate variables inside BuildContext to help us on translate.
extension TranslateExtension on BuildContext {
  /// Contains the AppLocalization instance.
  AppLocalizations get translate {
    return AppLocalizations.of(this)!;
  }
}
