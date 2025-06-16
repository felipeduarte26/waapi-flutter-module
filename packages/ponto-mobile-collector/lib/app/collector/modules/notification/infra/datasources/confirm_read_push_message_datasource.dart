import '../../domain/entities/confirm_read_push_message_entity.dart';

abstract class ConfirmReadPushMessageDataSource {
  Future<ConfirmReadPushMessageEntity> call({
    required String messageId,
  });
}
