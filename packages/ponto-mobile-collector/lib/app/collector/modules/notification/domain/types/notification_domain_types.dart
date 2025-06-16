import '../../../../core/types/either.dart';
import '../entities/confirm_read_push_message_entity.dart';
import '../entities/has_unread_push_message_entity.dart';
import '../entities/push_notification_dto.dart';
import '../failures/notification_failure.dart';

typedef GetListRecentNotificationsCallback = Future<Either<NotificationFailure, PushNotificationDto>>;
typedef GetNumberUnreadNotificationsCallback = Future<Either<NotificationFailure, HasUnreadPushMessageEntity>>;
typedef ConfirmReadPushMessageCallBack = Future<Either<NotificationFailure, ConfirmReadPushMessageEntity>>;
