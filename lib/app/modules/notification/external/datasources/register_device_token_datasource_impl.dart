import 'package:platform/platform.dart';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/register_device_token_datasource.dart';

class RegisterDeviceTokenDatasourceImpl implements RegisterDeviceTokenDatasource {
  final RestService _restService;
  final LocalPlatform _localPlatform;

  const RegisterDeviceTokenDatasourceImpl({
    required RestService restService,
    required LocalPlatform localPlatform,
  })  : _restService = restService,
        _localPlatform = localPlatform;

  @override
  Future<void> call({
    required String deviceToken,
  }) async {
    await _restService.appEmployeeNotification().post(
      '/actions/registerDeviceToken',
      body: {
        'deviceToken': deviceToken,
        'devicePlatform': _localPlatform.isAndroid ? 'ANDROID' : 'IOS',
      },
    );
  }
}
