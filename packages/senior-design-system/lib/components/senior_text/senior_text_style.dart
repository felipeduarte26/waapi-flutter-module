import 'package:flutter/material.dart';

class SeniorTextStyle {
  /// Style definitions for the SeniorText component.
  const SeniorTextStyle({
    this.color,
    this.emphasisColor,
  });

  /// Defines the font color default.
  final Color? color;

  /// Defines the font color when in emphasis.
  final Color? emphasisColor;

  SeniorTextStyle copyWith({
    Color? color,
    Color? emphasisColor,
  }) {
    return SeniorTextStyle(
      color: color ?? this.color,
      emphasisColor: emphasisColor ?? this.emphasisColor,
    );
  }
}
