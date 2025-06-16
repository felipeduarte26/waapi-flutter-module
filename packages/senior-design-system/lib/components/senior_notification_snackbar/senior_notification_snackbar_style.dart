import 'package:flutter/material.dart';

class SeniorNotificationSnackbarStyle {
  /// Theme definitions for the Senior Notification Snackbar component.
  const SeniorNotificationSnackbarStyle({
    this.borderColor,
    this.color,
    this.titleColor,
    this.messageColor,
    this.actionButtonColor,
  });

  /// Defines the color of the snackbar border.
  final Color? borderColor;

  /// Defines the color of the snackbar.
  final Color? color;

  /// Defines the color of the snackbar title.
  final Color? titleColor;

  /// Defines the color of the snackbar message text.
  final Color? messageColor;

  /// Defines the color of the message action button.
  final Color? actionButtonColor;

  SeniorNotificationSnackbarStyle copyWith({
    Color? borderColor,
    Color? color,
    Color? titleColor,
    Color? messageColor,
    Color? actionButtonColor,
  }) {
    return SeniorNotificationSnackbarStyle(
      borderColor: borderColor ?? this.borderColor,
      color: color ?? this.color,
      titleColor: titleColor ?? this.titleColor,
      messageColor: messageColor ?? this.messageColor,
      actionButtonColor: actionButtonColor ?? this.actionButtonColor,
    );
  }
}
