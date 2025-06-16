import '../repositories/get_native_permission_notification_repository.dart';
import '../types/notification_domain_types.dart';

abstract class GetNativePermissionNotificationUsecase {
  GetNativePermissionNotificationCallback call();
}

class GetNativePermissionNotificationUsecaseImpl implements GetNativePermissionNotificationUsecase {
  final GetNativePermissionNotificationRepository _getNativePermissionNotificationRepository;

  const GetNativePermissionNotificationUsecaseImpl({
    required GetNativePermissionNotificationRepository getNativePermissionNotificationRepository,
  }) : _getNativePermissionNotificationRepository = getNativePermissionNotificationRepository;

  @override
  GetNativePermissionNotificationCallback call() {
    return _getNativePermissionNotificationRepository.call();
  }
}
