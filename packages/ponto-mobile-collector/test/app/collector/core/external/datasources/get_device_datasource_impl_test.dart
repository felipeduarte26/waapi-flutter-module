import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/get_device_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/device_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/get_device_datasource.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/device_entity_mock.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

void main() {
  String identifier = 'identifier';
  late GetDeviceDatasource getDeviceDatasource;
  late IHttpClient httpClient;
  late IEnvironmentService environmentService;
  late String deviceEntityJson;

  setUp(() {
    httpClient = MockHttpClient();
    environmentService = MockEnvironmentService();

    getDeviceDatasource = GetDeviceDatasourceImpl(
      environmentService: environmentService,
      httpClient: httpClient,
    );

    deviceEntityJson =
        json.encode(DeviceMapper().toMap(deviceEntityMock));

    when(
      () => environmentService.environment(),
    ).thenReturn(
      EnvironmentEnum.dev,
    );

    when(() => httpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => HttpResponse(
        body: '{"contents" : [$deviceEntityJson]}',
        statusCode: 200,
      ),
    );

    Map<String, String>? headersMap = {
      'contents': 'any',
    };

    registerFallbackValue(headersMap);
  });

  group('GetDeviceDatasourceImpl', () {
    test('success http request return data test', () async {
      Device? deviceEntity = await getDeviceDatasource.call(identifier);

      expect(deviceEntity, isNotNull);
      expect(deviceEntity!.id, deviceEntityMock.id);
      expect(deviceEntity.identifier, deviceEntityMock.identifier);
      expect(deviceEntity.name, deviceEntityMock.name);
      expect(deviceEntity.model, deviceEntityMock.model);
      expect(deviceEntity.status, deviceEntityMock.status);
    });

    test('success http request return no data test', () async {
      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => const HttpResponse(
          body: '{"contents" : ""}',
          statusCode: 200,
        ),
      );

      Device? deviceEntity = await getDeviceDatasource.call(identifier);

      expect(deviceEntity, isNull);
    });

    test('error http request test', () async {
      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => const HttpResponse(
          body: 'erro msg',
          statusCode: 500,
        ),
      );

      bool erro = false;

      try {
        await getDeviceDatasource.call(identifier);
      } catch (e) {
        erro = true;
      }

      expect(erro, true);
    });
  });
}
