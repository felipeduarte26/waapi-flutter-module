import 'package:flutter/material.dart';

class SeniorSnackbarStyle {
  /// Style definitions for the SeniorSnackbar component.
  const SeniorSnackbarStyle({
    this.backgroundColor,
    this.fontColor,
    this.iconColor,
  });

  /// Defines the background color of the snackbar.
  final Color? backgroundColor;

  /// Defines the snackbar font color.
  final Color? fontColor;

  /// Defines the color of the snackbar icon.
  final Color? iconColor;

  SeniorSnackbarStyle copyWith({
    Color? backgroundColor,
    Color? fontColor,
    Color? iconColor,
  }) {
    return SeniorSnackbarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontColor: fontColor ?? this.fontColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

}
