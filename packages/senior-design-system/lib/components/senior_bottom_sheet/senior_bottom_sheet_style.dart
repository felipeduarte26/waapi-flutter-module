import 'package:flutter/material.dart';

class SeniorBottomSheetStyle {
  /// Style definitions for the SeniorBottomSheet component.
  const SeniorBottomSheetStyle({
    this.backgroundColor,
    this.closeButtonColor,
    this.titleColor,
  });

  /// Defines the background color of the bottom sheet.
  final Color? backgroundColor;

  /// Defines the icon color of the bottom sheet close button.
  final Color? closeButtonColor;

  /// Defines the bottom sheet title color.
  final Color? titleColor;

  /// Creates a copy of this [SeniorBottomSheetStyle] but with
  /// the given fields replaced with the new values.
  SeniorBottomSheetStyle copyWith({
    Color? backgroundColor,
    Color? closeButtonColor,
    Color? titleColor,
  }) {
    return SeniorBottomSheetStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      closeButtonColor: closeButtonColor ?? this.closeButtonColor,
      titleColor: titleColor ?? this.titleColor,
    );
  }
}