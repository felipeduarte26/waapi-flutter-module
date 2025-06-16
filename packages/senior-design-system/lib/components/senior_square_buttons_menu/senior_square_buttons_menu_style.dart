import 'package:flutter/material.dart';

class SeniorSquareButtonsMenuStyle {
  /// Style definitions for the Senior Square Buttons Menu component.
  const SeniorSquareButtonsMenuStyle({
    this.backgroundColor,
    this.backgroundGradientColors,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledBackgroundGradientColors,
    this.disabledBorderColor,
    this.disabledFontColor,
    this.disabledIconColor,
    this.fontColor,
    this.iconColor,
  });

  /// Defines the button's background color.
  /// It is only displayed when no value has been assigned to the parameter [backgroundGradientColors]
  final Color? backgroundColor;

  /// Defines the button's gradient colors.
  final List<Color>? backgroundGradientColors;

  /// Defines the button`s border color.
  final Color? borderColor;

  /// Defines the background color for when the button is disabled.
  /// It is only displayed when no value has been assigned to the parameter [disabledBackgroundGradientColors]
  final Color? disabledBackgroundColor;

  /// Defines the gradient colors for when the button is disabled.
  final List<Color>? disabledBackgroundGradientColors;

  /// Defines the button`s border color when the button is disabled.
  final Color? disabledBorderColor;

  /// Defines the text color of the button when it is disabled.
  final Color? disabledFontColor;

  /// Defines the icon color of the button when it is disabled.
  final Color? disabledIconColor;

  /// Defines the button text color.
  final Color? fontColor;

  /// Defines the icon color of the button.
  final Color? iconColor;

  SeniorSquareButtonsMenuStyle copyWith({
    Color? backgroundColor,
    List<Color>? backgroundGradientColors,
    Color? borderColor,
    Color? disabledBackgroundColor,
    List<Color>? disabledBackgroundGradientColors,
    Color? disabledBorderColor,
    Color? disabledFontColor,
    Color? disabledIconColor,
    Color? fontColor,
    Color? iconColor,
  }) {
    return SeniorSquareButtonsMenuStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundGradientColors: backgroundGradientColors ?? this.backgroundGradientColors,
      borderColor: borderColor ?? this.borderColor,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledBackgroundGradientColors: disabledBackgroundGradientColors ?? this.disabledBackgroundGradientColors,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      disabledFontColor: disabledFontColor ?? this.disabledFontColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      fontColor: fontColor ?? this.fontColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
