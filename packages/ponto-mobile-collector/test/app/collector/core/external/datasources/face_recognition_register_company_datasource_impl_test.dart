import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/face_recognition_register_company_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/face_recognition_register_company_datasource.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockIEnvironmentService extends Mock implements IEnvironmentService {}

class MockIHttpClient extends Mock implements IHttpClient {}

class MockISharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

void main() {
  String tCompanyId = 'c03ca9d3-669a-4aab-9fde-096058541555';
  late FaceRecognitionRegisterCompanyDatasource
      faceRecognitionRegisterCompanyDatasource;
  late IEnvironmentService environmentService;
  late IHttpClient httpClient;
  late ISharedPreferencesService sharedPreferencesService;
  const HttpResponse tHttpResponseSuccessRequest = HttpResponse(
    body: ' ',
    statusCode: 200,
  );

  const HttpResponse tHttpResponseBadRequest = HttpResponse(
    body: ' ',
    statusCode: 500,
  );

  setUp(() {
    environmentService = MockIEnvironmentService();
    httpClient = MockIHttpClient();
    sharedPreferencesService = MockISharedPreferencesService();

    faceRecognitionRegisterCompanyDatasource =
        FaceRecognitionRegisterCompanyDatasourceImpl(
      environmentService: environmentService,
      httpClient: httpClient,
      sharedPreferencesService: sharedPreferencesService,
    );

    when(
      () => sharedPreferencesService.getRegisterCompany(
        companyId: tCompanyId,
      ),
    ).thenAnswer(
      (_) async => false,
    );
  });

  Map<String, String> getRequestHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  group('FaceRecognitionRegisterCompanyDatasourceImpl', () {
    test('register company successfully test', () async {
      when(
        () => sharedPreferencesService.setRegisterCompany(
          companyId: tCompanyId,
          value: true,
        ),
      ).thenAnswer(
        (_) async => false,
      );

      when(
        () => environmentService.environment(),
      ).thenReturn(
        EnvironmentEnum.dev,
      );

      when(
        () => httpClient.post(
          any(),
          headers: getRequestHeaders(),
          body: '{}',
        ),
      ).thenAnswer((_) async => tHttpResponseSuccessRequest);

      bool responseValue = await faceRecognitionRegisterCompanyDatasource.call(
        companyId: tCompanyId,
      );

      expect(responseValue, true);

      verify(
        () => sharedPreferencesService.getRegisterCompany(
          companyId: tCompanyId,
        ),
      ).called(1);

      verify(
        () => sharedPreferencesService.setRegisterCompany(
          companyId: tCompanyId,
          value: true,
        ),
      ).called(1);

      verify(() => environmentService.environment()).called(1);

      verifyNoMoreInteractions(sharedPreferencesService);
      verifyNoMoreInteractions(environmentService);
    });

    test('register company bad request test', () async {
      when(
        () => environmentService.environment(),
      ).thenReturn(
        EnvironmentEnum.dev,
      );

      when(
        () => httpClient.post(
          any(),
          headers: getRequestHeaders(),
          body: '{}',
        ),
      ).thenAnswer((_) async => tHttpResponseBadRequest);

      bool responseValue = await faceRecognitionRegisterCompanyDatasource.call(
        companyId: tCompanyId,
      );

      expect(responseValue, false);

      verify(
        () => sharedPreferencesService.getRegisterCompany(
          companyId: tCompanyId,
        ),
      ).called(1);

      verify(() => environmentService.environment()).called(1);

      verifyNoMoreInteractions(sharedPreferencesService);
      verifyNoMoreInteractions(environmentService);
    });

    test('register company error test', () async {
      when(
        () => sharedPreferencesService.getRegisterCompany(
          companyId: tCompanyId,
        ),
      ).thenThrow(Exception('Unexpected Exception'));

      bool responseValue = await faceRecognitionRegisterCompanyDatasource.call(
        companyId: tCompanyId,
      );

      expect(responseValue, false);

      verify(
        () => sharedPreferencesService.getRegisterCompany(
          companyId: tCompanyId,
        ),
      ).called(1);

      verifyNoMoreInteractions(sharedPreferencesService);
      verifyNoMoreInteractions(environmentService);
    });
  });
}
