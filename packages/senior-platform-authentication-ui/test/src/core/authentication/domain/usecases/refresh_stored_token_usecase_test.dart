import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/authentication_data_mock.dart';
import '../../../../../mocks/encryption_key_mock.dart';
import '../../../../../mocks/get_user_input_mock.dart';
import '../../../../../mocks/token_mock.dart';
import '../../../../../mocks/user_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

class MockRefreshTokenUsecase extends Mock implements RefreshTokenUsecase {}

class MockGetUserUsecase extends Mock implements GetUserUsecase {}

class MockStoreAuthenticationDataUsecase extends Mock
    implements StoreAuthenticationDataUsecase {}

class MockClearStoredDataUsecase extends Mock
    implements ClearStoredDataUsecase {}

void main() {
  late SecureStorageRepository repository;
  late RefreshTokenUsecase refreshTokenUsecase;
  late GetUserUsecase getUserUsecase;
  late StoreAuthenticationDataUsecase storeAuthenticationDataUsecase;
  late ClearStoredDataUsecase clearStoredDataUsecase;
  late RefreshStoredTokenUsecase refreshStoredTokenUsecase;
  const tCurrentUsername = 'teste@senior.com.br';
  const tUsername = UserName(currentUsername: tCurrentUsername);

  setUpAll(() {
    SeniorAuthentication.initialize(
      encryptionKey: encryptionKeyMock,
    );
  });

  setUp(() {
    repository = MockSecureStorageRepository();
    refreshTokenUsecase = MockRefreshTokenUsecase();
    getUserUsecase = MockGetUserUsecase();
    storeAuthenticationDataUsecase = MockStoreAuthenticationDataUsecase();
    clearStoredDataUsecase = MockClearStoredDataUsecase();
    refreshStoredTokenUsecase = RefreshStoredTokenUsecase(
      secureStorageRepository: repository,
      refreshTokenUsecase: refreshTokenUsecase,
      getUserUsecase: getUserUsecase,
      storeAuthenticationDataUsecase: storeAuthenticationDataUsecase,
      clearStoredDataUsecase: clearStoredDataUsecase,
    );

    registerFallbackValue(refreshTokenMock);
    registerFallbackValue(tUsername);
    registerFallbackValue(authenticationDataMock);
    registerFallbackValue(getUserInputMock);
  });

  void verifyDependenciesNotCalled() {
    verifyNever(
      () => repository.readToken(username: tCurrentUsername),
    );

    verifyNever(
      () => getUserUsecase(any()),
    );

    verifyNever(
      () => refreshTokenUsecase(any()),
    );

    verifyNever(
      () => clearStoredDataUsecase(any()),
    );

    verifyNever(
      () => storeAuthenticationDataUsecase(any()),
    );
  }

  mockSuccessDependencies() {
    when(
      () => repository.readToken(username: tCurrentUsername),
    ).thenAnswer((_) async {
      return tokenMock;
    });
    when(
      () => repository.readUser(username: tCurrentUsername),
    ).thenAnswer((_) async {
      return userMock;
    });

    when(
      () => getUserUsecase(any()),
    ).thenAnswer((_) async {
      return userMock;
    });

    when(
      () => refreshTokenUsecase(any()),
    ).thenAnswer((_) async {
      return authenticationResponseMock;
    });

    when(
      () => clearStoredDataUsecase(any()),
    ).thenAnswer((_) async {
      return;
    });

    when(
      () => storeAuthenticationDataUsecase(any()),
    ).thenAnswer((_) async {
      return true;
    });
  }

  test('should execute successfully', () async {
    // Arrange
    mockSuccessDependencies();

    verifyDependenciesNotCalled();

    // Act
    final result = await refreshStoredTokenUsecase(tUsername);

    // Assert
    verify(
      () => repository.readToken(username: tCurrentUsername),
    ).called(1);

    verify(
      () => repository.readUser(username: tCurrentUsername),
    ).called(1);

    verifyNever(
      () => clearStoredDataUsecase.call(any()),
    );

    verify(
      () => getUserUsecase.call(any()),
    ).called(1);

    verify(
      () => refreshTokenUsecase.call(any()),
    ).called(1);

    verify(
      () => storeAuthenticationDataUsecase.call(any()),
    ).called(1);

    expect(result, isA<Token>());
  });

  test('check if stored accessToken is not empty', () async {
    // Arrange
    mockSuccessDependencies();

    Token tToken = tokenMock.copyWith(accessToken: '');
    when(
      () => repository.readToken(username: tCurrentUsername),
    ).thenAnswer((_) async {
      return tToken;
    });

    verifyDependenciesNotCalled();

    // Act
    final result = await refreshStoredTokenUsecase(tUsername);

    // Assert
    verify(
      () => repository.readToken(username: tCurrentUsername),
    ).called(1);

    verify(
      () => repository.readUser(username: tCurrentUsername),
    ).called(1);

    verify(
      () => clearStoredDataUsecase.call(any()),
    ).called(1);

    verifyNever(
      () => getUserUsecase.call(any()),
    );

    verifyNever(
      () => refreshTokenUsecase.call(any()),
    );

    verifyNever(
      () => storeAuthenticationDataUsecase.call(any()),
    );

    expect(result, null);
  });

  test('check if stored refreshToken is not empty', () async {
    // Arrange
    mockSuccessDependencies();
    Token tToken = tokenMock.copyWith(refreshToken: '');
    when(
      () => repository.readToken(username: tCurrentUsername),
    ).thenAnswer((_) async {
      return tToken;
    });
    verifyDependenciesNotCalled();

    // Act
    final result = await refreshStoredTokenUsecase(tUsername);

    // Assert
    verify(
      () => repository.readToken(username: tCurrentUsername),
    ).called(1);

    verify(
      () => repository.readUser(username: tCurrentUsername),
    ).called(1);

    verify(
      () => clearStoredDataUsecase.call(any()),
    ).called(1);

    verifyNever(
      () => getUserUsecase.call(any()),
    );

    verifyNever(
      () => refreshTokenUsecase.call(any()),
    );

    verifyNever(
      () => storeAuthenticationDataUsecase.call(any()),
    );

    expect(result, null);
  });

  test('should return null and clear storage if RefreshTokenUsecase fails',
      () async {
    // Arrange
    mockSuccessDependencies();
    when(
      () => refreshTokenUsecase(any()),
    ).thenThrow(Exception('oops'));
    verifyDependenciesNotCalled();

    // Act
    final result = await refreshStoredTokenUsecase(tUsername);

    // Assert
    verify(
      () => repository.readToken(username: tCurrentUsername),
    ).called(1);

    verify(
      () => repository.readUser(username: tCurrentUsername),
    ).called(1);

    verify(
      () => clearStoredDataUsecase.call(any()),
    ).called(1);

    verifyNever(
      () => getUserUsecase.call(any()),
    );

    verify(
      () => refreshTokenUsecase.call(any()),
    ).called(1);

    verifyNever(
      () => storeAuthenticationDataUsecase.call(any()),
    );

    expect(result, null);
  });

  test(
      'should return null and clear storage if StoreAuthenticationDataUsecase fails',
      () async {
    // Arrange
    mockSuccessDependencies();
    when(
      () => storeAuthenticationDataUsecase(any()),
    ).thenAnswer((_) async {
      return false;
    });
    verifyDependenciesNotCalled();

    // Act
    final result = await refreshStoredTokenUsecase(tUsername);

    // Assert
    verify(
      () => repository.readToken(username: tCurrentUsername),
    ).called(1);

    verify(
      () => repository.readUser(username: tCurrentUsername),
    ).called(1);

    verify(
      () => clearStoredDataUsecase.call(any()),
    ).called(1);

    verify(
      () => getUserUsecase.call(any()),
    ).called(1);

    verify(
      () => refreshTokenUsecase.call(any()),
    ).called(1);

    verify(
      () => storeAuthenticationDataUsecase.call(any()),
    ).called(1);

    expect(result, null);
  });
}
