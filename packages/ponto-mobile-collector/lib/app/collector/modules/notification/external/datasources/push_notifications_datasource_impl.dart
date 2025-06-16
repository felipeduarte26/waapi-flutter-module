import 'dart:convert';

import '../../../../core/domain/services/environment/ienvironment_service.dart';
import '../../../../core/domain/services/http_client/i_http_client.dart';
import '../../../../core/exception/push_notification_datasource_exception.dart';
import '../../../../core/infra/utils/constants/constants_path.dart';
import '../../domain/entities/push_notification_dto.dart';
import '../../infra/adapters/push_notification_adapter.dart';
import '../../infra/datasources/push_notifications_datasource.dart';

class GetPushNotificationsDatasourceImpl
    implements GetPushNotificationsDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  const GetPushNotificationsDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _environmentService = environmentService,
        _httpClient = httpClient;

  @override
  Future<PushNotificationDto> call({
    required String employeeId,
  }) async {
    PushNotificationDto messageResult = PushNotificationDto(messages: []);

    try {
      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.getPushNotificationsQueryPath,
      );

      final result = await _httpClient.post(
        url.toString(),
        body: json.encode({
          'employeeId': employeeId,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (result.statusCode == 200) {
        messageResult = PushNotificationAdapter.fromJSON(
          result.body,
        );
      }
    } catch (exception) {
      throw PushNotificationException(exception: exception);
    }

    return messageResult;
  }
}
