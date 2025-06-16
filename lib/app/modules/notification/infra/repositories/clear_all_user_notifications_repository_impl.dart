import '../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../core/services/analytics/analytics_service.dart';
import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/clear_all_user_notifications_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/clear_all_user_notifications_datasource.dart';

class ClearAllUserNotificationsRepositoryImpl implements ClearAllUserNotificationsRepository {
  final ClearAllUserNotificationsDatasource _clearAllUserNotificationsDatasource;
  final ErrorLoggingService _errorLoggingService;
  final AnalyticsService _analyticsService;

  const ClearAllUserNotificationsRepositoryImpl({
    required ClearAllUserNotificationsDatasource clearAllUserNotificationsDatasource,
    required ErrorLoggingService errorLoggingService,
    required AnalyticsService analyticsService,
  })  : _clearAllUserNotificationsDatasource = clearAllUserNotificationsDatasource,
        _errorLoggingService = errorLoggingService,
        _analyticsService = analyticsService;

  @override
  ClearAllUserNotificationsCallback call() async {
    try {
      await _clearAllUserNotificationsDatasource.call();

      await _analyticsService.logEvent(
        analyticsEventEnum: AnalyticsEventEnum.notificationsCleaned,
      );

      return right(unit);
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      return left(const NotificationDatasourceFailure());
    }
  }
}
