import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/save_native_permission_notification_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../../enums/notification_permission_status_enum.dart';
import '../drivers/save_native_permission_notification_driver.dart';

class SaveNativePermissionNotificationRepositoryImpl implements SaveNativePermissionNotificationRepository {
  final SaveNativePermissionNotificationDriver _saveNativePermissionNotificationDriver;
  final ErrorLoggingService _errorLoggingService;

  const SaveNativePermissionNotificationRepositoryImpl({
    required SaveNativePermissionNotificationDriver saveNativePermissionNotificationDriver,
    required ErrorLoggingService errorLoggingService,
  })  : _saveNativePermissionNotificationDriver = saveNativePermissionNotificationDriver,
        _errorLoggingService = errorLoggingService;

  @override
  SaveNativePermissionNotificationCallback call({
    required NotificationPermissionStatusEnum notificationPermissionStatus,
  }) async {
    try {
      await _saveNativePermissionNotificationDriver.call(
        notificationPermissionStatus: notificationPermissionStatus,
      );

      return right(unit);
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      return left(const NotificationDriverFailure());
    }
  }
}
