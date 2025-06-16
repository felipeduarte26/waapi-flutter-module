import '../input_models/toggle_notification_setting_input_model.dart';
import '../types/notification_domain_types.dart';

abstract class ToggleUserNotificationSettingRepository {
  ToggleUserNotificationSettingCallback call({
    required ToggleNotificationSettingInputModel toggleNotificationSettingInputModel,
  });
}
