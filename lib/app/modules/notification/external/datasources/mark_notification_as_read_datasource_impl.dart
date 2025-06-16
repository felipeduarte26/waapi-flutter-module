import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/mark_notification_as_read_input_model.dart';
import '../../infra/datasources/mark_notification_as_read_datasource.dart';

class MarkNotificationAsReadDatasourceImpl implements MarkNotificationAsReadDatasource {
  final RestService _restService;

  const MarkNotificationAsReadDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required MarkNotificationAsReadInputModel markNotificationAsReadInputModel,
  }) async {
    await _restService.appEmployeeNotification().post(
      '/actions/markNotificationAsRead',
      body: {
        'notificationId': markNotificationAsReadInputModel.notificationId,
      },
    );
  }
}
