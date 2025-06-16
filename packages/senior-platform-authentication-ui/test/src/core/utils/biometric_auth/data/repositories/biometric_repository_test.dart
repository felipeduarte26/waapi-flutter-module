import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/biometric_auth/data/datasources/biometric_datasource.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/biometric_auth/data/repositories/biometric_repository.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/constants.dart';

class MockBiometricDataSource extends Mock implements BiometricDatasource {}

void main() {
  group('BiometricAuthRepositoryImpl', () {
    late BiometricRepository repository;
    late MockBiometricDataSource dataSource;

    setUp(() {
      dataSource = MockBiometricDataSource();
      repository = BiometricRepositoryImpl(
        biometricAuthDataSource: dataSource,
      );
    });

    test('canAuthenticate should call checkBiometrics on the data source',
        () async {
      // Arrange
      when(() => dataSource.canCheckBiometrics()).thenAnswer((_) async => true);

      // Act
      final result = await repository.canCheckBiometrics();

      // Assert
      verify(() => dataSource.canCheckBiometrics()).called(1);
      expect(result, true);
    });

    test('authenticate should call authenticate on the data source', () async {
      // Arrange
      when(() => dataSource.biometricsAuthenticate()).thenAnswer(
        (_) async => BiometryStatus.success,
      );

      // Act
      final result = await repository.biometricsAuthenticate();

      // Assert
      verify(() => dataSource.biometricsAuthenticate()).called(1);
      expect(result, BiometryStatus.success);
    });

    test(
        'getAvailableBiometrics should call getAvailableBiometrics on the data source',
        () async {
      // Arrange
      when(() => dataSource.getAvailableBiometrics())
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.getAvailableBiometrics();

      // Assert
      verify(() => dataSource.getAvailableBiometrics()).called(1);
      expect(result, true);
    });
  });
}
