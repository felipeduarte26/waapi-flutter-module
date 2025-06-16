import '../models/user_notification_setting_model.dart';

abstract class GetUserNotificationSettingsDatasource {
  Future<List<UserNotificationSettingModel>> call();
}
