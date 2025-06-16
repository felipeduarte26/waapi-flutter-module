import '../input_models/toggle_notification_setting_input_model.dart';
import '../repositories/toggle_user_notification_setting_repository.dart';
import '../types/notification_domain_types.dart';

abstract class ToggleUserNotificationSettingUsecase {
  ToggleUserNotificationSettingCallback call({
    required ToggleNotificationSettingInputModel toggleNotificationSettingInputModel,
  });
}

class ToggleUserNotificationSettingUsecaseImpl implements ToggleUserNotificationSettingUsecase {
  final ToggleUserNotificationSettingRepository _toggleUserNotificationSettingRepository;

  const ToggleUserNotificationSettingUsecaseImpl({
    required ToggleUserNotificationSettingRepository toggleUserNotificationSettingRepository,
  }) : _toggleUserNotificationSettingRepository = toggleUserNotificationSettingRepository;

  @override
  ToggleUserNotificationSettingCallback call({
    required ToggleNotificationSettingInputModel toggleNotificationSettingInputModel,
  }) {
    return _toggleUserNotificationSettingRepository.call(
      toggleNotificationSettingInputModel: toggleNotificationSettingInputModel,
    );
  }
}
