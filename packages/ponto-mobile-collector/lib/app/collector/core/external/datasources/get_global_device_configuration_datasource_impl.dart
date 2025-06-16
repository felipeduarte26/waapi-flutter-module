import 'dart:convert';
import 'dart:developer';

import '../../domain/entities/global_device_configuration_entity.dart';
import '../../domain/services/environment/ienvironment_service.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/get_global_device_configuration_datasource.dart';
import '../../infra/utils/constants/constants_msg_log.dart';
import '../../infra/utils/constants/constants_path.dart';
import '../mappers/global_device_configuration_entity_mapper.dart';

class GetGlobalDeviceConfigurationDatasourceImpl
    implements GetGlobalDeviceConfigurationDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;
  final GlobalDeviceConfigurationEntityMapper
      _globalDeviceConfigurationEntityMapper;

  GetGlobalDeviceConfigurationDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
    required GlobalDeviceConfigurationEntityMapper
        globalDeviceConfigurationEntityMapper,
  })  : _httpClient = httpClient,
        _environmentService = environmentService,
        _globalDeviceConfigurationEntityMapper =
            globalDeviceConfigurationEntityMapper;

  @override
  Future<GlobalDeviceConfigurationEntity?> call({
    required String identifier,
  }) async {
    final url = Uri(
      scheme: 'https',
      host: _environmentService.environment().path,
      path: ConstantsPath.getDeviceConfigurationQueryPath,
    );

    final response = await _httpClient.post(
      Uri.decodeFull(url.toString()),
      headers: _getRequestHeaders(),
      body: json.encode(
        {
          'identifier': identifier,
        },
      ),
    );

    if (response.statusCode != 200) {
      log(response.body.toString());
      throw Exception(ConstantsMsgLog.getGlobalDeviceConfigurationError);
    }

    final decodedResponse = json.decode(response.body);

    var fromMap =
        _globalDeviceConfigurationEntityMapper.fromMap(decodedResponse);

    return fromMap;
  }

  Map<String, String> _getRequestHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }
}
