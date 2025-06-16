import 'package:flutter/material.dart';

class SeniorProgressBarStyle {
  /// Style definitions for the SeniorProgressBar component.
  const SeniorProgressBarStyle({
    this.backgroundColor,
    this.color,
    this.progressInfoColor,
    this.subtitleColor,
    this.titleColor,
  });

  /// Defines the background color of the scrollbar.
  final Color? backgroundColor;

  /// Defines the color of the current scrollbar level.
  final Color? color;

  /// Defines the color of the current progress information.
  final Color? progressInfoColor;

  /// Defines the color of the subtitle shown in the component.
  final Color? subtitleColor;

  /// Defines the color of the title shown on the component.
  final Color? titleColor;

  SeniorProgressBarStyle copyWith({
    Color? backgroundColor,
    Color? color,
    Color? progressInfoColor,
    Color? subtitleColor,
    Color? titleColor,
  }) {
    return SeniorProgressBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      color: color ?? this.color,
      progressInfoColor: progressInfoColor ?? this.progressInfoColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      titleColor: titleColor ?? this.titleColor,
    );
  }
}
