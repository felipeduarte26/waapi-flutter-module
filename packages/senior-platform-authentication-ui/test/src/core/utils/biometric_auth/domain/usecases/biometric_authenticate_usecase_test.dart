import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/biometric_auth/data/repositories/biometric_repository.dart';

class MockBiometricAuthRepository extends Mock implements BiometricRepository {}

void main() {
  group('BiometricAuthAuthenticateUseCase', () {
    late BiometricAuthenticateUsecase useCase;
    late BiometricRepository repository;

    setUp(() {
      repository = MockBiometricAuthRepository();
      useCase = BiometricAuthenticateUsecase(
        repository: repository,
      );
    });

    test('authenticate should call authenticate on the repository', () async {
      // Arrange
      when(() => repository.biometricsAuthenticate()).thenAnswer(
        (_) async => BiometryStatus.success,
      );

      // Act
      final result = await useCase.call(
        NoParams(),
      );

      // Assert
      verify(() => repository.biometricsAuthenticate()).called(
        1,
      );
      expect(
        result,
        BiometryStatus.success,
      );
    });
  });
}
