import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/face_recognition_token_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/face_recognition_token_datasource.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockIEnvironmentService extends Mock implements IEnvironmentService {}

class MockIHttpClient extends Mock implements IHttpClient {}

void main() {
  late FaceRecognitionTokenDatasource faceRecognitionTokenDatasource;
  late IEnvironmentService environmentService;
  late IHttpClient httpClient;

  setUp(() {
    environmentService = MockIEnvironmentService();
    httpClient = MockIHttpClient();

    faceRecognitionTokenDatasource = FaceRecognitionTokenDatasourceImpl(
      environmentService: environmentService,
      httpClient: httpClient,
    );
  });

  Map<String, String> getRequestHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  group('FaceRecognitionTokenDatasourceImpl', () {
    test('register face successfully test', () async {
      when(
        () => environmentService.environment(),
      ).thenReturn(
        EnvironmentEnum.dev,
      );

      when(
        () => httpClient.post(
          any(),
          headers: getRequestHeaders(),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => HttpResponse(
          body: json.encode({'android_token': 'SDK_TOKEN'}),
          statusCode: 200,
        ),
      );

      String? responseValue = await faceRecognitionTokenDatasource.call();

      expect(responseValue, 'SDK_TOKEN');

      verify(() => environmentService.environment()).called(1);

      verify(
        () => httpClient.post(
          any(),
          headers: getRequestHeaders(),
          body: any(named: 'body'),
        ),
      ).called(1);

      verifyNoMoreInteractions(environmentService);
      verifyNoMoreInteractions(httpClient);
    });

    test('register face bad request test', () async {
      when(
        () => environmentService.environment(),
      ).thenReturn(
        EnvironmentEnum.dev,
      );

      when(
        () => httpClient.post(
          any(),
          headers: getRequestHeaders(),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => const HttpResponse(
          body: '{}',
          statusCode: 500,
        ),
      );

      String? responseValue = await faceRecognitionTokenDatasource.call();

      expect(responseValue, null);

      verify(() => environmentService.environment()).called(1);

      verify(
        () => httpClient.post(
          any(),
          headers: getRequestHeaders(),
          body: any(named: 'body'),
        ),
      ).called(1);

      verifyNoMoreInteractions(environmentService);
      verifyNoMoreInteractions(httpClient);
    });

    test('register face error test', () async {
      when(
        () => environmentService.environment(),
      ).thenThrow(
        Exception('Unexpected Exception'),
      );

      Future<String?> responseValue = faceRecognitionTokenDatasource.call();

      expect(
        () => responseValue,
        throwsA(
          isA<Exception>(),
        ),
      );

      verify(() => environmentService.environment()).called(1);

      verifyNoMoreInteractions(environmentService);
      verifyNoMoreInteractions(httpClient);
    });
  });
}
