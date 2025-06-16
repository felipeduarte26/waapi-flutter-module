import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_checkbox.dart';

const checkboxLightTheme = const SeniorCheckboxThemeData(
  style: checkboxLightStyle,
);

const checkboxLightStyle = SeniorCheckboxStyle(
  activeColor: Colors.transparent,
  checkColor: SeniorColors.primaryColor,
  checkedBorderColor: SeniorColors.primaryColor,
  disabledBorderColor: SeniorColors.grayscale30,
  disabledCheckColor: SeniorColors.grayscale30,
  disabledTitleColor: SeniorColors.grayscale30,
  titleColor: SeniorColors.grayscale90,
  uncheckedBorderColor: SeniorColors.grayscale50,
);
