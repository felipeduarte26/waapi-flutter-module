import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/status_face_employee.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/face_recognition_register_face_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/face_recognition_register_face_datasource.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/response_gryfo_face_employee_output_mock.dart';

class MockIEnvironmentService extends Mock implements IEnvironmentService {}

class MockIHttpClient extends Mock implements IHttpClient {}

void main() {
  String tImageBase64 = 'tImageBase64';
  String tEmployeeIdSelected = 'ffcc10e8-5e43-4f3d-90c8-aa271272d065';
  late FaceRecognitionRegisterFaceDatasource
      faceRecognitionRegisterFaceDatasource;
  late IEnvironmentService environmentService;
  late IHttpClient httpClient;

  setUp(() {
    environmentService = MockIEnvironmentService();
    httpClient = MockIHttpClient();

    faceRecognitionRegisterFaceDatasource =
        FaceRecognitionRegisterFaceDatasourceImpl(
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

  group('FaceRecognitionRegisterFaceDatasourceImpl', () {
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
          body: responseGryfoFaceEmployeeOutputMock.toJson(),
          statusCode: 200,
        ),
      );

      StatusFaceEmployee? responseValue =
          await faceRecognitionRegisterFaceDatasource.call(
        imageBase64: tImageBase64,
        employeeIdSelected: tEmployeeIdSelected,
      );

      expect(responseValue!.success, true);

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
        (_) async => HttpResponse(
          body: responseGryfoFaceEmployeeOutputMock.toJson(),
          statusCode: 500,
        ),
      );

      StatusFaceEmployee? responseValue =
          await faceRecognitionRegisterFaceDatasource.call(
        imageBase64: tImageBase64,
        employeeIdSelected: tEmployeeIdSelected,
      );

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

      StatusFaceEmployee? responseValue =
          await faceRecognitionRegisterFaceDatasource.call(
        imageBase64: tImageBase64,
        employeeIdSelected: tEmployeeIdSelected,
      );

      expect(responseValue, null);

      verify(() => environmentService.environment()).called(1);

      verifyNoMoreInteractions(environmentService);
      verifyNoMoreInteractions(httpClient);
    });
  });
}
