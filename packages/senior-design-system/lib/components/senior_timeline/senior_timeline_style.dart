import 'package:flutter/material.dart';

class SeniorTimelineStyle {
  /// Style definitions for the SeniorTimeline component.
  const SeniorTimelineStyle({
    this.expandIconColor,
    this.expandIconSize,
  });

  /// Defines the color of the expand icon.
  final Color? expandIconColor;

  /// Defines the size of the expand icon.
  final double? expandIconSize;

  SeniorTimelineStyle copyWith({
    Color? expandIconColor,
    double? expandIconSize,
  }) {
    return SeniorTimelineStyle(
      expandIconColor: expandIconColor ?? this.expandIconColor,
      expandIconSize: expandIconSize ?? this.expandIconSize,
    );
  }
}
