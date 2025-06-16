import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/biometric_auth/data/repositories/biometric_repository.dart';

class MockBiometricAuthRepository extends Mock implements BiometricRepository {}

void main() {
  group('BiometricAuthCanAuthenticateUseCase', () {
    late BiometricCanCheckUseCase useCase;
    late BiometricRepository repository;

    setUp(() {
      repository = MockBiometricAuthRepository();
      useCase = BiometricCanCheckUseCase(repository: repository);
    });

    test('canAuthenticate should call canAuthenticate on the repository',
        () async {
      // Arrange
      when(() => repository.canCheckBiometrics()).thenAnswer((_) async => true);

      // Act
      final result = await useCase.call(NoParams());

      // Assert
      verify(() => repository.canCheckBiometrics()).called(1);
      expect(result, true);
    });

    test(
        'canAuthenticate return false should call canAuthenticate on the repository',
        () async {
      // Arrange
      when(() => repository.canCheckBiometrics())
          .thenAnswer((_) async => false);

      // Act
      final result = await useCase.call(NoParams());

      // Assert
      verify(() => repository.canCheckBiometrics()).called(1);
      expect(result, false);
    });
  });
}
