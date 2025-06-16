import 'package:flutter/material.dart';

class SeniorGradientIconStyle {
  /// Style definitions for the SeniorGradientIcon component.
  const SeniorGradientIconStyle({
    this.gradientColors,
  });

  /// Defines the icon's gradient colors.
  final List<Color>? gradientColors;

  SeniorGradientIconStyle copyWith({
    List<Color>? gradientColors,
  }) {
    return SeniorGradientIconStyle(
      gradientColors: gradientColors ?? this.gradientColors,
    );
  }
}
