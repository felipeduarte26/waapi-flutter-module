import './senior_text_field_style.dart';

class SeniorTextFieldThemeData {
  /// Theme definitions for the SeniorTextField component.
  const SeniorTextFieldThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorTextFieldStyle.borderColor] the color of the field border..
  /// [SeniorTextFieldStyle.counterColor] the color of the text field's character counter.
  /// [SeniorTextFieldStyle.errorColor] the color of error state.
  /// [SeniorTextFieldStyle.fillColor] the fill color.
  /// [SeniorTextFieldStyle.focusColor] the color of elements when they have focus.
  /// [SeniorTextFieldStyle.hintTextColor] the hint text color.
  /// [SeniorTextFieldStyle.helperTextColor] the help text color.
  /// [SeniorTextFieldStyle.iconColor] the color of text field icons.
  /// [SeniorTextFieldStyle.textColor] the color of the text.
  final SeniorTextFieldStyle? style;

  SeniorTextFieldThemeData copyWith({
    SeniorTextFieldStyle? style,
  }) {
    return SeniorTextFieldThemeData(
      style: style ?? this.style,
    );
  }
}
