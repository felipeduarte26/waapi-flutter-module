import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/toggle_notification_setting_input_model.dart';
import '../../enums/notification_type_enum.dart';

class ToggleNotificationSettingInputModelMapper {
  Map<String, dynamic> toMap({
    required ToggleNotificationSettingInputModel toggleNotificationSettingInputModel,
  }) {
    return {
      'notificationType': EnumHelper<NotificationTypeEnum>().enumToString(
        enumToParse: toggleNotificationSettingInputModel.notificationType,
      ),
      'notificationEnabled': toggleNotificationSettingInputModel.notificationEnabled,
    };
  }
}
