import 'dart:convert';

import '../../infra/models/notification_parameters_model.dart';

class NotificationParametersModelMapper {
  NotificationParametersModel fromMap({
    required Map<String, dynamic> notificationParametersModel,
  }) {
    return NotificationParametersModel(id: notificationParametersModel['id'] ?? '');
  }

  NotificationParametersModel fromJson({
    required String notificationParametersJson,
  }) {
    if (notificationParametersJson.isEmpty) {
      return const NotificationParametersModel(id: '');
    }

    try {
      final Map<String, dynamic> resultMapData = json.decode(
        notificationParametersJson,
      );

      return fromMap(
        notificationParametersModel: resultMapData,
      );
    } catch (e) {
      return const NotificationParametersModel(id: '');
    }
  }
}
