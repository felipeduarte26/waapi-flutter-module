import './senior_icon_button_style.dart';

class SeniorIconButtonThemeData {
  /// Theme definitions for the SeniorIconButton component.
  const SeniorIconButtonThemeData({
    this.style,
  });

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorIconButtonStyle.borderColor] the color of the button's border.
  /// [SeniorIconButtonStyle.buttonColor] the button color.
  /// [SeniorIconButtonStyle.disabledBorderColor] the border color of the button when it`s disabled.
  /// [SeniorIconButtonStyle.disabledButtonColor] the button color when disabled.
  /// [SeniorIconButtonStyle.disabledIconColor] icon color when disabled.
  /// [SeniorIconButtonStyle.iconColor] the icon color.
  /// [SeniorIconButtonStyle.outlinedColor] the color of the button's outline.
  final SeniorIconButtonStyle? style;

  SeniorIconButtonThemeData copyWith({
    SeniorIconButtonStyle? style,
  }) {
    return SeniorIconButtonThemeData(
      style: style ?? this.style,
    );
  }
}
