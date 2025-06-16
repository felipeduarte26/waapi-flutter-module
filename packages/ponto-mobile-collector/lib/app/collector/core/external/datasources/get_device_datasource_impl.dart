import 'dart:convert';
import 'dart:developer';

import '../../domain/entities/device.dart';
import '../../domain/services/environment/ienvironment_service.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/get_device_datasource.dart';
import '../../infra/utils/constants/constants_msg_log.dart';
import '../../infra/utils/constants/constants_path.dart';
import '../mappers/device_mapper.dart';

class GetDeviceDatasourceImpl implements GetDeviceDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  GetDeviceDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _httpClient = httpClient,
        _environmentService = environmentService;

  @override
  Future<Device?> call(String identifier) async {
    final url = Uri(
      scheme: 'https',
      host: _environmentService.environment().path,
      path: ConstantsPath.getDeviceEntityPath,
      queryParameters: {
        'filter': 'imei eq \'$identifier\'',
      },
    );

    final response = await _httpClient.get(
      Uri.decodeFull(url.toString()),
      headers: _getRequestHeaders(),
    );

    if (response.statusCode != 200) {
      log(response.body.toString());
      throw Exception(ConstantsMsgLog.getDeviceEntityError);
    }

    final decodedResponse = json.decode(response.body);

    if (decodedResponse['contents'] == null ||
        decodedResponse['contents'].isEmpty) {
      return null;
    }

    var fromMap = DeviceMapper().fromMap(decodedResponse['contents'][0]);

    return fromMap;
  }

  Map<String, String> _getRequestHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }
}
