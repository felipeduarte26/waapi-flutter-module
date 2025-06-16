import '../../domain/entities/notification_entity.dart';
import '../models/notification_model.dart';
import 'notification_parameters_entity_adapter.dart';

class NotificationEntityAdapter {
  final NotificationParametersEntityAdapter _notificationParameters;

  const NotificationEntityAdapter({
    required NotificationParametersEntityAdapter notificationParametersEntityAdapter,
  }) : _notificationParameters = notificationParametersEntityAdapter;

  NotificationEntity fromModel({
    required NotificationModel notificationModel,
  }) {
    return NotificationEntity(
      id: notificationModel.id,
      title: notificationModel.title,
      content: notificationModel.content,
      notificationParameters: _notificationParameters.fromModel(
        notificationParametersModel: notificationModel.notificationParameters,
      ),
      notificationType: notificationModel.notificationType,
      createdDate: notificationModel.createdDate,
      hasRead: notificationModel.hasRead,
    );
  }
}
