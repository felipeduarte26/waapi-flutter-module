import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

final SeniorThemeData lightTheme = SENIOR_LIGHT_THEME.copyWith(
  themeData: SENIOR_LIGHT_THEME.themeData?.copyWith(
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: SeniorColors.grayscale0,
      selectedItemColor: SeniorColors.primaryColor600,
      unselectedItemColor: SeniorColors.neutralColor500,
    ),
    scaffoldBackgroundColor: SeniorColors.grayscale0,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: SeniorColors.grayscale0,
    ),
    dividerTheme: const DividerThemeData(
      thickness: 0.8,
      color: SeniorColors.secondaryColor200,
    ),
    iconTheme: const IconThemeData(
      color: SeniorColors.primaryColor600,
    ),
    dialogBackgroundColor: SeniorColors.grayscale0,
  ),
);
