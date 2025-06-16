import 'dart:async';

import '../../../../../../senior_platform_authentication_ui.dart';
import '../../data/repositories/biometric_repository.dart';

class BiometricCanCheckUseCase implements BaseUsecase<bool, NoParams> {
  late final BiometricRepository _biometricRepository;

  BiometricCanCheckUseCase({
    BiometricRepository? repository,
  }) {
    _biometricRepository = repository ?? BiometricRepositoryImpl();
  }

  @override
  FutureOr<bool> call(NoParams params) async {
    return await _biometricRepository.canCheckBiometrics();
  }
}
