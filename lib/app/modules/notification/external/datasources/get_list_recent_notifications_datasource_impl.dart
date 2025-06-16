import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_list_recent_notifications_datasource.dart';
import '../../infra/models/notification_model.dart';
import '../mappers/notification_model_mapper.dart';

class GetListRecentNotificationsDatasourceImpl implements GetListRecentNotificationsDatasource {
  final RestService _restService;
  final NotificationModelMapper _notificationModelMapper;

  const GetListRecentNotificationsDatasourceImpl({
    required RestService restService,
    required NotificationModelMapper notificationModelMapper,
  })  : _restService = restService,
        _notificationModelMapper = notificationModelMapper;

  @override
  Future<List<NotificationModel>> call({
    required PaginationRequirements paginationRequirements,
  }) async {
    final notificationsResult = await _restService.appEmployeeNotification().get(
      '/queries/getUserNotifications',
      queryParameters: {
        'page': paginationRequirements.page,
        'size': paginationRequirements.limit,
      },
    );

    return _notificationModelMapper.fromJsonList(
      notificationModelJson: notificationsResult.data!,
    );
  }
}
