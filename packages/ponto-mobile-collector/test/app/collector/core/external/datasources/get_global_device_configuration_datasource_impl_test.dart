import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_device_configuration_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/get_global_device_configuration_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/global_device_configuration_entity_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/get_global_device_configuration_datasource.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/global_device_configuration_entity_mock.dart';

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockHttpClient extends Mock implements IHttpClient {}

class MockGlobalDeviceConfigurationEntityMapper extends Mock
    implements GlobalDeviceConfigurationEntityMapper {}

class FakeHttpResponse extends Mock implements HttpResponse {}

void main() {
  late GetGlobalDeviceConfigurationDatasource
      getGlobalDeviceConfigurationDatasource;
  late IEnvironmentService environmentService;
  late IHttpClient httpClient;
  late GlobalDeviceConfigurationEntityMapper
      globalDeviceConfigurationEntityMapper;
  const dynamic myvalue = 'dynamic';
  Map<String, String>? map = {};
  HttpResponse httpResponse;

  setUp(() {
    environmentService = MockEnvironmentService();
    httpClient = MockHttpClient();
    globalDeviceConfigurationEntityMapper =
        MockGlobalDeviceConfigurationEntityMapper();
    httpResponse = const HttpResponse(
      body: '{}',
      statusCode: 200,
    );

    registerFallbackValue(map);
    registerFallbackValue(myvalue);

    when(
      () => environmentService.environment(),
    ).thenReturn(EnvironmentEnum.dev);

    when(
      () => httpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => httpResponse);

    when(
      () => globalDeviceConfigurationEntityMapper.fromMap(map),
    ).thenReturn(globalDeviceConfigurationEntityMock);

    getGlobalDeviceConfigurationDatasource =
        GetGlobalDeviceConfigurationDatasourceImpl(
      environmentService: environmentService,
      httpClient: httpClient,
      globalDeviceConfigurationEntityMapper:
          globalDeviceConfigurationEntityMapper,
    );
  });

  test('request config successfully test', () async {
    GlobalDeviceConfigurationEntity? globalDeviceConfigurationEntity =
        await getGlobalDeviceConfigurationDatasource.call(
      identifier: 'identifier',
    );

    verify(() => environmentService.environment());

    verify(
      () => httpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    );

    verify(() => globalDeviceConfigurationEntityMapper.fromMap(map));

    expect(
      globalDeviceConfigurationEntity,
      globalDeviceConfigurationEntityMock,
    );

    verifyNoMoreInteractions(globalDeviceConfigurationEntityMapper);
    verifyNoMoreInteractions(environmentService);
    verifyNoMoreInteractions(httpClient);
  });
}
