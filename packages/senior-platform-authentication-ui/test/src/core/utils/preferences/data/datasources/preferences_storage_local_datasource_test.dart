import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/data/datasources/preferences_storage_local_datasource.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/domain/entities/preferences_keys.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late final FlutterSecureStorage storage;
  late final PreferencesStorageDatasource datasource;

  setUpAll(() {
    storage = MockFlutterSecureStorage();
    datasource = PreferencesStorageLocalDatasource(storage: storage);
  });

  group('readSAMLOnboardingEnabled', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.read(
          key: PreferencesStorageKeys.samlOnboardingEnabled,
        ),
      ).thenAnswer((_) async {
        return "true";
      });

      // Act
      final result = await datasource.readSAMLOnboardingEnabled();

      // Assert
      expect(result, true);

      verify(
        () => storage.read(key: PreferencesStorageKeys.samlOnboardingEnabled),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(key: PreferencesStorageKeys.samlOnboardingEnabled),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.readSAMLOnboardingEnabled();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(key: PreferencesStorageKeys.samlOnboardingEnabled),
      ).called(1);
    });
  });

  group('writeSAMLOnboardingEnabled', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeSAMLOnboardingEnabled(true);

      // Assert
      verify(
        () => storage.write(
          key: PreferencesStorageKeys.samlOnboardingEnabled,
          value: "true",
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.writeSAMLOnboardingEnabled(true);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: PreferencesStorageKeys.samlOnboardingEnabled,
          value: "true",
        ),
      ).called(1);
    });
  });
}
