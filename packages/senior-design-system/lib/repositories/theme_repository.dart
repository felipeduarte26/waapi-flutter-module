import 'package:flutter/material.dart';

import '../senior_design_system.dart';

class ThemeRepository extends ChangeNotifier {
  /// State manager for the components theme.
  /// Ensures that the content inside the SeniorDesignSystem widget follows the theme.
  /// You must pass the initial theme as a parameter. If your application doesn't have a custom theme you can
  /// the theme [SENIOR_LIGHT_THEME] or [SENIOR_DARK_THEME] which are the default themes provided by the library.
  ThemeRepository(this._theme);

  /// The theme of components.
  SeniorThemeData _theme;

  SeniorThemeData get theme => _theme;

  void set theme(SeniorThemeData theme) {
    _theme = theme;
    notifyListeners();
  }

  /// Checks if the current theme is a clear theme.
  /// Returns true if light and false if dark or custom.
  bool isLightTheme() {
    return _theme.themeType == ThemeType.light;
  }

  /// Checks if the current theme is a dark theme.
  /// Returns true if dark and false if light or custom.
  bool isDarkTheme() {
    return _theme.themeType == ThemeType.dark;
  }

  /// Checks if the current theme is a custom theme.
  /// Returns true if custom and false if light or dark.
  bool isCustomTheme() {
    return _theme.themeType == ThemeType.custom;
  }
}
