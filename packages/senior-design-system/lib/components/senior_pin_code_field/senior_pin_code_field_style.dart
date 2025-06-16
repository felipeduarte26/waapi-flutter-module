import 'package:flutter/material.dart';

class SeniorPinCodeFieldStyle {
  /// Style definitions for the SeniorPinCodeField component.
  const SeniorPinCodeFieldStyle({
    this.defaultBorderColor,
    this.disabledDefaultBorderColor,
    this.disabledPinBoxColor,
    this.disabledPinTextColor,
    this.errorBorderColor,
    this.hasTextBorderColor,
    this.highlightColor,
    this.pinBoxColor,
    this.pinTextColor,
  });

  /// Defines the default color for the border color. The color displayed when the field is not in focus, has no content,
  /// or in an no-error state.
  final Color? defaultBorderColor;

  /// Defines the default color for the border color. The color displayed when the field has no content and is disabled.
  final Color? disabledDefaultBorderColor;

  /// Defines the field text color for when it is disabled.
  final Color? disabledPinTextColor;

  /// Defines the field's background color for when it is disabled.
  final Color? disabledPinBoxColor;

  /// Defines the border color for fields that are in an error state.
  final Color? errorBorderColor;

  /// Defines the border color for when the field has content.
  final Color? hasTextBorderColor;

  /// Defines the border color for when the field is in focus.
  final Color? highlightColor;

  /// Defines the field's background color.
  final Color? pinBoxColor;

  /// Defines the text color of the field.
  final Color? pinTextColor;

  SeniorPinCodeFieldStyle copyWith({
    Color? defaultBorderColor,
    Color? disabledDefaultBorderColor,
    Color? disabledPinBoxColor,
    Color? disabledPinTextColor,
    Color? errorBorderColor,
    Color? hasTextBorderColor,
    Color? highlightColor,
    Color? pinBoxColor,
    Color? pinTextColor,
  }) {
    return SeniorPinCodeFieldStyle(
      defaultBorderColor: defaultBorderColor ?? this.defaultBorderColor,
      disabledDefaultBorderColor: disabledDefaultBorderColor ?? this.disabledDefaultBorderColor,
      disabledPinBoxColor: disabledPinBoxColor ?? this.disabledPinBoxColor,
      disabledPinTextColor: disabledPinTextColor ?? this.disabledPinTextColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      hasTextBorderColor: hasTextBorderColor ?? this.hasTextBorderColor,
      highlightColor: highlightColor ?? this.highlightColor,
      pinBoxColor: pinBoxColor ?? this.pinBoxColor,
      pinTextColor: pinTextColor ?? this.pinTextColor,
    );
  }
}
