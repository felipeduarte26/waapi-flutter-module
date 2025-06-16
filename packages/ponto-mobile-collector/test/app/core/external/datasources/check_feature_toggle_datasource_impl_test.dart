import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/abstractions/http_response.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/http_client/i_http_client.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/check_feature_toggle_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/check_feature_toggle_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/constants/constants_path.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/feature_toggle_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockHttpClient extends Mock implements IHttpClient {}

class FakeHttpResponse extends Fake implements HttpResponse {
  @override
  String body;

  @override
  int statusCode;

  FakeHttpResponse({required this.body, required this.statusCode});
}

void main() {
  const TokenType tokenType = TokenType.key;
  String tUrl = Uri.https(
    EnvironmentEnum.dev.path,
    ConstantsPath.hasFeatureEnabledQuery,
  ).toString();
  String tBody = '''
      {
          "featureName": "${FeatureToggleEnum.faceRecognition.featureName}"
      }
      ''';
  Map<String, String>? tHeaders = {
    'Token-Type': tokenType.value,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  HttpResponse httpResponse = FakeHttpResponse(
    body: '{"hasFeature" : true}',
    statusCode: 200,
  );

  HttpResponse httpResponseError = FakeHttpResponse(
    body: '',
    statusCode: 501,
  );
  late IEnvironmentService environmentService;
  late IHttpClient httpClient;
  late CheckFeatureToggleDatasource checkFeatureToggleDatasource;

  setUp(() {
    environmentService = MockEnvironmentService();
    httpClient = MockHttpClient();

    when(
      () => environmentService.environment(),
    ).thenReturn(EnvironmentEnum.dev);

    checkFeatureToggleDatasource = CheckFeatureToggleDatasourceImpl(
      httpClient: httpClient,
      environmentService: environmentService,
    );
  });

  group('CheckFeatureToggleDatasourceImpl', () {
    test('It should return true when http was successful test', () async {
      when(
        () => httpClient.post(
          tUrl,
          body: tBody,
          headers: tHeaders,
        ),
      ).thenAnswer((_) async => httpResponse);

      bool featureResponse = await checkFeatureToggleDatasource.call(
        featureToggle: FeatureToggleEnum.faceRecognition,
        tokenType: tokenType,
      );

      expect(featureResponse, true);

      verify(() => environmentService.environment()).called(1);

      verify(
        () => httpClient.post(
          tUrl,
          body: tBody,
          headers: tHeaders,
        ),
      ).called(1);

      verifyNoMoreInteractions(environmentService);
      verifyNoMoreInteractions(httpClient);
    });

    test('Should return false when http failed test', () async {
      when(
        () => environmentService.environment(),
      ).thenReturn(EnvironmentEnum.dev);

      when(
        () => httpClient.post(
          tUrl,
          body: tBody,
          headers: tHeaders,
        ),
      ).thenAnswer((_) async => httpResponseError);

      bool featureResponse = await checkFeatureToggleDatasource.call(
        featureToggle: FeatureToggleEnum.faceRecognition,
        tokenType: tokenType,
      );

      expect(featureResponse, false);

      verify(() => environmentService.environment()).called(1);

      verify(
        () => httpClient.post(
          tUrl,
          body: tBody,
          headers: tHeaders,
        ),
      ).called(1);

      verifyNoMoreInteractions(environmentService);
      verifyNoMoreInteractions(httpClient);
    });
  });
}
