import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../mocks/login_with_key_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late final GetStoredKeyUsecase getStoredKeyUsecase;
  late final SecureStorageRepository repository;
  const tAccessKey = 'accessKey';

  setUpAll(() {
    repository = MockSecureStorageRepository();
    getStoredKeyUsecase =
        GetStoredKeyUsecase(secureStorageRepository: repository);
  });

  group('getStoredKeyUsecase', () {
    test(
        'should execute successfully when '
        'is not empty', () async {
      // Arrange
      when(
        () => repository.readKey(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return loginWithKeyMock;
      });

      // Act
      final result = await getStoredKeyUsecase(tAccessKey);

      // Assert
      expect(result, isA<ApplicationKey?>());

      verify(
        () => repository.readKey(accessKey: tAccessKey),
      ).called(1);

      verifyNoMoreInteractions(repository);
    });

    test(
        'should execute successfully whe '
        'currentUsername is empty', () async {
      // Arrange
      when(
        () => repository.readLastKey(),
      ).thenAnswer((_) async {
        return tAccessKey;
      });

      when(
        () => repository.readKey(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return loginWithKeyMock;
      });

      // Act
      final result = await getStoredKeyUsecase(null);

      // Assert
      expect(result, isA<ApplicationKey?>());

      verify(
        () => repository.readKey(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readLastKey(),
      ).called(1);

      verifyNoMoreInteractions(repository);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(
        () => repository.readKey(accessKey: tAccessKey),
      ).thenThrow(Exception('oops'));

      // Act
      final action = getStoredKeyUsecase(tAccessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => repository.readKey(accessKey: tAccessKey),
      ).called(1);

      verifyNoMoreInteractions(repository);
    });
  });
}
