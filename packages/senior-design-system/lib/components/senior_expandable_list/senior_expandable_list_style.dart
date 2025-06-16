import 'package:flutter/material.dart';

class SeniorExpandableListStyle {
  /// Style definitions for the SeniorExpandableList component.
  const SeniorExpandableListStyle({
    this.titleColor,
    this.summaryColor,
    this.iconColor,
    this.arrowIconColor,
    this.separationLine,
  });

  /// Defines the list items title color.
  final Color? titleColor;

  /// Defines the list items summary color.
  final Color? summaryColor;

  /// Defines the list items icon color.
  final Color? iconColor;

  /// Defines the list items arrow icon color.
  final Color? arrowIconColor;

  /// Defines the list items separation line color.
  final Color? separationLine;

  /// Default style for the SeniorExpandableList component.
  /// This style is used when no style is provided.
  SeniorExpandableListStyle copyWith({
    Color? titleColor,
    Color? summaryColor,
    Color? iconColor,
    Color? arrowIconColor,
    Color? separationLine,
  }) {
    return SeniorExpandableListStyle(
      titleColor: titleColor ?? this.titleColor,
      summaryColor: summaryColor ?? this.summaryColor,
      iconColor: iconColor ?? this.iconColor,
      arrowIconColor: arrowIconColor ?? this.arrowIconColor,
      separationLine: separationLine ?? this.separationLine,
    );
  }
}
