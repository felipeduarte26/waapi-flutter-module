import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/authenticate_registered_key_usecase.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

class MockAuthenticateKeyUsecase extends Mock
    implements AuthenticateKeyUsecase {}

class FakeAuthenticationResponse extends Fake
    implements AuthenticationResponse {}

void main() {
  late AuthenticateRegisteredKeyUsecase authenticateRegisteredKeyUsecase;
  late AuthenticateKeyUsecase authenticateKeyUsecase;

  setUp(() {
    authenticateKeyUsecase = MockAuthenticateKeyUsecase();
    authenticateRegisteredKeyUsecase = AuthenticateRegisteredKeyUsecaseImpl(
      authenticateKeyUsecase: authenticateKeyUsecase,
    );
  });
  group('AuthenticateRegisteredKeyUsecase', () {
    test('call success test', () async {
      when(
        () => authenticateKeyUsecase.call(),
      ).thenAnswer((_) async => FakeAuthenticationResponse());
      bool result = await authenticateRegisteredKeyUsecase.call();
      expect(result, true);
    });
  });
}
