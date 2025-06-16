import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/get_list_recent_notifications_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../adapters/notification_entity_adapter.dart';
import '../datasources/get_list_recent_notifications_datasource.dart';

class GetListRecentNotificationsRepositoryImpl implements GetListRecentNotificationsRepository {
  final GetListRecentNotificationsDatasource _getListRecentNotificationsDatasource;
  final NotificationEntityAdapter _notificationEntityAdapter;
  final ErrorLoggingService _errorLoggingService;

  const GetListRecentNotificationsRepositoryImpl({
    required GetListRecentNotificationsDatasource getListRecentNotificationsDatasource,
    required NotificationEntityAdapter notificationEntityAdapter,
    required ErrorLoggingService errorLoggingService,
  })  : _getListRecentNotificationsDatasource = getListRecentNotificationsDatasource,
        _notificationEntityAdapter = notificationEntityAdapter,
        _errorLoggingService = errorLoggingService;

  @override
  GetListRecentNotificationsCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final listNotificationModel = await _getListRecentNotificationsDatasource.call(
        paginationRequirements: paginationRequirements,
      );

      final notificationsEntity = listNotificationModel.map(
        (notificationModel) {
          return _notificationEntityAdapter.fromModel(
            notificationModel: notificationModel,
          );
        },
      ).toList();

      return right(notificationsEntity);
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      return left(const NotificationDatasourceFailure());
    }
  }
}
