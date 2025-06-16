import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_icon_button.dart';

const primaryIconButtonLightTheme = const SeniorIconButtonThemeData(
  style: SeniorIconButtonStyle(
    borderColor: Colors.transparent,
    buttonColor: SeniorColors.primaryColor,
    disabledBorderColor: Colors.transparent,
    disabledButtonColor: SeniorColors.primaryColor100,
    disabledIconColor: SeniorColors.primaryColor300,
    iconColor: SeniorColors.pureWhite,
    outlinedColor: SeniorColors.primaryColor200,
  ),
);
