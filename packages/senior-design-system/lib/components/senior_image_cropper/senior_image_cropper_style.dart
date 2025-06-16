import 'package:flutter/material.dart';

class SeniorImageCropperStyle {
  /// Style definitions for the SeniorImageCropper component.
  const SeniorImageCropperStyle({
    this.toolbarColor,
    this.toolbarContentColor,
    this.activeControlsColor,
  });

  /// Define the toolbar color of the crop view.
  final Color? toolbarColor;

  /// Defines the toolbar content color of the crop view.
  final Color? toolbarContentColor;

  /// Defines the color of the active controls of the crop view.
  final Color? activeControlsColor;

  SeniorImageCropperStyle copyWith({
    Color? toolbarColor,
    Color? toolbarContentColor,
    Color? activeControlsColor,
  }) {
    return SeniorImageCropperStyle(
      toolbarColor: toolbarColor ?? this.toolbarColor,
      toolbarContentColor: toolbarContentColor ?? this.toolbarContentColor,
      activeControlsColor: activeControlsColor ?? this.activeControlsColor,
    );
  }
}
