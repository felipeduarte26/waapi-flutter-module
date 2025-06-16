import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/authenticate_registered_key_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/refresh_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/http_client/policies/expired_token_retry_policy.dart';

class MockRefreshAccessTokenUsecase extends Mock
    implements RefreshAccessTokenUsecase {}

class MockAuthenticateRegisteredKeyUsecase extends Mock
    implements AuthenticateRegisteredKeyUsecase {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

class FakeBaseResponse extends Mock implements BaseResponse {
  @override
  int statusCode;

  FakeBaseResponse({required this.statusCode});
}

void main() {
  late BaseResponse baseResponse;
  late ExpiredTokenRetryPolicy expiredTokenRetryPolicy;
  late RefreshAccessTokenUsecase refreshAccessTokenUsecase;
  late AuthenticateRegisteredKeyUsecase authenticateRegisteredKeyUsecase;
  late GetAccessTokenUsecase getAccessTokenUsecase;

  setUp(() {
    refreshAccessTokenUsecase = MockRefreshAccessTokenUsecase();
    baseResponse = FakeBaseResponse(statusCode: 401);
    authenticateRegisteredKeyUsecase = MockAuthenticateRegisteredKeyUsecase();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();

    when(
      () => refreshAccessTokenUsecase.call(),
    ).thenAnswer((_) async => ());

    expiredTokenRetryPolicy = ExpiredTokenRetryPolicy(
      refreshAccessTokenUsecase: refreshAccessTokenUsecase,
      authenticateRegisteredKeyUsecase: authenticateRegisteredKeyUsecase,
      getAccessTokenUsecase: getAccessTokenUsecase,
    );
  });

  group('ExpiredTokenRetryPolicy', () {
    test(
        'call shouldAttemptRetryOnResponse when status code is '
        '401 in individual mode test', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => null);

      bool valueReturn = await expiredTokenRetryPolicy
          .shouldAttemptRetryOnResponse(baseResponse);

      expect(valueReturn, true);

      verify(() => refreshAccessTokenUsecase.call());

      verify(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      );

      verifyNoMoreInteractions(refreshAccessTokenUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
    });

    test(
        'call shouldAttemptRetryOnResponse whrn status '
        'code is 200 test', () async {
      baseResponse = FakeBaseResponse(statusCode: 200);
      bool valueReturn = await expiredTokenRetryPolicy
          .shouldAttemptRetryOnResponse(baseResponse);

      expect(valueReturn, false);

      verifyZeroInteractions(refreshAccessTokenUsecase);
    });

    test('call maxRetryAttempts test', () async {
      expect(expiredTokenRetryPolicy.maxRetryAttempts, 1);
    });
  });
}
