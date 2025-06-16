import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_switch.dart';

final switchDarkTheme = SeniorSwitchThemeData(
  style: SeniorSwitchStyle(
    activeColor: SeniorColors.primaryColor500,
    disabledTextColor: SeniorColors.grayscale10.withOpacity(0.5),
    textColor: SeniorColors.grayscale10,
    trackColor: SeniorColors.grayscale40,
    thumbInactiveColor: SeniorColors.grayscale70,
    thumbActiveColor: SeniorColors.primaryColor600,
  ),
);
