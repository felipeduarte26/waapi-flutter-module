import 'senior_circular_long_press_button_style.dart';

class SeniorCircularLongPressButtonThemeData {
  /// Theme settings for the Senior Long Press Button component.
  const SeniorCircularLongPressButtonThemeData({
    this.style,
  });

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorLongPressButtonStyle.activeBorderColor] the active border color.
  /// [SeniorLongPressButtonStyle.borderColor] the default border color.
  /// [SeniorLongPressButtonStyle.iconColor] the icon color.
  /// [SeniorLongPressButtonStyle.labelColor] the color of the text displayed below the component.
  final SeniorCircularLongPressButtonStyle? style;

  SeniorCircularLongPressButtonThemeData copyWith({
    SeniorCircularLongPressButtonStyle? style,
  }) {
    return SeniorCircularLongPressButtonThemeData(
      style: style ?? this.style,
    );
  }
}