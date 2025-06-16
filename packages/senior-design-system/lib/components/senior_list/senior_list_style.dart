import 'package:flutter/material.dart';

class SeniorListStyle {
  /// Style definitions for the SeniorList component.
  const SeniorListStyle({
    this.emphasisTitleColor,
    this.emphasisRightLabelColor,
    this.lineColor,
    this.neutralTitleColor,
    this.neutralRightLabelColor,
    this.rightIconColor,
    this.subtitleColor,
  });

  /// Defines the color of the label on the right of emphasis list items.
  final Color? emphasisRightLabelColor;

  /// Defines the title color of list items of type emphasis.
  final Color? emphasisTitleColor;

  /// Defines the color of the line that separates list items.
  final Color? lineColor;

  /// Defines the color of the label on the right of neutral list items.
  final Color? neutralRightLabelColor;

  /// Defines the title color of neutral list items.
  final Color? neutralTitleColor;

  /// Defines the color of the icon on the right.
  final Color? rightIconColor;

  /// Defines the subtitle color of the list item.
  final Color? subtitleColor;

  SeniorListStyle copyWith({
    Color? emphasisTitleColor,
    Color? emphasisRightLabelColor,
    Color? lineColor,
    Color? neutralTitleColor,
    Color? neutralRightLabelColor,
    Color? rightIconColor,
    Color? subtitleColor,
  }) {
    return SeniorListStyle(
      emphasisTitleColor: emphasisTitleColor ?? this.emphasisTitleColor,
      emphasisRightLabelColor: emphasisRightLabelColor ?? this.emphasisRightLabelColor,
      lineColor: lineColor ?? this.lineColor,
      neutralTitleColor: neutralTitleColor ?? this.neutralTitleColor,
      neutralRightLabelColor: neutralRightLabelColor ?? this.neutralRightLabelColor,
      rightIconColor: rightIconColor ?? this.rightIconColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
    );
  }
}
