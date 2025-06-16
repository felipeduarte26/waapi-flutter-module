import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/get_number_unread_notifications_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/get_number_unread_notifications_datasource.dart';

class GetNumberUnreadNotificationsRepositoryImpl
    implements GetNumberUnreadNotificationsRepository {
  final GetNumberUnreadNotificationsDatasource
      _getNumberUnreadNotificationsDatasource;

  const GetNumberUnreadNotificationsRepositoryImpl({
    required GetNumberUnreadNotificationsDatasource
        getNumberUnreadNotificationsDatasource,
  }) : _getNumberUnreadNotificationsDatasource =
            getNumberUnreadNotificationsDatasource;

  @override
  GetNumberUnreadNotificationsCallback call({
    required String employeeId,
  }) async {
    try {
      final numberUnreadNotifications =
          await _getNumberUnreadNotificationsDatasource.call(
        employeeId: employeeId,
      );

      return right(numberUnreadNotifications);
    } catch (exception) {
      return left(const NotificationDatasourceFailure());
    }
  }
}
