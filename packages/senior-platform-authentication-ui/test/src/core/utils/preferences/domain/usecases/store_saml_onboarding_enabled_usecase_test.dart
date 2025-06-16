import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/data/repositories/preferences_storage_repository.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/domain/usecases/store_saml_onboarding_enabled_usecase.dart';

class MockPreferencesStorageRepository extends Mock
    implements PreferencesStorageRepository {}

void main() {
  late final StoreSAMLOnboardingEnabledUsecase
      storeSAMLOnboardingEnabledUsecase;
  late final PreferencesStorageRepository repository;

  setUpAll(() {
    repository = MockPreferencesStorageRepository();
    storeSAMLOnboardingEnabledUsecase = StoreSAMLOnboardingEnabledUsecase(
        preferencesStorageRepository: repository);
  });

  group('storeSAMLOnboardingEnabledUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => repository.writeSAMLOnboardingEnabled(any()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => repository.writeSAMLOnboardingEnabled(any()),
      );

      // Act
      await storeSAMLOnboardingEnabledUsecase(true);

      // Assert
      verify(
        () => repository.writeSAMLOnboardingEnabled(true),
      ).called(1);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(
        () => repository.writeSAMLOnboardingEnabled(any()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => repository.writeSAMLOnboardingEnabled(any()),
      );

      // Act
      final action = storeSAMLOnboardingEnabledUsecase(true);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => repository.writeSAMLOnboardingEnabled(true),
      ).called(1);
    });
  });
}
