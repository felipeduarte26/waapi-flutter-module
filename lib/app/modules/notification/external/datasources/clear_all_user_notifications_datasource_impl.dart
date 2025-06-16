import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/clear_all_user_notifications_datasource.dart';

class ClearAllUserNotificationsDatasourceImpl implements ClearAllUserNotificationsDatasource {
  final RestService _restService;

  const ClearAllUserNotificationsDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call() async {
    await _restService.appEmployeeNotification().post(
      '/actions/deleteAllUserNotifications',
      body: {},
    );
  }
}
