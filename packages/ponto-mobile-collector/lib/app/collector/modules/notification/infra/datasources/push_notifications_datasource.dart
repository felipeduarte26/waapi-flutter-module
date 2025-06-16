import '../../domain/entities/push_notification_dto.dart';

abstract class GetPushNotificationsDatasource {
  Future<PushNotificationDto> call({
    required String employeeId,
  });
}
