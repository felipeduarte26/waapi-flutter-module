import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/clear_device_token_datasource.dart';

class ClearDeviceTokenDatasourceImpl implements ClearDeviceTokenDatasource {
  final RestService _restService;

  const ClearDeviceTokenDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call() async {
    await _restService.appEmployeeNotification().post(
      '/actions/clearDeviceToken',
      body: {},
    );
  }
}
