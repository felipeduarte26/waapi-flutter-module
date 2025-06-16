import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_configuration_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/environment/ienvironment_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/configuration_global_query_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/configuration_global_query_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockHttpResponse extends Mock implements HttpResponse {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockEnvironmentService mockEnvironmentService;
  late ConfigurationGlobalQueryDatasource datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockEnvironmentService = MockEnvironmentService();
    datasource = ConfigurationGlobalQueryDatasourceImpl(
      httpClient: mockHttpClient,
      environmentService: mockEnvironmentService,
    );

    when(() => mockEnvironmentService.environment())
        .thenReturn(EnvironmentEnum.dev);
  });

  group('ConfigurationGlobalQueryDatasourceImpl', () {
    test('call method returns GlobalConfigurationEntity test', () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => const HttpResponse(
          body: '{"configuration": {"id" : "123"}}',
          statusCode: 200,
        ),
      );

      Map<String, String>? headersMap = {
        'configuration': '{id : config_id}',
      };

      registerFallbackValue(headersMap);

      final result = await datasource.call();

      expect(result, isA<GlobalConfigurationEntity>());
      expect(result.id, '123');
    });

    test('call method throws Exception when status code is not 200 test',
        () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => const HttpResponse(
          body: '{"id": "123"}',
          statusCode: 400,
        ),
      );

      expect(() async => await datasource.call(), throwsA(isA<Exception>()));
    });
  });
}
