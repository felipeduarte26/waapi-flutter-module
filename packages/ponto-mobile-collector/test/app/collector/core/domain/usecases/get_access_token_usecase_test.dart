import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_token_usecase.dart';

import '../../../../../mocks/token_mock.dart';

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

void main() {
  late GetAccessTokenUsecase getAccessTokenUsecase;
  late GetTokenUsecase getTokenUsecase;

  setUp(() {
    getTokenUsecase = MockGetTokenUsecase();

    when(
      () => getTokenUsecase.call(tokenType: TokenType.user),
    ).thenAnswer((_) async => tokenMock);

    when(
      () => getTokenUsecase.call(tokenType: TokenType.key),
    ).thenAnswer((_) async => tokenMock);

    getAccessTokenUsecase = GetAccessTokenUsecaseImpl(
      getTokenUsecase: getTokenUsecase,
    );
  });

  group('GetAccessTokenUsecase', () {
    test('get default key token test', () async {
      when(
        () => getTokenUsecase.call(),
      ).thenAnswer((_) async => tokenMock);

      await getAccessTokenUsecase.call();

      verify(() => getTokenUsecase.call());

      verifyNoMoreInteractions(getTokenUsecase);
    });

    test('get key token test', () async {
      await getAccessTokenUsecase.call(tokenType: TokenType.key);

      verify(() => getTokenUsecase.call(tokenType: TokenType.key));

      verifyNoMoreInteractions(getTokenUsecase);
    });

    test('get user token test', () async {
      await getAccessTokenUsecase.call(tokenType: TokenType.user);

      verify(() => getTokenUsecase.call(tokenType: TokenType.user));

      verifyNoMoreInteractions(getTokenUsecase);
    });
  });
}
