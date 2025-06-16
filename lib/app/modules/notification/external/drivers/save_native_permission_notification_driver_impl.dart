import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../enums/notification_permission_status_enum.dart';
import '../../infra/drivers/save_native_permission_notification_driver.dart';

class SaveNativePermissionNotificationDriverImpl implements SaveNativePermissionNotificationDriver {
  final InternalStorageService _internalStorageService;

  const SaveNativePermissionNotificationDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<void> call({
    required NotificationPermissionStatusEnum notificationPermissionStatus,
  }) {
    return _internalStorageService.setInt(
      'permissionStatus',
      notificationPermissionStatus.index,
    );
  }
}
