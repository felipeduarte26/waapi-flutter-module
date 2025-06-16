import '../repositories/get_user_notification_settings_repository.dart';
import '../types/notification_domain_types.dart';

abstract class GetUserNotificationSettingsUsecase {
  GetUserNotificationSettingsCallback call();
}

class GetUserNotificationSettingsUsecaseImpl implements GetUserNotificationSettingsUsecase {
  final GetUserNotificationSettingsRepository _getUserNotificationSettingsRepository;

  const GetUserNotificationSettingsUsecaseImpl({
    required GetUserNotificationSettingsRepository getUserNotificationSettingsRepository,
  }) : _getUserNotificationSettingsRepository = getUserNotificationSettingsRepository;

  @override
  GetUserNotificationSettingsCallback call() {
    return _getUserNotificationSettingsRepository.call();
  }
}
