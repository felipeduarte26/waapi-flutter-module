import 'package:flutter/material.dart';

class SeniorIconButtonStyle {
  /// Style definitions for the SeniorIconButton component.
  const SeniorIconButtonStyle({
    this.borderColor,
    this.buttonColor,
    this.disabledBorderColor,
    this.disabledButtonColor,
    this.disabledIconColor,
    this.iconColor,
    this.outlinedColor,
  });

  /// Defines the color of the button's border.
  final Color? borderColor;

  /// Defines the button color.
  final Color? buttonColor;

  /// Defines the border color of the button when it`s disabled.
  final Color? disabledBorderColor;

  /// Defines the button color when disabled.
  final Color? disabledButtonColor;

  /// Defines icon color when disabled.
  final Color? disabledIconColor;

  /// Defines the icon color.
  final Color? iconColor;

  /// Defines the color of the button's outline.
  final Color? outlinedColor;

  SeniorIconButtonStyle copyWith({
    Color? borderColor,
    Color? buttonColor,
    Color? disabledBorderColor,
    Color? disabledButtonColor,
    Color? disabledIconColor,
    Color? iconColor,
    Color? outlinedColor,
  }) {
    return SeniorIconButtonStyle(
      borderColor: borderColor ?? this.borderColor,
      buttonColor: buttonColor ?? this.buttonColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      disabledButtonColor: disabledButtonColor ?? this.disabledButtonColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      iconColor: iconColor ?? this.iconColor,
      outlinedColor: outlinedColor ?? this.outlinedColor,
    );
  }
}
