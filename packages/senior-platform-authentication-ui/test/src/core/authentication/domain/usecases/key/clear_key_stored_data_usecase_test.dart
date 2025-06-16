import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late final SecureStorageRepository repository;
  const tAccessKey = 'accessKey';

  setUpAll(() {
    repository = MockSecureStorageRepository();
  });

  group('clearKeyStoredDataUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => repository.deleteKey(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.deleteKeyToken(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.deleteKeyTokenExpirationDate(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.deleteLastKey(),
      ).thenAnswer((_) async {
        return;
      });

      ClearKeyStoredDataUsecase clearKeyStoredDataUsecase =
          ClearKeyStoredDataUsecase(
        secureStorageRepository: repository,
      );

      // Act
      await clearKeyStoredDataUsecase.call(tAccessKey);

      // Assert
      verify(
        () => repository.deleteKey(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.deleteKeyToken(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.deleteKeyTokenExpirationDate(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.deleteLastKey(),
      ).called(1);

      verifyNoMoreInteractions(repository);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(
        () => repository.deleteKey(accessKey: tAccessKey),
      ).thenThrow(Exception('oops'));

      ClearKeyStoredDataUsecase clearKeyStoredDataUsecase =
          ClearKeyStoredDataUsecase(
        secureStorageRepository: repository,
      );

      // Act
      final action = clearKeyStoredDataUsecase(tAccessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => repository.deleteKey(accessKey: tAccessKey),
      ).called(1);

      verifyNoMoreInteractions(repository);
    });
  });
}
