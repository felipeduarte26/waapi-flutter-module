import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/data/repositories/preferences_storage_repository.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/domain/usecases/get_saml_onboarding_enabled_usecase.dart';

class MockPreferencesStorageRepository extends Mock
    implements PreferencesStorageRepository {}

void main() {
  late final GetSAMLOnboardingEnabledUsecase getSAMLOnboardingEnabledUsecase;
  late final PreferencesStorageRepository repository;

  setUpAll(() {
    repository = MockPreferencesStorageRepository();
    getSAMLOnboardingEnabledUsecase = GetSAMLOnboardingEnabledUsecase(
        preferencesStorageRepository: repository);
  });

  group('getSAMLOnboardingEnabledUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => repository.readSAMLOnboardingEnabled(),
      ).thenAnswer((_) async {
        return true;
      });

      verifyNever(
        () => repository.readSAMLOnboardingEnabled(),
      );

      // Act
      final result = await getSAMLOnboardingEnabledUsecase(NoParams());

      // Assert
      expect(result, true);

      verify(
        () => repository.readSAMLOnboardingEnabled(),
      ).called(1);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(
        () => repository.readSAMLOnboardingEnabled(),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => repository.readSAMLOnboardingEnabled(),
      );

      // Act
      final action = getSAMLOnboardingEnabledUsecase(NoParams());

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => repository.readSAMLOnboardingEnabled(),
      ).called(1);
    });
  });
}
