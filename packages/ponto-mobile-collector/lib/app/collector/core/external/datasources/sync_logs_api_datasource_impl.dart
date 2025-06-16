import 'dart:convert';
import 'dart:developer';

import '../../domain/input_model/data_source_response_dto.dart';
import '../../domain/services/environment/ienvironment_service.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/sync_logs_api_datasource.dart';
import '../../infra/utils/constants/constants_path.dart';

class SyncLogsApiDatasourceImpl implements SyncLogsApiDatasource {
  final IEnvironmentService _environmentService;
  final IHttpClient _httpClient;
  SyncLogsApiDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _httpClient = httpClient,
        _environmentService = environmentService;

  @override
  Future<DataSourceResponseDto> call({
    required Map<String, dynamic> jsonLogs,
  }) async {
    try {
      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.mobileLogPath,
      );

      final response = await _httpClient.post(
        Uri.decodeFull(url.toString()),
        headers: _getRequestHeaders(),
        body: jsonEncode(jsonLogs),
      );

      if (response.statusCode == 202) {
        return DataSourceResponseDto(
          success: true,
          message: 'Logs enviados com sucesso',
          statusCode: response.statusCode,
        );
      } else {
        log('Failed to post log: ${response.statusCode} ${response.body}');
        return DataSourceResponseDto(
          success: false,
          message: '${response.statusCode} - Erro ao enviar logs',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return DataSourceResponseDto(
        success: false,
        message: ' Erro inesperado ao enviar logs',
      );
    }
  }

  Map<String, String> _getRequestHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }
}
