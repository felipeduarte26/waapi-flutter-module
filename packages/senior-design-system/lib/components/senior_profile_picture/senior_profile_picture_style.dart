import 'package:flutter/material.dart';

class SeniorProfilePictureStyle {
  /// Style definitions for the SeniorProfilePicture component.
  const SeniorProfilePictureStyle({
    this.backgroundColor,
    this.loadingOverlappingdColor,
    this.textColor,
  });

  /// Defines the background color of the profile picture.
  final Color? backgroundColor;

  /// Defines the overlay color when the component is loading.
  final Color? loadingOverlappingdColor;

  /// Defines the text color of the profile picture.
  final Color? textColor;

  SeniorProfilePictureStyle copyWith({
    Color? backgroundColor,
    Color? loadingOverlappingdColor,
    Color? textColor,
  }) {
    return SeniorProfilePictureStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      loadingOverlappingdColor: loadingOverlappingdColor ?? this.loadingOverlappingdColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
