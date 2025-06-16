import './senior_checkbox_style.dart';

class SeniorCheckboxThemeData {
  /// Theme definitions for the SeniorCheckbox component.
  const SeniorCheckboxThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorCheckboxStyle.activeColor] The color to use when this checkbox is checked.
  /// [SeniorCheckboxStyle.checkColor] The color to use for the check icon when this checkbox is checked.
  /// [SeniorCheckboxStyle.checkedBorderColor] The color of the checkbox border.
  /// [SeniorCheckboxStyle.disabledBorderColor] The border color of the checkbox when disabled.
  /// [SeniorCheckboxStyle.disabledCheckColor] The color to use for the check icon when this checkbox is checked and it is
  /// disabled.
  /// [SeniorCheckboxStyle.disabledTitleColor] The color of the checkbox title when disabled.
  /// [SeniorCheckboxStyle.titleColor] The color of the checkbox title.
  /// [SeniorCheckboxStyle.uncheckedBorderColor] The color of the checkbox border when it is not checked.
  final SeniorCheckboxStyle? style;

  SeniorCheckboxThemeData copyWith({
    SeniorCheckboxStyle? style,
  }) {
    return SeniorCheckboxThemeData(
      style: style ?? this.style,
    );
  }
}