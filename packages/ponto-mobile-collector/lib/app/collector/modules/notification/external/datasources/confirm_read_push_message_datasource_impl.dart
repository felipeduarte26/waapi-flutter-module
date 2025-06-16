import 'dart:convert';

import '../../../../core/domain/services/environment/ienvironment_service.dart';
import '../../../../core/domain/services/http_client/i_http_client.dart';
import '../../../../core/exception/confirm_read_push_message_datasource_exception.dart';
import '../../../../core/infra/utils/constants/constants_path.dart';
import '../../domain/entities/confirm_read_push_message_entity.dart';
import '../../infra/adapters/confirm_read_push_message_adapter.dart';
import '../../infra/datasources/confirm_read_push_message_datasource.dart';

class ConfirmReadPushMessageDataSourceImpl
    implements ConfirmReadPushMessageDataSource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  const ConfirmReadPushMessageDataSourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _environmentService = environmentService,
        _httpClient = httpClient;

  @override
  Future<ConfirmReadPushMessageEntity> call({
    required String messageId,
  }) async {
    ConfirmReadPushMessageEntity resultEntity =
        ConfirmReadPushMessageEntity(confirmed: false);

    try {
      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.confirmReadPushMessageActionPath,
      );

      final result = await _httpClient.post(
        url.toString(),
        body: json.encode({
          'messageId': messageId,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (result.statusCode == 200) {
        return ConfirmReadPushMessageAdapter.fromJSON(
          result.body,
        );
      }
    } catch (exception) {
      throw ConfirmReadPushMessageDataSourceException(exception: exception);
    }
    return resultEntity;
  }
}
