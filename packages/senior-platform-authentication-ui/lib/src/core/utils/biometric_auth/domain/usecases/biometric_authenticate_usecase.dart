import 'dart:async';

import '../../../../../../senior_platform_authentication_ui.dart';
import '../../data/repositories/biometric_repository.dart';

class BiometricAuthenticateUsecase
    implements BaseUsecase<BiometryStatus, NoParams> {
  late final BiometricRepository _biometricRepository;

  BiometricAuthenticateUsecase({
    BiometricRepository? repository,
  }) {
    _biometricRepository = repository ?? BiometricRepositoryImpl();
  }

  @override
  FutureOr<BiometryStatus> call(NoParams params) async {
    return await _biometricRepository.biometricsAuthenticate();
  }
}
