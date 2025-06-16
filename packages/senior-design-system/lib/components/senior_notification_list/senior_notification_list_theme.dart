import './senior_notification_list_style.dart';

class SeniorNotificationListThemeData {
  /// Theme definitions for the Senior Notification List component.
  const SeniorNotificationListThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorNotificationListStyle.notificationBodyColor] the color of the notification's body content.
  /// [SeniorNotificationListStyle.notificationFooterColor] the color of the notification's footer content.
  /// [SeniorNotificationListStyle.notificationTitleColor] the color of the notification title.
  /// [SeniorNotificationListStyle.separatorColor] the color of the notifications separator.
  /// [SeniorNotificationListStyle.titleColor] the color of the notification list title.
  final SeniorNotificationListStyle? style;

  SeniorNotificationListThemeData copyWith({
    SeniorNotificationListStyle? style,
  }) {
    return SeniorNotificationListThemeData(
      style: style ?? this.style,
    );
  }
}
