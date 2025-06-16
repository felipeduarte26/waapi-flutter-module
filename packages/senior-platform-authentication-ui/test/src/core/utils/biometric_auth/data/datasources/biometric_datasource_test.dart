import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/biometric_auth/data/datasources/biometric_datasource.dart';

import '../../../../../../mocks/encryption_key_mock.dart';

void main() {
  late BiometricDatasourceImpl biometricAuthDataSource;
  late MockLocalAuthPlatform mockLocalAuthPlatform;
  setUpAll(() {
    biometricAuthDataSource = BiometricDatasourceImpl(
      localAuthentication: LocalAuthentication(),
    );
    mockLocalAuthPlatform = MockLocalAuthPlatform();
    LocalAuthPlatform.instance = mockLocalAuthPlatform;
    SeniorAuthentication.initialize(
      enableBiometry: true,
      enableBiometryOnly: true,
      encryptionKey: encryptionKeyMock,
    );
  });
  group(
    'BiometricAuthDataSourceTrue ',
    () {
      setUp(() {
        enableBiometricAuth = true;
      });

      test(
        'checkBiometrics should return true when biometric authentication is enabled',
        () async {
          final result = await biometricAuthDataSource.canCheckBiometrics();
          expect(
            result,
            true,
          );
        },
      );

      test(
          'authenticate should return true if biometric authentication is successful',
          () async {
        final result = await biometricAuthDataSource.biometricsAuthenticate();
        expect(
          result,
          BiometryStatus.success,
        );
      });

      test(
        'getAvailableBiometrics should return true if biometric authentication is successful',
        () async {
          final result = await biometricAuthDataSource.getAvailableBiometrics();
          expect(
            result,
            true,
          );
        },
      );
    },
  );

  group(
    'BiometricAuthDataSourceFalse ',
    () {
      setUp(() {
        enableBiometricAuth = false;
      });

      test(
        'checkBiometrics should return false when biometric authentication is enabled',
        () async {
          final result = await biometricAuthDataSource.canCheckBiometrics();
          expect(
            result,
            false,
          );
        },
      );

      test(
        'authenticate should return false if biometric authentication is successful',
        () async {
          final result = await biometricAuthDataSource.biometricsAuthenticate();
          expect(
            result,
            BiometryStatus.canceled,
          );
        },
      );

      test(
        'getAvailableBiometrics should return false if biometric authentication is successful',
        () async {
          final result = await biometricAuthDataSource.getAvailableBiometrics();
          expect(
            result,
            false,
          );
        },
      );
    },
  );

  group('BiometricAuthDataSourceFalseErro', () {
    setUp(() {
      enableBiometricAuth = true;
    });

    test(
      'getAvailableBiometrics should return false when an exception is thrown',
      () async {
        mockLocalAuthPlatform.shouldThrowError = true;
        final result = await biometricAuthDataSource.getAvailableBiometrics();
        expect(
          result,
          false,
        );
      },
    );

    test(
      'checkBiometrics should return true when biometric authentication is enabled',
      () async {
        mockLocalAuthPlatform.shouldThrowError = true;
        final result = await biometricAuthDataSource.canCheckBiometrics();
        expect(
          result,
          false,
        );
      },
    );
  });
}

bool enableBiometricAuth = false;

class MockLocalAuthPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements LocalAuthPlatform {
  MockLocalAuthPlatform() {
    throwOnMissingStub(this);
  }

  // Variável de controle para simular erro
  bool shouldThrowError = false;
  @override
  Future<bool> deviceSupportsBiometrics() async {
    if (shouldThrowError) {
      throw Exception('Some error');
    }
    return Future.value(enableBiometricAuth);
  }

  @override
  Future<bool> authenticate({
    required String? localizedReason,
    required Iterable<AuthMessages>? authMessages,
    AuthenticationOptions? options = const AuthenticationOptions(),
  }) =>
      Future.value(enableBiometricAuth);

  @override
  Future<List<BiometricType>> getEnrolledBiometrics() async {
    if (shouldThrowError) {
      throw Exception('Some error');
    }
    if (enableBiometricAuth) {
      return [BiometricType.face, BiometricType.fingerprint];
    } else {
      return [];
    }
  }
}
