import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/push_notifications_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/push_notifications_datasource.dart';

class PushNotificationsRepositoryImpl implements PushNotificationsRepository {
  final GetPushNotificationsDatasource getPushNotificationsDatasource;

  const PushNotificationsRepositoryImpl({
    required this.getPushNotificationsDatasource,
  });

  @override
  GetListRecentNotificationsCallback call({
    required String employeeId,
  }) async {
    try {
      final listPushNotifications = await getPushNotificationsDatasource.call(
        employeeId: employeeId,
      );

      return right(listPushNotifications);
    } catch (exception) {
        return left(const NotificationDatasourceFailure());
    }


  }
}
