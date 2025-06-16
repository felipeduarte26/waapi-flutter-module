import '../../enums/notification_permission_status_enum.dart';
import '../types/notification_domain_types.dart';

abstract class SaveNativePermissionNotificationRepository {
  SaveNativePermissionNotificationCallback call({
    required NotificationPermissionStatusEnum notificationPermissionStatus,
  });
}
