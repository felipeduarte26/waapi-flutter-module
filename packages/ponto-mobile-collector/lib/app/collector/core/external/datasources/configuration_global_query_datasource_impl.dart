import 'dart:convert';
import 'dart:developer';

import '../../domain/entities/global_configuration_entity.dart';
import '../../domain/services/environment/ienvironment_service.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/configuration_global_query_datasource.dart';
import '../../infra/utils/constants/constants_msg_log.dart';
import '../../infra/utils/constants/constants_path.dart';
import '../mappers/global_configuration_mapper.dart';

class ConfigurationGlobalQueryDatasourceImpl
    extends ConfigurationGlobalQueryDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  ConfigurationGlobalQueryDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _httpClient = httpClient,
        _environmentService = environmentService;

  @override
  Future<GlobalConfigurationEntity> call() async {
    final url = Uri.https(
      _environmentService.environment().path,
      ConstantsPath.configurationsGlobalQueryPath,
    );

    final response = await _httpClient.get(
      url.toString(),
      headers: await _getRequestHeaders(),
    );

    if (response.statusCode != 200) {
      log(response.body.toString());
      throw Exception(ConstantsMsgLog.configurationGlobalQueryError);
    }

    final decodedResponse = json.decode(response.body);

    return GlobalConfigurationEntityMapper()
        .fromMap(map: decodedResponse['configuration']);
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }
}
