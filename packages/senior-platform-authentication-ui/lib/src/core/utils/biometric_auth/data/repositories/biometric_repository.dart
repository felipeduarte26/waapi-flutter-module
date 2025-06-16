import '../../../../../../senior_platform_authentication_ui.dart';
import '../datasources/biometric_datasource.dart';

abstract class BiometricRepository {
  Future<bool> canCheckBiometrics();
  Future<BiometryStatus> biometricsAuthenticate();
  Future<bool> getAvailableBiometrics();
}

class BiometricRepositoryImpl implements BiometricRepository {
  late final BiometricDatasource _biometricAuthDataSource;

  BiometricRepositoryImpl({BiometricDatasource? biometricAuthDataSource}) {
    _biometricAuthDataSource =
        biometricAuthDataSource ?? BiometricDatasourceImpl();
  }

  @override
  Future<bool> canCheckBiometrics() async {
    return _biometricAuthDataSource.canCheckBiometrics();
  }

  @override
  Future<BiometryStatus> biometricsAuthenticate() async {
    return _biometricAuthDataSource.biometricsAuthenticate();
  }

  @override
  Future<bool> getAvailableBiometrics() {
    return _biometricAuthDataSource.getAvailableBiometrics();
  }
}
