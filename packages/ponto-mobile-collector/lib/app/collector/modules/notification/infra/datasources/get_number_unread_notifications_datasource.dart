import '../../domain/entities/has_unread_push_message_entity.dart';

abstract class GetNumberUnreadNotificationsDatasource {
  Future<HasUnreadPushMessageEntity> call({
    required String employeeId,
  });
}
