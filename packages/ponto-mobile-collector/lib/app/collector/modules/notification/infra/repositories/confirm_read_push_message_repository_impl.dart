import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/confirm_read_push_message_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/confirm_read_push_message_datasource.dart';

class ConfirmReadPushMessageRepositoryImpl
    implements ConfirmReadPushMessageRepository {
  final ConfirmReadPushMessageDataSource
      _confirmReadPushMessageDataSource;

  const ConfirmReadPushMessageRepositoryImpl({
    required ConfirmReadPushMessageDataSource
        confirmReadPushMessageDataSource,
  }) : _confirmReadPushMessageDataSource =
            confirmReadPushMessageDataSource;

  @override
  ConfirmReadPushMessageCallBack call({
    required String messageId,
  }) async {
    try {
      final confirmReadPushMessage =
          await _confirmReadPushMessageDataSource.call(
        messageId: messageId,
      );

      return right(confirmReadPushMessage);
    } catch (exception) {
      return left(const NotificationDatasourceFailure());
    }
  }
}
