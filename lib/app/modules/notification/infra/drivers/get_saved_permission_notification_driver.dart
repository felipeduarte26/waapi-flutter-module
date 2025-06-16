import '../../enums/notification_permission_status_enum.dart';

abstract class GetSavedPermissionNotificationDriver {
  NotificationPermissionStatusEnum call();
}
