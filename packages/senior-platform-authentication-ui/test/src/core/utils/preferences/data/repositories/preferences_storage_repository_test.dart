import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/data/datasources/preferences_storage_local_datasource.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/data/repositories/preferences_storage_repository.dart';

class MockPreferencesStorageDatasource extends Mock
    implements PreferencesStorageDatasource {}

void main() {
  late final PreferencesStorageDatasource datasource;
  late final PreferencesStorageRepository repository;

  setUpAll(() {
    datasource = MockPreferencesStorageDatasource();
    repository = PreferencesStorageRepositoryImpl(datasource: datasource);
  });

  group('readSAMLOnboardingEnabled', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.readSAMLOnboardingEnabled(),
      ).thenAnswer((_) async {
        return true;
      });

      verifyNever(
        () => datasource.readSAMLOnboardingEnabled(),
      );

      // Act
      final result = await repository.readSAMLOnboardingEnabled();

      // Assert
      verify(
        () => datasource.readSAMLOnboardingEnabled(),
      ).called(1);

      expect(result, true);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readSAMLOnboardingEnabled(),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.readSAMLOnboardingEnabled(),
      );

      // Act
      final action = repository.readSAMLOnboardingEnabled();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.readSAMLOnboardingEnabled(),
      ).called(1);
    });
  });

  group('writeSAMLOnboardingEnabled', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeSAMLOnboardingEnabled(any()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.writeSAMLOnboardingEnabled(any()),
      );

      // Act
      await repository.writeSAMLOnboardingEnabled(true);

      // Assert
      verify(
        () => datasource.writeSAMLOnboardingEnabled(true),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeSAMLOnboardingEnabled(any()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.writeSAMLOnboardingEnabled(any()),
      );

      // Act
      final action = repository.writeSAMLOnboardingEnabled(true);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.writeSAMLOnboardingEnabled(true),
      ).called(1);
    });
  });
}
