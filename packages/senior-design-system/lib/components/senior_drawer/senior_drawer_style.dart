import 'package:flutter/material.dart';

class SeniorDrawerStyle {
  /// Style definitions for the SeniorDrawer component.
  const SeniorDrawerStyle({
    this.backgroundColor,
    this.backIconColor,
    this.boldItemColor,
    this.emphasisItemColor,
    this.footerTextColor,
    this.lineColor,
    this.neutralItemColor,
    this.profileSubtitleColor,
    this.profileTitleColor,
  });

  /// Defines the background color for the drawer.
  final Color? backgroundColor;

  /// Defines the color of the drawer back icon.
  final Color? backIconColor;

  /// Defines the color of bold type items.
  final Color? boldItemColor;

  /// Defines the color of items of type emphasis.
  final Color? emphasisItemColor;

  /// Defines the footer text color.
  final Color? footerTextColor;

  /// Defines the color of the line that separates the profile area and the items list.
  final Color? lineColor;

  /// Defines the color of neutral type items.
  final Color? neutralItemColor;

  /// Defines the profile's subtitle color.
  final Color? profileSubtitleColor;

  /// Defines the profile title color.
  final Color? profileTitleColor;

  SeniorDrawerStyle copyWith({
    Color? backgroundColor,
    Color? backIconColor,
    Color? boldItemColor,
    Color? emphasisItemColor,
    Color? footerTextColor,
    Color? lineColor,
    Color? neutralItemColor,
    Color? profileSubtitleColor,
    Color? profileTitleColor,
  }) {
    return SeniorDrawerStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backIconColor: backIconColor ?? this.backIconColor,
      boldItemColor: boldItemColor ?? this.boldItemColor,
      emphasisItemColor: emphasisItemColor ?? this.emphasisItemColor,
      footerTextColor: footerTextColor ?? this.footerTextColor,
      lineColor: lineColor ?? this.lineColor,
      neutralItemColor: neutralItemColor ?? this.neutralItemColor,
      profileSubtitleColor: profileSubtitleColor ?? this.profileSubtitleColor,
      profileTitleColor: profileTitleColor ?? this.profileTitleColor,
    );
  }
}
