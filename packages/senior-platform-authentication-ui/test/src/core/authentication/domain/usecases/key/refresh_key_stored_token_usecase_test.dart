import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../mocks/encryption_key_mock.dart';
import '../../../../../../mocks/key_authentication_data_mock.dart';
import '../../../../../../mocks/login_with_key_mock.dart';
import '../../../../../../mocks/token_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

class MockClearKeyStoredDataUsecase extends Mock
    implements ClearKeyStoredDataUsecase {}

class MockGetUserUsecase extends Mock implements GetUserUsecase {}

class MockRefreshTokenUsecase extends Mock implements RefreshTokenUsecase {}

class MockStoreKeyAuthenticationDataUsecase extends Mock
    implements StoreKeyAuthenticationDataUsecase {}

class MockAuthenticateKeyUsecase extends Mock
    implements AuthenticateKeyUsecase {}

void main() {
  const tAccessKey = 'accessKey';
  late SecureStorageRepository repository;
  late RefreshKeyStoredTokenUsecase refreshKeyStoredTokenUsecase;
  late ClearKeyStoredDataUsecase clearKeyStoredDataUsecase;
  late GetUserUsecase getUserUsecase;
  late RefreshTokenUsecase refreshTokenUsecase;
  late StoreKeyAuthenticationDataUsecase storeKeyAuthenticationDataUsecase;
  late AuthenticateKeyUsecase authenticateKeyUsecase;

  setUpAll(() {
    SeniorAuthentication.initialize(
      encryptionKey: encryptionKeyMock,
    );
  });

  setUp(() {
    repository = MockSecureStorageRepository();
    clearKeyStoredDataUsecase = MockClearKeyStoredDataUsecase();
    getUserUsecase = MockGetUserUsecase();
    refreshTokenUsecase = MockRefreshTokenUsecase();
    storeKeyAuthenticationDataUsecase = MockStoreKeyAuthenticationDataUsecase();
    authenticateKeyUsecase = MockAuthenticateKeyUsecase();

    refreshKeyStoredTokenUsecase = RefreshKeyStoredTokenUsecase(
      clearKeyStoredDataUsecase: clearKeyStoredDataUsecase,
      getUserUsecase: getUserUsecase,
      refreshTokenUsecase: refreshTokenUsecase,
      storeAuthenticationDataUsecase: storeKeyAuthenticationDataUsecase,
      secureStorageRepository: repository,
      authenticateKeyUsecase: authenticateKeyUsecase,
    );
  });

  test('should execute successfully', () async {
    // Arrange
    registerFallbackValue(refreshTokenMock);
    registerFallbackValue(keyAuthenticationDataMock);

    when(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).thenAnswer((_) async {
      return tokenMock;
    });

    when(
      () => repository.readKey(accessKey: tAccessKey),
    ).thenAnswer((_) async {
      return loginWithKeyMock;
    });

    when(
      () => refreshTokenUsecase.call(any()),
    ).thenAnswer((_) async {
      return authenticationResponseMock;
    });

    when(
      () => storeKeyAuthenticationDataUsecase.call(any()),
    ).thenAnswer((_) async {
      return true;
    });

    // Act
    final result = await refreshKeyStoredTokenUsecase.call(tAccessKey);

    // Assert
    expect(result, isA<Token>());

    verify(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => repository.readKey(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => refreshTokenUsecase.call(any()),
    ).called(1);

    verify(
      () => storeKeyAuthenticationDataUsecase.call(any()),
    ).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(refreshTokenUsecase);
    verifyNoMoreInteractions(storeKeyAuthenticationDataUsecase);
    verifyZeroInteractions(clearKeyStoredDataUsecase);
    verifyZeroInteractions(getUserUsecase);
  });

  test('check if stored refreshToken is not empty', () async {
    // Arrange
    Token tToken = tokenMock.copyWith(refreshToken: '');

    when(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).thenAnswer((_) async {
      return tToken;
    });

    when(
      () => repository.readKey(accessKey: tAccessKey),
    ).thenAnswer((_) async {
      return loginWithKeyMock;
    });

    when(
      () => clearKeyStoredDataUsecase.call(tAccessKey),
    ).thenAnswer((_) async {
      return;
    });

    // Act
    final result = await refreshKeyStoredTokenUsecase.call(tAccessKey);

    // Assert
    expect(result, null);

    verify(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => repository.readKey(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => clearKeyStoredDataUsecase.call(tAccessKey),
    ).called(1);

    verifyNoMoreInteractions(repository);
    verifyZeroInteractions(refreshTokenUsecase);
    verifyZeroInteractions(storeKeyAuthenticationDataUsecase);
    verifyNoMoreInteractions(clearKeyStoredDataUsecase);
    verifyZeroInteractions(getUserUsecase);
  });

  test('check if stored accessToken is not empty', () async {
    // Arrange
    Token tToken = tokenMock.copyWith(accessToken: '');

    when(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).thenAnswer((_) async {
      return tToken;
    });

    when(
      () => repository.readKey(accessKey: tAccessKey),
    ).thenAnswer((_) async {
      return loginWithKeyMock;
    });

    when(
      () => clearKeyStoredDataUsecase.call(tAccessKey),
    ).thenAnswer((_) async {
      return;
    });

    // Act
    final result = await refreshKeyStoredTokenUsecase.call(tAccessKey);

    // Assert
    expect(result, null);

    verify(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => repository.readKey(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => clearKeyStoredDataUsecase.call(tAccessKey),
    ).called(1);

    verifyNoMoreInteractions(repository);
    verifyZeroInteractions(refreshTokenUsecase);
    verifyZeroInteractions(storeKeyAuthenticationDataUsecase);
    verifyNoMoreInteractions(clearKeyStoredDataUsecase);
    verifyZeroInteractions(getUserUsecase);
  });

  test('should return null and clear storage if RefreshTokenUsecase fails',
      () async {
    // Arrange
    registerFallbackValue(refreshTokenMock);
    registerFallbackValue(keyAuthenticationDataMock);

    when(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).thenAnswer((_) async {
      return tokenMock;
    });

    when(
      () => repository.readKey(accessKey: tAccessKey),
    ).thenAnswer((_) async {
      return loginWithKeyMock;
    });

    when(
      () => clearKeyStoredDataUsecase.call(tAccessKey),
    ).thenAnswer((_) async {
      return;
    });

    when(
      () => storeKeyAuthenticationDataUsecase.call(any()),
    ).thenAnswer((_) async {
      return false;
    });

    when(
      () => refreshTokenUsecase.call(any()),
    ).thenAnswer((_) async {
      return authenticationResponseMock;
    });

    // Act
    final result = await refreshKeyStoredTokenUsecase.call(tAccessKey);

    // Assert
    expect(result, null);

    verify(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => repository.readKey(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => clearKeyStoredDataUsecase.call(tAccessKey),
    ).called(1);

    verify(
      () => storeKeyAuthenticationDataUsecase.call(any()),
    ).called(1);

    verify(
      () => refreshTokenUsecase.call(any()),
    ).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(refreshTokenUsecase);
    verifyNoMoreInteractions(storeKeyAuthenticationDataUsecase);
    verifyNoMoreInteractions(clearKeyStoredDataUsecase);
    verifyZeroInteractions(getUserUsecase);
  });

  test('should return null when readKeyToken return throw', () async {
    // Arrange
    when(
      () => repository.readLastKey(),
    ).thenAnswer((_) async {
      return tAccessKey;
    });

    when(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).thenThrow(Exception('oops'));

    when(
      () => clearKeyStoredDataUsecase.call(tAccessKey),
    ).thenAnswer((_) async {
      return;
    });

    // Act
    final result = await refreshKeyStoredTokenUsecase.call(null);

    // Assert
    expect(result, null);

    verify(
      () => repository.readLastKey(),
    ).called(1);

    verify(
      () => repository.readKeyToken(accessKey: tAccessKey),
    ).called(1);

    verify(
      () => clearKeyStoredDataUsecase.call(tAccessKey),
    ).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(clearKeyStoredDataUsecase);
    verifyZeroInteractions(refreshTokenUsecase);
    verifyZeroInteractions(storeKeyAuthenticationDataUsecase);
    verifyZeroInteractions(getUserUsecase);
  });
}
