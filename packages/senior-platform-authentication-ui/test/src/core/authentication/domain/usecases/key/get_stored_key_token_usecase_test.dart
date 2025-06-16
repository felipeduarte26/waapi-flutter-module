import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../mocks/token_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  const tAccessKey = 'accessKey';
  late final SecureStorageRepository repository;

  setUpAll(() {
    repository = MockSecureStorageRepository();
  });

  group('getStoredKeyTokenUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return tokenMock;
      });

      GetStoredKeyTokenUsecase getStoredKeyTokenUsecase =
          GetStoredKeyTokenUsecase(
        secureStorageRepository: repository,
      );

      // Act
      final result = await getStoredKeyTokenUsecase.call(tAccessKey);

      // Assert
      expect(result, isA<Token?>());

      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verifyNoMoreInteractions(repository);
    });

    test('should execute successfully with last Key', () async {
      // Arrange
      when(
        () => repository.readLastKey(),
      ).thenAnswer((_) async {
        return tAccessKey;
      });

      when(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return tokenMock;
      });

      GetStoredKeyTokenUsecase getStoredKeyTokenUsecase =
          GetStoredKeyTokenUsecase(
        secureStorageRepository: repository,
      );

      // Act
      final result = await getStoredKeyTokenUsecase.call(null);

      // Assert
      expect(result, isA<Token?>());

      verify(
        () => repository.readLastKey(),
      ).called(1);

      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verifyNoMoreInteractions(repository);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(
        () => repository.readLastKey(),
      ).thenThrow(Exception('oops'));

      GetStoredKeyTokenUsecase getStoredKeyTokenUsecase =
          GetStoredKeyTokenUsecase(
        secureStorageRepository: repository,
      );

      // Act
      final action = getStoredKeyTokenUsecase.call(null);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => repository.readLastKey(),
      ).called(1);

      verifyNoMoreInteractions(repository);
    });
  });
}
