import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_token_usecase.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/token_mock.dart';

class MockGetStoredTokenUsecase extends Mock implements GetStoredTokenUsecase {}

class MockGetStoredKeyTokenUsecase extends Mock
    implements GetStoredKeyTokenUsecase {}

void main() {
  late GetTokenUsecase getTokenUsecase;
  late GetStoredTokenUsecase getStoredTokenUsecase;
  late GetStoredKeyTokenUsecase getStoredKeyTokenUsecase;

  setUp(() {
    getStoredTokenUsecase = MockGetStoredTokenUsecase();
    getStoredKeyTokenUsecase = MockGetStoredKeyTokenUsecase();

    when(
      () => getStoredKeyTokenUsecase.call(null),
    ).thenAnswer(
      (_) async => tokenMock,
    );

    when(
      () => getStoredTokenUsecase.call(const UserName()),
    ).thenAnswer(
      (_) async => (exception: null, token: tokenMock),
    );

    getTokenUsecase = GetTokenUsecaseImpl(
      getStoredKeyTokenUsecase: getStoredKeyTokenUsecase,
      getStoredTokenUsecase: getStoredTokenUsecase,
    );
  });

  group('GetTokenUsecase', () {
    test('get default user token test', () async {
      when(
        () => getStoredKeyTokenUsecase.call(null),
      ).thenAnswer(
        (_) async => null,
      );

      expect(await getTokenUsecase.call(), tokenMock);

      verify(() => getStoredTokenUsecase.call(const UserName())).called(1);
      verify(() => getStoredKeyTokenUsecase.call(null)).called(1);

      verifyNoMoreInteractions(getStoredKeyTokenUsecase);
      verifyNoMoreInteractions(getStoredTokenUsecase);
    });

    test('get key token test', () async {
      expect(await getTokenUsecase.call(tokenType: TokenType.key), tokenMock);

      verify(() => getStoredKeyTokenUsecase.call(null));

      verifyNoMoreInteractions(getStoredKeyTokenUsecase);
      verifyZeroInteractions(getStoredTokenUsecase);
    });

    test('get user token test', () async {
      expect(await getTokenUsecase.call(tokenType: TokenType.user), tokenMock);

      verify(() => getStoredTokenUsecase.call(const UserName()));

      verifyZeroInteractions(getStoredKeyTokenUsecase);
      verifyNoMoreInteractions(getStoredTokenUsecase);
    });
  });
}
