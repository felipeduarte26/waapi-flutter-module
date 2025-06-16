import '../../domain/entities/notification_parameters_entity.dart';
import '../models/notification_parameters_model.dart';

class NotificationParametersEntityAdapter {
  NotificationParametersEntity fromModel({
    required NotificationParametersModel notificationParametersModel,
  }) {
    return NotificationParametersEntity(
      id: notificationParametersModel.id,
    );
  }
}
