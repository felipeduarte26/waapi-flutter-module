import '../../enums/notification_permission_status_enum.dart';
import '../repositories/save_native_permission_notification_repository.dart';
import '../types/notification_domain_types.dart';

abstract class SaveNativePermissionNotificationUsecase {
  SaveNativePermissionNotificationCallback call({
    required NotificationPermissionStatusEnum notificationPermissionStatus,
  });
}

class SaveNativePermissionNotificationUsecaseImpl implements SaveNativePermissionNotificationUsecase {
  final SaveNativePermissionNotificationRepository _saveNativePermissionNotificationRepository;

  const SaveNativePermissionNotificationUsecaseImpl({
    required SaveNativePermissionNotificationRepository saveNativePermissionNotificationRepository,
  }) : _saveNativePermissionNotificationRepository = saveNativePermissionNotificationRepository;

  @override
  SaveNativePermissionNotificationCallback call({
    required NotificationPermissionStatusEnum notificationPermissionStatus,
  }) {
    return _saveNativePermissionNotificationRepository.call(
      notificationPermissionStatus: notificationPermissionStatus,
    );
  }
}
