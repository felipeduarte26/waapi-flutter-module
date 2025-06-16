import 'package:flutter/material.dart';

class SeniorCircularLongPressButtonStyle {
  /// The style definitions for the Senior Long Press Button component.
  const SeniorCircularLongPressButtonStyle({
    this.activeBorderColor,
    this.borderColor,
    this.iconColor,
    this.labelColor,
  });

  /// Defines the color of the active border.
  final Color? activeBorderColor;

  /// Defines the default border color.
  final Color? borderColor;

  /// Defines the icon color.
  final Color? iconColor;

  /// Defines the color of the text displayed below the component.
  final Color? labelColor;

  SeniorCircularLongPressButtonStyle copyWith({
    Color? activeBorderColor,
    Color? borderColor,
    Color? iconColor,
    Color? labelColor,
  }) {
    return SeniorCircularLongPressButtonStyle(
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      labelColor: labelColor ?? this.labelColor,
    );
  }
}
