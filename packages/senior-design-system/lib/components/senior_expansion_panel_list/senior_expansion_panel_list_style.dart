import 'package:flutter/material.dart';

class SeniorExpansionPanelListStyle {
  /// Style definitions for the SeniorExpansionPanelList component.
  const SeniorExpansionPanelListStyle({
    this.backgroundColor,
  });

  /// Defines the component's background color.
  final Color? backgroundColor;

  /// Default style for the SeniorExpansionPanelList component.
  /// This style is used when no style is provided.
  SeniorExpansionPanelListStyle copyWith({
    Color? backgroundColor,
  }) {
    return SeniorExpansionPanelListStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
