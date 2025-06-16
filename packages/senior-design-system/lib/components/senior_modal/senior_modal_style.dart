import 'package:flutter/material.dart';

class SeniorModalStyle {
  /// Style definitions for the SeniorModal component.
  const SeniorModalStyle({
    this.backgroundColor,
    this.contentColor,
    this.titleColor,
  });

  /// Defines the background color of the modal.
  final Color? backgroundColor;
  final Color? contentColor;
  final Color? titleColor;

  SeniorModalStyle copyWith({
    Color? backgroundColor,
    Color? contentColor,
    Color? titleColor,
  }) {
    return SeniorModalStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      contentColor: contentColor ?? this.contentColor,
      titleColor: titleColor ?? this.titleColor,
    );
  }
}
