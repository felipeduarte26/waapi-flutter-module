import './senior_pin_code_field_style.dart';

class SeniorPinCodeFieldThemeData {
  /// Theme definitions for the SeniorPinCodeField component.
  const SeniorPinCodeFieldThemeData({
    this.style,
  });

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorPinCodeFieldStyle.defaultBorderColor] the default color for the border color. The color displayed when the
  /// field is not in focus, has no content, or in an no-error state.
  /// [SeniorPinCodeFieldStyle.disabledDefaultBorderColor] the default color for the border color. The color displayed
  /// when the field has no content and is disabled.
  /// [SeniorPinCodeFieldStyle.disabledHasTextBorderColor] the border color for when the field has content and is disabled.
  /// [SeniorPinCodeFieldStyle.disabledPinBoxColor] the field text color for when it is disabled.
  /// [SeniorPinCodeFieldStyle.disabledPinTextColor] the field's background color for when it is disabled.
  /// [SeniorPinCodeFieldStyle.errorBorderColor] the border color for fields that are in an error state.
  /// [SeniorPinCodeFieldStyle.hasTextBorderColor] the border color for when the field has content.
  /// [SeniorPinCodeFieldStyle.highlightColor] the border color for when the field is in focus.
  /// [SeniorPinCodeFieldStyle.pinBoxColor] the field's background color.
  /// [SeniorPinCodeFieldStyle.pinTextColor] the text color of the field.
  final SeniorPinCodeFieldStyle? style;

  SeniorPinCodeFieldThemeData copyWith({
    SeniorPinCodeFieldStyle? style,
  }) {
    return SeniorPinCodeFieldThemeData(
      style: style ?? this.style,
    );
  }
}
