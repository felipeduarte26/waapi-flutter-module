import '../repositories/register_device_token_repository.dart';
import '../types/notification_domain_types.dart';

abstract class RegisterDeviceTokenUsecase {
  RegisterDeviceTokenCallback call({
    required String token,
  });
}

class RegisterDeviceTokenUsecaseImpl implements RegisterDeviceTokenUsecase {
  final RegisterDeviceTokenRepository _registerDeviceTokenRepository;

  const RegisterDeviceTokenUsecaseImpl({
    required RegisterDeviceTokenRepository registerDeviceTokenRepository,
  }) : _registerDeviceTokenRepository = registerDeviceTokenRepository;

  @override
  RegisterDeviceTokenCallback call({
    required String token,
  }) {
    return _registerDeviceTokenRepository.call(
      token: token,
    );
  }
}
