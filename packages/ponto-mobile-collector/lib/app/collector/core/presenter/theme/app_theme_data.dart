import 'package:flutter/material.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class AppThemeData {
  static ThemeData themeData() {
    return ThemeData(
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: SeniorColors.primaryColor,
          ),
      primaryColor: SeniorColors.primaryColor,
    );
  }
}
