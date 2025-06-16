import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_pin_code_field.dart';

const pinCodeFieldLightTheme = const SeniorPinCodeFieldThemeData(
  style: SeniorPinCodeFieldStyle(
    defaultBorderColor: SeniorColors.grayscale30,
    disabledDefaultBorderColor: SeniorColors.grayscale30,
    disabledPinBoxColor: SeniorColors.grayscale10,
    disabledPinTextColor: SeniorColors.grayscale30,
    errorBorderColor: SeniorColors.manchesterColorRed500,
    highlightColor: SeniorColors.primaryColor500,
    pinBoxColor: Colors.transparent,
    pinTextColor: SeniorColors.grayscale90,
  ),
);
