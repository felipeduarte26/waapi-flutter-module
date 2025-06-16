import 'package:flutter/material.dart';

class SeniorTabBarStyle {
  /// Style definitions for the SeniorTabBar component.
  const SeniorTabBarStyle({
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
  });

  /// Defines the indicator color of the active tab.
  final Color? indicatorColor;

  /// Defines the color of the tab label.
  final Color? labelColor;

  /// Defines the color of the label of disabled tabs.
  final Color? unselectedLabelColor;

  SeniorTabBarStyle copyWith({
    Color? indicatorColor,
    Color? labelColor,
    Color? unselectedLabelColor,
  }) {
    return SeniorTabBarStyle(
      indicatorColor: indicatorColor ?? this.indicatorColor,
      labelColor: labelColor ?? this.labelColor,
      unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
    );
  }
}
