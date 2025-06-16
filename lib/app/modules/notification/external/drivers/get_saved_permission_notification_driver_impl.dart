import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../enums/notification_permission_status_enum.dart';
import '../../infra/drivers/get_saved_permission_notification_driver.dart';

class GetSavedPermissionNotificationDriverImpl implements GetSavedPermissionNotificationDriver {
  final InternalStorageService _internalStorageService;

  const GetSavedPermissionNotificationDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  NotificationPermissionStatusEnum call() {
    final indexPermission = _internalStorageService.getInt(
      'permissionStatus',
    );

    if (indexPermission == null) {
      return NotificationPermissionStatusEnum.notDetermined;
    }

    return [
      NotificationPermissionStatusEnum.authorized,
      NotificationPermissionStatusEnum.denied,
      NotificationPermissionStatusEnum.notDetermined,
    ][indexPermission];
  }
}
