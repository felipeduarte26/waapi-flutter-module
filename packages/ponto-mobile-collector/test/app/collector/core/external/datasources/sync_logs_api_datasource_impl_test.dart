import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/data_source_response_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/environment/ienvironment_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/sync_logs_api_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/sync_logs_api_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/constants/constants_path.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

void main() {
  late IHttpClient httpClient;
  late IEnvironmentService environmentService;
  late SyncLogsApiDatasource logsDatasource;

  setUp(() {
    httpClient = MockHttpClient();
    environmentService = MockEnvironmentService();

    logsDatasource = SyncLogsApiDatasourceImpl(
      httpClient: httpClient,
      environmentService: environmentService,
    );

    when(
      () => environmentService.environment(),
    ).thenReturn(EnvironmentEnum.test);
    var httpResponse = HttpResponse(
      body: getBody(),
      statusCode: 200,
    );
    when(
      () => httpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => httpResponse);
  });

  group('LogsDatasourceImpl', () {
    test('should return true when log is posted successfully', () async {
      final jsonLogs = {'key': 'value'};
      final url =
          Uri.https(EnvironmentEnum.test.path, ConstantsPath.mobileLogPath);
      final DataSourceResponseDto response =
          DataSourceResponseDto(message: 'success', success: true);

      when(
        () => httpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => const HttpResponse(body: '', statusCode: 202));

      final result = await logsDatasource.call(jsonLogs: jsonLogs);
      expect(result.success, response.success);
      verify(
        () => httpClient.post(
          Uri.decodeFull(url.toString()),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(jsonLogs),
        ),
      ).called(1);
    });

    test('should return true when log is posted falied', () async {
      final jsonLogs = {'key': 'value'};
      final url =
          Uri.https(EnvironmentEnum.test.path, ConstantsPath.mobileLogPath);
      final DataSourceResponseDto response =
          DataSourceResponseDto(message: 'falied', success: false);

      when(
        () => httpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => const HttpResponse(body: '', statusCode: 400));

      final result = await logsDatasource.call(jsonLogs: jsonLogs);
      expect(result.success, response.success);
      verify(
        () => httpClient.post(
          Uri.decodeFull(url.toString()),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(jsonLogs),
        ),
      ).called(1);
    });

    test(
        'returns DataSourceResponseDto with error message when an exception is thrown',
        () async {
      final jsonLogs = {'key': 'value'};

      when(() => logsDatasource.call(jsonLogs: jsonLogs))
          .thenThrow(Exception('Unexpected error'));

      final response = await logsDatasource.call(jsonLogs: jsonLogs);

      expect(response.success, false);
      expect(response.message, ' Erro inesperado ao enviar logs');
    });
  });
}

String getBody() {
  return ' {"menuPlatformIntegrations": [  {  "id": "2c95dede-2eb1-4cf9-87f6-4925d54fd61e",  "name": "Acerto de ponto",  "resource": "res://senior.com.br/rh/ponto/gestaoponto/colaborador",  "permission": "Visualizar",  "description": "Acerto de ponto do colaborador",  "url": "https://www.google.com.br/user/redirect?activeview=employee&portal=g7&showMenu=N",  "backendUrl": "https://www.google.com.br/gestaoponto-backend/api/",  "active": true, "flutterIcon": "0xe19d"  },  {  "id": "d3ecffd8-981b-4890-a58f-69b5c9ea13d7",  "name": "Jornada de hoje",  "resource": "res://senior.com.br/rh/ponto/gestaoponto/sempreemponto",  "permission": "Visualizar",  "description": "Jornada de hoje",  "url": "https://www.google.com.br/user/register/today-working?portal=g7&showMenu=N",  "backendUrl": "https://www.google.com.br/gestaoponto-backend/api/",  "active": true, "flutterIcon": "0xe19d"  },  {  "id": "83242df0-1856-46f7-b70e-d7457070c80b",  "name": "Acertos da minha equipe",  "resource": "res://senior.com.br/rh/ponto/gestaoponto/gestor",  "permission": "Visualizar",  "description": "Acertos da minha equipe",  "url": "https://www.google.com.br/issues/redirect?activeview=manager&portal=g7&showMenu=N",  "backendUrl": "https://www.google.com.br/gestaoponto-backend/api/",  "active": true, "flutterIcon": "0xe19d"  }  ]}';
}
