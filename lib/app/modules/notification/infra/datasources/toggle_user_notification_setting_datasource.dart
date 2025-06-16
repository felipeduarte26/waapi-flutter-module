import '../../domain/input_models/toggle_notification_setting_input_model.dart';

abstract class ToggleUserNotificationSettingDatasource {
  Future<void> call({
    required ToggleNotificationSettingInputModel toggleNotificationSettingInputModel,
  });
}
