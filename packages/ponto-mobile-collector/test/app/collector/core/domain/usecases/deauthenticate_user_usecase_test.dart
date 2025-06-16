import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/session/isession_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/deauthenticate_user_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_token_usecase.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/token_mock.dart';

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

class MockSessionService extends Mock implements ISessionService {}

void main() {
  late DeauthenticateUserUsecase deauthenticateUserUsecase;
  late AuthenticationBloc authenticationBloc;
  late GetTokenUsecase getTokenUsecase;
  late ISessionService sessionService;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    getTokenUsecase = MockGetTokenUsecase();
    sessionService = MockSessionService();

    when(() => getTokenUsecase.call(tokenType: TokenType.user))
        .thenAnswer((_) async => tokenMock);

    when(() => sessionService.clean())
        .thenAnswer((_) async => Future.value());

    deauthenticateUserUsecase = DeauthenticateUserUsecaseImpl(
      authenticationBloc: authenticationBloc,
      getTokenUsecase: getTokenUsecase,
      sessionService: sessionService,
    );
  });

  group('DeauthenticateUserUsecase', () {
    test('offline logoff test', () async {
      await deauthenticateUserUsecase.call();

      verify(() => getTokenUsecase.call(tokenType: TokenType.user));

      verifyNoMoreInteractions(getTokenUsecase);
    });
  });
}
