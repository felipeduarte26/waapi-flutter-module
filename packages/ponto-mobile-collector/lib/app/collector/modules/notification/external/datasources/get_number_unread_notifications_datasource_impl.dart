import 'dart:convert';

import '../../../../core/domain/services/environment/ienvironment_service.dart';
import '../../../../core/domain/services/http_client/i_http_client.dart';
import '../../../../core/exception/get_number_unread_notification_datasource_exception.dart';
import '../../../../core/infra/utils/constants/constants_path.dart';
import '../../domain/entities/has_unread_push_message_entity.dart';
import '../../infra/adapters/get_number_unread_notifications_adapter.dart';
import '../../infra/datasources/get_number_unread_notifications_datasource.dart';

class GetNumberUnreadNotificationsDatasourceImpl
    implements GetNumberUnreadNotificationsDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  const GetNumberUnreadNotificationsDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _environmentService = environmentService,
        _httpClient = httpClient;

  @override
  Future<HasUnreadPushMessageEntity> call({
    required String employeeId,
  }) async {
    HasUnreadPushMessageEntity resultEntity =
        HasUnreadPushMessageEntity(hasUnreadPushMessage: false, number: 0);

    try {
      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.hasUnreadPushMessageQueryPath,
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
        resultEntity = GetNumberUnreadNotificationsAdapter.fromJSON(
          result.body,
        );
      }
    } catch (exception) {
      throw GetNumberUnreadNotificationsException(exception: exception);
    }

    return resultEntity;
  }
}
