import 'package:flutter/material.dart';

class SeniorBackdropStyle {
  /// Style definitions for the SeniorBackdrop component.
  const SeniorBackdropStyle({
    this.bodyColor,
    this.headerColors,
    this.selectedLabelColor,
    this.tabIndicatorColor,
    this.unselectedLabelColor,
  });

  /// Defines the body color of the backdrop.
  final Color? bodyColor;

  /// Defines the color of the backdrop header. Component top.
  final List<Color>? headerColors;

  /// Defines the color of selected labels.
  final Color? selectedLabelColor;

  /// Defines the indicator color of the selected tab on the backdrop.
  final Color? tabIndicatorColor;

  /// Defines the color of unselected labels.
  final Color? unselectedLabelColor;

  /// Creates a new instance of [SeniorBackdropStyle] with the option to override specific properties.
  SeniorBackdropStyle copyWith({
    Color? bodyColor,
    List<Color>? headerColors,
    Color? selectedLabelColor,
    Color? tabIndicatorColor,
    Color? unselectedLabelColor,
  }) {
    return SeniorBackdropStyle(
      bodyColor: bodyColor ?? this.bodyColor,
      headerColors: headerColors ?? this.headerColors,
      selectedLabelColor: selectedLabelColor ?? this.selectedLabelColor,
      tabIndicatorColor: tabIndicatorColor ?? this.tabIndicatorColor,
      unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
    );
  }
}
