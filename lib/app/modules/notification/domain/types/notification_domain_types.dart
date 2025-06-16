import '../../../../core/types/either.dart';
import '../../enums/notification_permission_status_enum.dart';
import '../entities/notification_entity.dart';
import '../entities/user_notification_setting_entity.dart';
import '../failures/notification_failure.dart';

typedef GetNativePermissionNotificationCallback = Future<Either<NotificationFailure, NotificationPermissionStatusEnum>>;
typedef GetDeviceTokenCallback = Future<Either<NotificationFailure, String>>;
typedef RegisterDeviceTokenCallback = Future<Either<NotificationFailure, Unit>>;
typedef ClearDeviceTokenCallback = Future<Either<NotificationFailure, Unit>>;
typedef SaveNativePermissionNotificationCallback = Future<Either<NotificationFailure, Unit>>;
typedef GetUserNotificationSettingsCallback = Future<Either<NotificationFailure, List<UserNotificationSettingEntity>>>;
typedef ToggleUserNotificationSettingCallback = Future<Either<NotificationFailure, Unit>>;
typedef GetNumberUnreadNotificationsCallback = Future<Either<NotificationFailure, int>>;
typedef MarkNotificationAsReadCallback = Future<Either<NotificationFailure, Unit>>;
typedef GetListRecentNotificationsCallback = Future<Either<NotificationFailure, List<NotificationEntity>>>;
typedef ClearAllUserNotificationsCallback = Future<Either<NotificationFailure, Unit>>;
typedef OpenNativeAppSettingsCallback = Future<Either<NotificationFailure, Unit>>;
