import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_text_field_style.dart';
import '../../senior_text_field_theme.dart';

const textFieldLightTheme = SeniorTextFieldThemeData(
  style: textFieldLightStyle,
);

const textFieldLightStyle = SeniorTextFieldStyle(
  borderColor: SeniorColors.grayscale50,
  counterColor: SeniorColors.grayscale80,
  errorColor: SeniorColors.manchesterColorRed,
  fillColor: SeniorColors.grayscale5,
  focusColor: SeniorColors.primaryColor500,
  hintTextColor: SeniorColors.grayscale60,
  iconColor: SeniorColors.grayscale90,
  textColor: SeniorColors.grayscale90,
  helperTextColor: SeniorColors.grayscale80,
);
