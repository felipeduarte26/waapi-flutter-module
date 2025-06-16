import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_square_buttons_menu.dart';

final ghostSquareButtonsMenuLightTheme = SeniorSquareButtonsMenuThemeData(
  style: SeniorSquareButtonsMenuStyle(
    backgroundColor: Colors.transparent,
    borderColor: SeniorColors.grayscale50,
    fontColor: SeniorColors.grayscale50,
    iconColor: SeniorColors.grayscale50,
    disabledBackgroundColor: Colors.transparent,
    disabledBorderColor: SeniorColors.grayscale50.withOpacity(0.5),
    disabledFontColor: SeniorColors.grayscale50,
    disabledIconColor: SeniorColors.grayscale50,
  ),
);
