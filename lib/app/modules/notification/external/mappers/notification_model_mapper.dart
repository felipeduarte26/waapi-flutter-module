import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/notification_type_enum.dart';
import '../../helpers/notification_filter.dart';
import '../../infra/models/notification_model.dart';
import 'notification_parameters_model_mapper.dart';

class NotificationModelMapper {
  final NotificationParametersModelMapper _notificationParametersModelMapper;

  const NotificationModelMapper({
    required NotificationParametersModelMapper notificationParametersModelMapper,
  }) : _notificationParametersModelMapper = notificationParametersModelMapper;

  NotificationModel fromMap({
    required Map<String, dynamic> notificationMap,
  }) {
    return NotificationModel(
      id: notificationMap['id'] ?? '',
      title: notificationMap['title'] ?? '',
      content: notificationMap['content'] ?? '',
      notificationType: EnumHelper<NotificationTypeEnum>().stringToEnum(
            stringToParse: notificationMap['notificationType'],
            values: NotificationTypeEnum.values,
          ) ??
          NotificationTypeEnum.hcmFeedbackReceived,
      createdDate: DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: notificationMap['createdDate'] ?? '',
      ),
      hasRead: (notificationMap['hasRead'] is String) ? false : notificationMap['hasRead'],
      notificationParameters: _notificationParametersModelMapper.fromJson(
        notificationParametersJson: notificationMap['additionalParameters'] ?? '',
      ),
    );
  }

  List<NotificationModel> fromJsonList({
    required String? notificationModelJson,
  }) {
    if (notificationModelJson == null || notificationModelJson.isEmpty) {
      return [];
    }

    final Map<String, dynamic> resultMapData = json.decode(notificationModelJson);

    var notificationsMapData = ((resultMapData['notifications'] ?? []) as List);

    // This cannot be considered as a business logic implementation. It is only to us, developers, do not had to deal
    // with errors while we are still implementing new notification types, and, by consequence for users as well if
    // we release a new backend with no mobile version compatible with it.
    notificationsMapData = notificationsMapData.where((notification) {
      return NotificationFilter.typeIsAccepted(
        type: notification['notificationType'],
      );
    }).toList();

    return (notificationsMapData).map(
      (requestMap) {
        return fromMap(
          notificationMap: requestMap,
        );
      },
    ).toList();
  }
}
