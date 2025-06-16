import 'package:flutter/material.dart';

class SeniorCardStyle {
  /// Style definitions for the SeniorCard component.
  const SeniorCardStyle({
    this.backgroundColor,
    this.backgroundColorIfElevated,
    this.disabledBackgroundColor,
    this.iconColor,
    this.outlinedColor,
    this.quotesColor,
  });

  /// Defines the card's background color.
  final Color? backgroundColor;

  /// Defines the card's background color when it's disabled and elevated.
  final Color? backgroundColorIfElevated;

  //// Defines the card's background color when it's disabled.
  final Color? disabledBackgroundColor;

  /// Defines the color of the card's icon.
  final Color? iconColor;

  /// Defines the color of the card border.
  final Color? outlinedColor;

  /// Defines the color of quotes characters.
  final Color? quotesColor;

  /// Creates a new instance of [SeniorCardStyle] with the option to override specific properties.
  SeniorCardStyle copyWith({
    Color? backgroundColor,
    Color? backgroundColorIfElevated,
    Color? disabledBackgroundColor,
    Color? iconColor,
    Color? outlinedColor,
    Color? quotesColor,
  }) {
    return SeniorCardStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundColorIfElevated: backgroundColorIfElevated ?? this.backgroundColorIfElevated,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      iconColor: iconColor ?? this.iconColor,
      outlinedColor: outlinedColor ?? this.outlinedColor,
      quotesColor: quotesColor ?? this.quotesColor,
    );
  }
}
