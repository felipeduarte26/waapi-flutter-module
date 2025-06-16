import 'dart:convert';

import '../../../../core/helper/enum_helper.dart';
import '../../enums/notification_type_enum.dart';
import '../../helpers/notification_filter.dart';
import '../../infra/models/user_notification_setting_model.dart';

class UserNotificationSettingModelMapper {
  UserNotificationSettingModel fromMap({
    required Map<String, dynamic> userNotificationSettingMap,
  }) {
    return UserNotificationSettingModel(
      id: userNotificationSettingMap['id'] ?? '',
      notificationEnabled: userNotificationSettingMap['notificationEnabled'] ?? false,
      notificationType: EnumHelper<NotificationTypeEnum>().stringToEnum(
            stringToParse: userNotificationSettingMap['notificationType'],
            values: NotificationTypeEnum.values,
          ) ??
          NotificationTypeEnum.hcmFeedbackReceived,
    );
  }

  List<UserNotificationSettingModel> fromJson({
    required String userNotificationSettingJson,
  }) {
    final userNotificationSettingDecoded = json.decode(userNotificationSettingJson);

    var resultMapData = (userNotificationSettingDecoded['settings'] as List);

    // This is not a business logic implementation. It is only here to us, developers, do not deal with
    // errors while we are still implementing new notification types, and, by consequence for users as well if
    // we release a new backend with no mobile version compatible with it.
    resultMapData = resultMapData.where((notification) {
      return NotificationFilter.typeIsAccepted(
        type: notification['notificationType'],
      );
    }).toList();

    return resultMapData.map(
      (userNotificationSettingMap) {
        return fromMap(
          userNotificationSettingMap: userNotificationSettingMap,
        );
      },
    ).toList();
  }
}
