import 'senior_notification_snackbar.dart';

class SeniorNotificationSnackbarThemeData {
  /// Theme definitions for the Senior Notification Snackbar component.
  const SeniorNotificationSnackbarThemeData({
    this.style,
  });

  /// The style definitions for the component.
  /// [SeniorNotificationSnackbarStyle.borderColor] the color of the snackbar border.
  /// [SeniorNotificationSnackbarStyle.color] the color of the snackbar.
  /// [SeniorNotificationSnackbarStyle.titleColor] the color of the snackbar title.
  /// [SeniorNotificationSnackbarStyle.messageColor] the color of the snackbar message text.
  /// [SeniorNotificationSnackbarStyle.actionButtonColor] the color of the message action button.
  final SeniorNotificationSnackbarStyle? style;

  SeniorNotificationSnackbarThemeData copyWith({
    SeniorNotificationSnackbarStyle? style,
  }) {
    return SeniorNotificationSnackbarThemeData(
      style: style ?? this.style,
    );
  }
}
