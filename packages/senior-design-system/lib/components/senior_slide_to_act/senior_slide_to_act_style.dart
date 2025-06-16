import 'package:flutter/material.dart';

class SeniorSlideToActStyle {
  /// Style definitions for the SeniorSlideToAct component.
  const SeniorSlideToActStyle({
    this.containerColor,
    this.slideButtonColor,
    this.slideButtonIconColor,
    this.submittedIconColor,
    this.textColor,
  });

  /// Defines the color of the entire container.
  final Color? containerColor;

  /// Defines the slide button color.
  final Color? slideButtonColor;

  /// Defines the icon color of the slide button.
  final Color? slideButtonIconColor;

  /// Defines the color of the icon that is displayed in the submitted animation.
  final Color? submittedIconColor;

  /// Defines the color of the displayed text.
  final Color? textColor;

  SeniorSlideToActStyle copyWith({
    Color? containerColor,
    Color? slideButtonColor,
    Color? slideButtonIconColor,
    Color? submittedIconColor,
    Color? textColor,
  }) {
    return SeniorSlideToActStyle(
      containerColor: containerColor ?? this.containerColor,
      slideButtonColor: slideButtonColor ?? this.slideButtonColor,
      slideButtonIconColor: slideButtonIconColor ?? this.slideButtonIconColor,
      submittedIconColor: submittedIconColor ?? this.submittedIconColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
