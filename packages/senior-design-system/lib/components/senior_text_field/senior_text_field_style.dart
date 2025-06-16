import 'package:flutter/material.dart';

class SeniorTextFieldStyle {
  /// Style definitions for the SeniorTextField component.
  const SeniorTextFieldStyle({
    this.borderColor,
    this.counterColor,
    this.errorColor,
    this.fillColor,
    this.focusColor,
    this.hintTextColor,
    this.iconColor,
    this.textColor,
    this.helperTextColor,
  });

  /// Defines the color of the field border. When it's focused the border color is [focusColor].
  final Color? borderColor;

  /// Defines the color of the text field's character counter.
  final Color? counterColor;

  /// Defines the color of error state.
  final Color? errorColor;

  /// Defines the fill color.
  final Color? fillColor;

  /// Defines the color of elements when they have focus.
  final Color? focusColor;

  /// Defines the hint text color.
  final Color? hintTextColor;

  /// Defines the color of text field icons.
  final Color? iconColor;

  /// Defines the color of the text.
  final Color? textColor;

  /// Defines the helper text color.
  final Color? helperTextColor;

  SeniorTextFieldStyle copyWith({
    Color? borderColor,
    Color? counterColor,
    Color? errorColor,
    Color? fillColor,
    Color? focusColor,
    Color? hintTextColor,
    Color? iconColor,
    Color? textColor,
    Color? helperTextColor,
  }) {
    return SeniorTextFieldStyle(
      borderColor: borderColor ?? this.borderColor,
      counterColor: counterColor ?? this.counterColor,
      errorColor: errorColor ?? this.errorColor,
      fillColor: fillColor ?? this.fillColor,
      focusColor: focusColor ?? this.focusColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      helperTextColor: helperTextColor ?? this.helperTextColor,
    );
  }
}
