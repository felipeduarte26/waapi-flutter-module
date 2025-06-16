import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_radio_button.dart';

final radioButtonDarkTheme = SeniorRadioButtonThemeData(
  style: SeniorRadioButtonStyle(
    disabledCheckedFillColor: SeniorColors.primaryColor500.withOpacity(0.5),
    disabledUncheckedFillColor: SeniorColors.grayscale50.withOpacity(0.5),
    disabledTitleColor: SeniorColors.grayscale10.withOpacity(0.5),
    checkedFillColor: SeniorColors.primaryColor500,
    uncheckedFillColor: SeniorColors.grayscale50,
    titleColor: SeniorColors.grayscale10,
  ),
);
