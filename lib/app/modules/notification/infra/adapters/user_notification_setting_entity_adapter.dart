import '../../domain/entities/user_notification_setting_entity.dart';
import '../models/user_notification_setting_model.dart';

class UserNotificationSettingEntityAdapter {
  UserNotificationSettingEntity fromModel({
    required UserNotificationSettingModel userNotificationSettingModel,
  }) {
    return UserNotificationSettingEntity(
      id: userNotificationSettingModel.id,
      notificationEnabled: userNotificationSettingModel.notificationEnabled,
      notificationType: userNotificationSettingModel.notificationType,
    );
  }
}
