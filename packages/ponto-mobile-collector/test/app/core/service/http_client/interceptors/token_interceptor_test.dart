import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/http_client/interceptors/token_interceptor.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

class MockClearStoredDataUsecase extends Mock
    implements ClearStoredDataUsecase {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockPlatformService extends Mock implements IPlatformService {}

class FakeBaseRequest extends Fake implements BaseRequest {
  @override
  Map<String, String> headers;

  @override
  Uri url;

  FakeBaseRequest({required this.headers, required this.url});
}

class FakeBaseResponse extends Fake implements BaseResponse {
  @override
  int statusCode;

  @override
  BaseRequest request;

  @override
  Map<String, String> headers;

  @override
  String? reasonPhrase;

  FakeBaseResponse({
    required this.statusCode,
    required this.request,
    required this.headers,
    required this.reasonPhrase,
  });
}

void main() {
  late BaseRequest baserequest;
  late BaseResponse baseResponse;
  const String newAccessToken = 'newAccessToken';
  late TokenInterceptor tokenInterceptor;
  late ClearStoredDataUsecase clearStoredDataUsecase;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  late NavigatorService navigatorService;
  late IPlatformService platformService;
  const Map<String, String> headers = {};

  setUp(() {
    baserequest = FakeBaseRequest(headers: {}, url: Uri(path: ''));
    baseResponse = FakeBaseResponse(
      statusCode: 401,
      request: baserequest,
      headers: headers,
      reasonPhrase: '',
    );

    clearStoredDataUsecase = MockClearStoredDataUsecase();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();
    navigatorService = MockNavigatorService();
    platformService = MockPlatformService();

    when(
      () => getAccessTokenUsecase.call(),
    ).thenAnswer(
      (_) async => newAccessToken,
    );

    when(() => platformService.getPackageinfo()).thenAnswer(
      (_) async => PackageInfo(
        appName: 'collector',
        packageName: 'br.com.senior',
        version: '3.0.0',
        buildNumber: '932841983',
      ),
    );

    tokenInterceptor = TokenInterceptor(
      clearStoredDataUsecase: clearStoredDataUsecase,
      getAccessTokenUsecase: getAccessTokenUsecase,
      navigatorService: navigatorService,
      platformService: platformService,
    );
  });

  group('TokenInterceptor', () {
    test('interceptRequest test header has Authorization ', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer(
        (_) async => newAccessToken,
      );

      String oldAccessToken = 'Bearer oldAccessToken';
      baserequest = FakeBaseRequest(
        headers: {
          'Authorization': oldAccessToken,
          'Token-Type': 'key',
        },
        url: Uri(path: ''),
      );

      BaseRequest baseRequest =
          await tokenInterceptor.interceptRequest(request: baserequest);

      expect(baseRequest.headers['Authorization'], 'Bearer $newAccessToken');
      expect(baseRequest.headers['User-Agent'], ' Collector/collector/3.0.0');
      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.key));
      verifyNoMoreInteractions(getAccessTokenUsecase);
    });

    test('interceptRequest test', () async {
      BaseRequest baseRequest =
          await tokenInterceptor.interceptRequest(request: baserequest);

      expect(baseRequest.headers['Authorization'], 'Bearer $newAccessToken');
      expect(baseRequest.headers['User-Agent'], ' Collector/collector/3.0.0');
      verify(() => getAccessTokenUsecase.call()).called(1);
      verifyNoMoreInteractions(getAccessTokenUsecase);
    });

    test(
        'interceptResponse when status code is 401 '
        'in individual mode test', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer(
        (_) async => null,
      );

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.user),
      ).thenAnswer(
        (_) async => newAccessToken,
      );

      when(
        () => clearStoredDataUsecase.call(const UserName()),
      ).thenAnswer(
        (_) async => (),
      );

      when(
        () => navigatorService.navigate(
          route: CollectorModuleService.loginPath,
        ),
      ).thenReturn(null);

      await tokenInterceptor.interceptResponse(response: baseResponse);

      verify(
        () => clearStoredDataUsecase.call(const UserName()),
      );

      verify(
        () => navigatorService.navigate(
          route: CollectorModuleService.loginPath,
        ),
      );

      verify(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      );

      verify(
        () => getAccessTokenUsecase.call(tokenType: TokenType.user),
      );

      verifyNoMoreInteractions(navigatorService);
      verifyNoMoreInteractions(clearStoredDataUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
    });

    test(
        'interceptResponse when status code is 401 '
        'in Multiple mode test', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer(
        (_) async => newAccessToken,
      );

      when(
        () => navigatorService.navigate(
          route: ApplicationKeyRoutes.failedAuthenticationKeyFull,
        ),
      ).thenReturn(null);

      await tokenInterceptor.interceptResponse(response: baseResponse);

      verify(
        () => navigatorService.navigate(
          route: ApplicationKeyRoutes.failedAuthenticationKeyFull,
        ),
      );

      verify(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      );

      verifyNoMoreInteractions(navigatorService);
      verifyNoMoreInteractions(getAccessTokenUsecase);
    });

    test('interceptResponse when status code is 200 test', () async {
      baseResponse = FakeBaseResponse(
        statusCode: 200,
        request: baserequest,
        headers: headers,
        reasonPhrase: '',
      );

      BaseResponse returnResponse = await tokenInterceptor.interceptResponse(
        response: baseResponse,
      );

      expect(baseResponse, returnResponse);
      verifyZeroInteractions(navigatorService);
      verifyZeroInteractions(clearStoredDataUsecase);
    });

    test('call shouldInterceptRequest test', () async {
      expect(await tokenInterceptor.shouldInterceptRequest(), true);
    });

    test('call shouldInterceptResponse test', () async {
      expect(await tokenInterceptor.shouldInterceptResponse(), true);
    });
  });
}
