import 'package:flutter/material.dart';

class SeniorSliderDotsStyle {
  /// Style definitions for the SeniorSliderDots component.
  const SeniorSliderDotsStyle({
    this.activeColor,
    this.defaultColor,
  });

  /// Defines the color of active dot representing the current page.
  final Color? activeColor;

  /// Defines the color of points that are not active.
  final Color? defaultColor;

  SeniorSliderDotsStyle copyWith({
    Color? activeColor,
    Color? defaultColor,
  }) {
    return SeniorSliderDotsStyle(
      activeColor: activeColor ?? this.activeColor,
      defaultColor: defaultColor ?? this.defaultColor,
    );
  }
}
