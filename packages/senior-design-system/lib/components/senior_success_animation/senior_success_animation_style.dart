import 'package:flutter/material.dart';

class SeniorSuccessAnimationStyle {
  /// Style definitions for the Senior Success Screen component.
  const SeniorSuccessAnimationStyle({
    this.titleColor,
    this.subtitleColor,
  });

  /// Defines the title color.
  final Color? titleColor;

  /// Defines the subtitle color.
  final Color? subtitleColor;

  SeniorSuccessAnimationStyle copyWith({
    Color? titleColor,
    Color? subtitleColor,
  }) {
    return SeniorSuccessAnimationStyle(
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
    );
  }
}
