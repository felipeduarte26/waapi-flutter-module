import '../../enums/notification_permission_status_enum.dart';

abstract class SaveNativePermissionNotificationDriver {
  Future<void> call({
    required NotificationPermissionStatusEnum notificationPermissionStatus,
  });
}
