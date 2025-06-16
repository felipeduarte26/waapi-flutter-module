import './senior_square_buttons_menu_style.dart';

class SeniorSquareButtonsMenuThemeData {
  /// Theme definitions for the Senior Square Buttons Menu component.
  const SeniorSquareButtonsMenuThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorSquareButtonsMenuStyle.backgroundColor] the background color of the button.
  /// [SeniorSquareButtonsMenuStyle.backgroundGradientColors] the button's gradient colors.
  /// [SeniorSquareButtonsMenuStyle.borderColor] the button`s border color.
  /// [SeniorSquareButtonsMenuStyle.disabledBackgroundColor] the background color for when the button is disabled.
  /// [SeniorSquareButtonsMenuStyle.disabledBackgroundGradientColors] gradient colors for when the button is disabled.
  /// [SeniorSquareButtonsMenuStyle.disabledBorderColor] the button`s border color when the button is disabled.
  /// [SeniorSquareButtonsMenuStyle.disabledFontColor] the text color of the button when it is disabled.
  /// [SeniorSquareButtonsMenuStyle.disabledIconColor] the icon color of the button when it is disabled.
  /// [SeniorSquareButtonsMenuStyle.fontColor] the color of the button's text.
  /// [SeniorSquareButtonsMenuStyle.iconColor] the icon color of the button.
  final SeniorSquareButtonsMenuStyle? style;

  SeniorSquareButtonsMenuThemeData copyWith({
    SeniorSquareButtonsMenuStyle? style,
  }) {
    return SeniorSquareButtonsMenuThemeData(
      style: style ?? this.style,
    );
  }
}
