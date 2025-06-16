import 'package:flutter/material.dart';

class SeniorBottomNavigationBarStyle {
  /// Style definitions for the SeniorBottomNavigationBar component.
  const SeniorBottomNavigationBarStyle({
    this.badgeColor,
    this.badgeItemColor,
    this.color,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  /// Defines the badge color of bottom navigation bar items.
  final Color? badgeColor;

  /// Defines the content color of badges for bottom navigation bar items.
  final Color? badgeItemColor;

  /// Defines the color of the bottom navigation bar.
  final Color? color;

  /// Defines the color of the selected bottom navigation bar item.
  final Color? selectedItemColor;

  /// Defines the color of unselected bottom navigation bar items.
  final Color? unselectedItemColor;

  /// Creates a copy of this [SeniorBottomNavigationBarStyle] but with
  /// the given fields replaced with the new values.
  SeniorBottomNavigationBarStyle copyWith({
    Color? badgeColor,
    Color? badgeItemColor,
    Color? color,
    Color? selectedItemColor,
    Color? unselectedItemColor,
  }) {
    return SeniorBottomNavigationBarStyle(
      badgeColor: badgeColor ?? this.badgeColor,
      badgeItemColor: badgeItemColor ?? this.badgeItemColor,
      color: color ?? this.color,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
    );
  }
}