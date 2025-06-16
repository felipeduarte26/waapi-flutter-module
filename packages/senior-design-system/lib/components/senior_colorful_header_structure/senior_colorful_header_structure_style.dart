import 'package:flutter/material.dart';

class SeniorColorfulHeaderStructureStyle {
  /// Style definitions for the Senior Colorful Header Structure component.
  const SeniorColorfulHeaderStructureStyle({
    this.bodyColor,
    this.headerColors,
    this.successMessageBackgroundColor,
    this.successMessageIconColor,
    this.infoMessageBackgroundColor,
    this.infoMessageIconColor,
    this.warningMessageBackgroundColor,
    this.warningMessageIconColor,
    this.errorMessageBackgroundColor,
    this.errorMessageIconColor,
    this.messageTextColor,
    this.messageIconColor,
  });

  /// Defines the color for the component's body.
  final Color? bodyColor;

  /// Defines the colors for the title bar gradient.
  final List<Color>? headerColors;

  /// Defines the color for the message icon when it's success status.
  final Color? successMessageIconColor;

  /// Defines the color for the message background when it's success status.
  final Color? successMessageBackgroundColor;

  /// Defines the color for the message icon when it's information status.
  final Color? infoMessageIconColor;

  /// Defines the color for the message background when it's information status.
  final Color? infoMessageBackgroundColor;

  /// Defines the color for the message icon when it's warning status.
  final Color? warningMessageIconColor;

  /// Defines the color for the message background when it's warning status.
  final Color? warningMessageBackgroundColor;

  /// Defines the color for the message icon when it's error status.
  final Color? errorMessageIconColor;

  /// Defines the color for the message background when it's error status.
  final Color? errorMessageBackgroundColor;

  /// Defines the color for the message text.
  final Color? messageTextColor;

  /// Defines the color for the message icon.
  final Color? messageIconColor;

  SeniorColorfulHeaderStructureStyle copyWith({
    Color? bodyColor,
    List<Color>? headerColors,
    Color? successMessageIconColor,
    Color? successMessageBackgroundColor,
    Color? infoMessageIconColor,
    Color? infoMessageBackgroundColor,
    Color? warningMessageIconColor,
    Color? warningMessageBackgroundColor,
    Color? errorMessageIconColor,
    Color? errorMessageBackgroundColor,
    Color? messageTextColor,
    Color? messageIconColor,
  }) {
    return SeniorColorfulHeaderStructureStyle(
      bodyColor: bodyColor ?? this.bodyColor,
      headerColors: headerColors ?? this.headerColors,
      successMessageIconColor: successMessageIconColor ?? this.successMessageIconColor,
      successMessageBackgroundColor: successMessageBackgroundColor ?? this.successMessageBackgroundColor,
      infoMessageIconColor: infoMessageIconColor ?? this.infoMessageIconColor,
      infoMessageBackgroundColor: infoMessageBackgroundColor ?? this.infoMessageBackgroundColor,
      warningMessageIconColor: warningMessageIconColor ?? this.warningMessageIconColor,
      warningMessageBackgroundColor: warningMessageBackgroundColor ?? this.warningMessageBackgroundColor,
      errorMessageIconColor: errorMessageIconColor ?? this.errorMessageIconColor,
      errorMessageBackgroundColor: errorMessageBackgroundColor ?? this.errorMessageBackgroundColor,
      messageTextColor: messageTextColor ?? this.messageTextColor,
      messageIconColor: messageIconColor ?? this.messageIconColor,
    );
  }
}
