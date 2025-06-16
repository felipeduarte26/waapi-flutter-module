import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_acess_token_username_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_token_usecase.dart';

import '../../../../../mocks/token_mock.dart';

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

void main() {
  late GetAccessTokenUsernameUsecase getAccessTokenUsernameUsecase;
  late GetTokenUsecase getTokenUsecase;

  setUp(() {
    getTokenUsecase = MockGetTokenUsecase();

    when(
      () => getTokenUsecase.call(tokenType: TokenType.user),
    ).thenAnswer((_) async => tokenMock);

    getAccessTokenUsernameUsecase = GetAccessTokenUsernameUsecaseImpl(
      getTokenUsecase: getTokenUsecase,
    );
  });

  group('GetAccessTokenUsernameUsecase', () {
    test('get default user token test', () async {
      expect(await getAccessTokenUsernameUsecase.call(), tokenMock.username);
      verify(
        () => getTokenUsecase.call(tokenType: TokenType.user),
      );

      verifyNoMoreInteractions(getTokenUsecase);
    });
  });
}
