import 'package:flutter/material.dart';

class SeniorRatingStyle {
  /// Style definitions for the SeniorRating component.
  const SeniorRatingStyle({
    this.iconColor,
    this.disabledIconColor,
  });

  /// Defines the icon color.
  final Color? iconColor;

  /// Defines the color of icons when disabled.
  final Color? disabledIconColor;

  SeniorRatingStyle copyWith({
    Color? iconColor,
    Color? disabledIconColor,
  }) {
    return SeniorRatingStyle(
      iconColor: iconColor ?? this.iconColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
    );
  }
}
