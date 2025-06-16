import '../types/notification_domain_types.dart';

abstract class ConfirmReadPushMessageRepository {
  ConfirmReadPushMessageCallBack call({
    required String messageId,
  });
}
