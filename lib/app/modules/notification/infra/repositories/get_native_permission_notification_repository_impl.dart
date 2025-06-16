import 'package:platform/platform.dart';

import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/get_native_permission_notification_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../../enums/notification_permission_status_enum.dart';
import '../drivers/get_native_permission_notification_driver.dart';
import '../drivers/get_saved_permission_notification_driver.dart';
import '../drivers/save_native_permission_notification_driver.dart';

class GetNativePermissionNotificationRepositoryImpl implements GetNativePermissionNotificationRepository {
  final GetNativePermissionNotificationDriver _getNativePermissionNotificationDriver;
  final GetSavedPermissionNotificationDriver _getSavedPermissionNotificationDriver;
  final SaveNativePermissionNotificationDriver _saveNativePermissionNotificationDriver;
  final LocalPlatform _localPlatform;
  final ErrorLoggingService _errorLoggingService;

  const GetNativePermissionNotificationRepositoryImpl({
    required GetNativePermissionNotificationDriver getNativePermissionNotificationDriver,
    required GetSavedPermissionNotificationDriver getSavedPermissionNotificationDriver,
    required SaveNativePermissionNotificationDriver saveNativePermissionNotificationDriver,
    required LocalPlatform localPlatform,
    required ErrorLoggingService errorLoggingService,
  })  : _getNativePermissionNotificationDriver = getNativePermissionNotificationDriver,
        _getSavedPermissionNotificationDriver = getSavedPermissionNotificationDriver,
        _saveNativePermissionNotificationDriver = saveNativePermissionNotificationDriver,
        _localPlatform = localPlatform,
        _errorLoggingService = errorLoggingService;

  @override
  GetNativePermissionNotificationCallback call() async {
    try {
      final nativePermissionDriver = await _getNativePermissionNotificationDriver.call();

      final savedPermissionDriver = _getSavedPermissionNotificationDriver.call();

      if (nativePermissionDriver == NotificationPermissionStatusEnum.denied &&
          savedPermissionDriver == NotificationPermissionStatusEnum.authorized) {
        return right(NotificationPermissionStatusEnum.forceRequest);
      }

      if (_localPlatform.isAndroid && savedPermissionDriver == NotificationPermissionStatusEnum.denied ||
          _localPlatform.isAndroid && savedPermissionDriver == NotificationPermissionStatusEnum.notDetermined) {
        return right(savedPermissionDriver);
      }

      await _saveNativePermissionNotificationDriver.call(
        notificationPermissionStatus: nativePermissionDriver,
      );

      return right(nativePermissionDriver);
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      return left(const NotificationDriverFailure());
    }
  }
}
