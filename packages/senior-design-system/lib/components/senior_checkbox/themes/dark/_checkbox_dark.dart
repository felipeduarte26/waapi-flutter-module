import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_checkbox.dart';

var checkboxDarkTheme = SeniorCheckboxThemeData(
  style: SeniorCheckboxStyle(
    activeColor: Colors.transparent,
    checkColor: SeniorColors.primaryColor300,
    checkedBorderColor: SeniorColors.primaryColor300,
    disabledBorderColor: SeniorColors.primaryColor300.withOpacity(0.50),
    disabledCheckColor: SeniorColors.primaryColor300.withOpacity(0.50),
    disabledTitleColor: SeniorColors.grayscale10.withOpacity(0.50),
    titleColor: SeniorColors.grayscale10,
    uncheckedBorderColor: SeniorColors.grayscale10,
  ),
);
