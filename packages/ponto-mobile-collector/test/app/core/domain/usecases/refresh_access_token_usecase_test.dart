import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/refresh_access_token_usecase.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

class MockRefreshKeyStoredTokenUsecase extends Mock
    implements RefreshKeyStoredTokenUsecase {}

class MockRefreshStoredTokenUsecase extends Mock
    implements RefreshStoredTokenUsecase {}

void main() {
  late RefreshAccessTokenUsecase refreshAccessTokenUsecase;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  late RefreshKeyStoredTokenUsecase refreshKeyStoredTokenUsecase;
  late RefreshStoredTokenUsecase refreshStoredTokenUsecase;

  setUp(() {
    getAccessTokenUsecase = MockGetAccessTokenUsecase();
    refreshKeyStoredTokenUsecase = MockRefreshKeyStoredTokenUsecase();
    refreshStoredTokenUsecase = MockRefreshStoredTokenUsecase();

    when(
      () => refreshStoredTokenUsecase.call(const UserName()),
    ).thenAnswer((_) async => null);

    when(
      () => refreshKeyStoredTokenUsecase.call(),
    ).thenAnswer((_) async => null);

    when(
      () => getAccessTokenUsecase.call(),
    ).thenAnswer((_) async => null);

    refreshAccessTokenUsecase = RefreshAccessTokenUsecaseImpl(
      getTokenUsecase: getAccessTokenUsecase,
      refreshKeyStoredTokenUsecase: refreshKeyStoredTokenUsecase,
      refreshStoredTokenUsecase: refreshStoredTokenUsecase,
    );
  });

  group('RefreshAccessTokenUsecase', () {
    test('refresh access token usecase test', () async {
      await refreshAccessTokenUsecase.call();

      verify(
        () => refreshStoredTokenUsecase.call(const UserName()),
      ).called(1);

      verify(
        () => refreshKeyStoredTokenUsecase.call(),
      ).called(1);

      verify(
        () => getAccessTokenUsecase.call(),
      ).called(1);

      verifyNoMoreInteractions(refreshStoredTokenUsecase);
      verifyNoMoreInteractions(refreshKeyStoredTokenUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
    });
  });
}
