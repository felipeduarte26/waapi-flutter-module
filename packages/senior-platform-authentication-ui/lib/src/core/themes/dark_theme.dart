import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

final SeniorThemeData darkTheme = SENIOR_DARK_THEME.copyWith(
  themeData: SENIOR_DARK_THEME.themeData?.copyWith(
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: SeniorColors.grayscale100,
      selectedItemColor: SeniorColors.primaryColor500,
      unselectedItemColor: SeniorColors.grayscale20,
    ),
    scaffoldBackgroundColor: SeniorColors.grayscale90,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: SeniorColors.grayscale90,
    ),
    dividerTheme: const DividerThemeData(
      thickness: 0.8,
      color: SeniorColors.grayscale40,
    ),
    iconTheme: const IconThemeData(
      color: SeniorColors.primaryColor400,
    ),
    dialogBackgroundColor: SeniorColors.grayscale90,
  ),
);
