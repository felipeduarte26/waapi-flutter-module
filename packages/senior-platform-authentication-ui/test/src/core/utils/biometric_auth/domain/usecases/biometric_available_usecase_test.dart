import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/biometric_auth/data/repositories/biometric_repository.dart';

class MockBiometricAuthRepository extends Mock implements BiometricRepository {}

void main() {
  group('BiometricAvailableUseCase', () {
    late BiometricRepository repository;
    late BiometricAvailableUsecase useCase;

    setUp(() {
      repository = MockBiometricAuthRepository();
      useCase = BiometricAvailableUsecase(repository: repository);
    });
    test('authenticate should call authenticate on the repository', () async {
      // Arrange
      when(() => repository.getAvailableBiometrics())
          .thenAnswer((_) async => true);

      // Act
      final result = await useCase.call(NoParams());

      // Assert
      verify(() => repository.getAvailableBiometrics()).called(1);
      expect(result, true);
    });
  });
}
