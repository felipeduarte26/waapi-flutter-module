import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_square_buttons_menu.dart';

final emphasisSquareButtonsMenuLightTheme = SeniorSquareButtonsMenuThemeData(
  style: SeniorSquareButtonsMenuStyle(
    backgroundGradientColors: SeniorColors.primaryGradientColors,
    borderColor: Colors.transparent,
    fontColor: SeniorColors.pureWhite,
    iconColor: SeniorColors.pureWhite,
    disabledBackgroundColor: SeniorColors.primaryColor.withOpacity(0.5),
    disabledBorderColor: Colors.transparent,
    disabledFontColor: SeniorColors.pureWhite,
    disabledIconColor: SeniorColors.pureWhite,
  ),
);
