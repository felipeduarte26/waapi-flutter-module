import '../../../../core/types/either.dart';
import '../entities/confirm_read_push_message_entity.dart';
import '../failures/notification_failure.dart';
import '../repositories/confirm_read_push_message_repository.dart';

abstract class ConfirmReadPushMessageUseCase {
  Future<ConfirmReadPushMessageEntity> call({
    required String messageId,
  });
}

class ConfirmReadPushMessageUseCaseImpl
    implements ConfirmReadPushMessageUseCase {
  final ConfirmReadPushMessageRepository _confirmReadPushMessageRepository;

  const ConfirmReadPushMessageUseCaseImpl({
    required ConfirmReadPushMessageRepository confirmReadPushMessageRepository,
  }) : _confirmReadPushMessageRepository = confirmReadPushMessageRepository;

  @override
  Future<ConfirmReadPushMessageEntity> call({
    required String messageId,
  }) async {
    Either<NotificationFailure, ConfirmReadPushMessageEntity> callback =
        await _confirmReadPushMessageRepository.call(
      messageId: messageId,
    );

    return callback.fold(
      (left) => ConfirmReadPushMessageEntity(
        confirmed: false,
      ),
      (right) => right,
    );
  }
}
