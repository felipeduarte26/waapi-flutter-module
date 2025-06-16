import 'package:flutter/material.dart';

class SeniorNotificationListStyle {
  /// Style definitions for the Senior Notification List component.
  const SeniorNotificationListStyle({
    this.notificationBodyColor,
    this.notificationFooterColor,
    this.notificationTitleColor,
    this.separatorColor,
    this.titleColor,
  });

  /// Defines the color of the notification body content.
  final Color? notificationBodyColor;

  /// Defines the color of the notification's footer content.
  final Color? notificationFooterColor;

  /// Defines the notification title color.
  final Color? notificationTitleColor;

  /// Defines the color of the notifications tab.
  final Color? separatorColor;

  /// Defines the notification notification list title color.
  final Color? titleColor;

  SeniorNotificationListStyle copyWith({
    Color? notificationBodyColor,
    Color? notificationFooterColor,
    Color? notificationTitleColor,
    Color? separatorColor,
    Color? titleColor,
  }) {
    return SeniorNotificationListStyle(
      notificationBodyColor: notificationBodyColor ?? this.notificationBodyColor,
      notificationFooterColor: notificationFooterColor ?? this.notificationFooterColor,
      notificationTitleColor: notificationTitleColor ?? this.notificationTitleColor,
      separatorColor: separatorColor ?? this.separatorColor,
      titleColor: titleColor ?? this.titleColor,
    );
  }
}
