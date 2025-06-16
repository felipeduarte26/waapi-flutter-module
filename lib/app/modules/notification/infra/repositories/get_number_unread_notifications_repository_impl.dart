import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/get_number_unread_notifications_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/get_number_unread_notifications_datasource.dart';

class GetNumberUnreadNotificationsRepositoryImpl implements GetNumberUnreadNotificationsRepository {
  final GetNumberUnreadNotificationsDatasource _getNumberUnreadNotificationsDatasource;
  final ErrorLoggingService _errorLoggingService;

  const GetNumberUnreadNotificationsRepositoryImpl({
    required GetNumberUnreadNotificationsDatasource getNumberUnreadNotificationsDatasource,
    required ErrorLoggingService errorLoggingService,
  })  : _getNumberUnreadNotificationsDatasource = getNumberUnreadNotificationsDatasource,
        _errorLoggingService = errorLoggingService;

  @override
  GetNumberUnreadNotificationsCallback call() async {
    try {
      final numberUnreadNotifications = await _getNumberUnreadNotificationsDatasource.call();

      return right(numberUnreadNotifications);
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      return left(const NotificationDatasourceFailure());
    }
  }
}
