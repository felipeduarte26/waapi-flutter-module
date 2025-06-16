import 'dart:convert';
import 'dart:developer';

import '../../domain/entities/platform_menu_entity.dart';
import '../../domain/services/environment/ienvironment_service.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/platform_menu_app_datasource.dart';
import '../../infra/utils/constants/constants_msg_log.dart';
import '../../infra/utils/constants/constants_path.dart';
import '../mappers/platform_menu_model_mapper.dart';

class PlatformMenuAppDatasourceImpl implements PlatformMenuAppDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  PlatformMenuAppDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _httpClient = httpClient,
        _environmentService = environmentService;

  @override
  Future<List<PlatformMenuEntity>?> call() async {
    try {
      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.getMenuAppQueryPath,
      );

      final response = await _httpClient.post(
        url.toString(),
        headers: await _getRequestHeaders(),
        body: json.encode({}),
      );

      if (response.statusCode != 200) {
        log(response.body.toString());
        log(ConstantsMsgLog.getTokenFailure);
        return null;
      }

      log(ConstantsMsgLog.gotTokenSuccessfully);

      final decodedResponse = json.decode(response.body);

      return PlatformMenuModelMapper().fromList(list: decodedResponse['menuPlatformIntegrations'] ?? []);
    } catch (exception) {
      log(exception.toString());
      rethrow;
    }
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }
}
