import '../repositories/get_device_token_repository.dart';
import '../types/notification_domain_types.dart';

abstract class GetDeviceTokenUsecase {
  GetDeviceTokenCallback call();
}

class GetDeviceTokenUsecaseImpl implements GetDeviceTokenUsecase {
  final GetDeviceTokenRepository _getDeviceTokenRepository;

  const GetDeviceTokenUsecaseImpl({
    required GetDeviceTokenRepository getDeviceTokenRepository,
  }) : _getDeviceTokenRepository = getDeviceTokenRepository;

  @override
  GetDeviceTokenCallback call() {
    return _getDeviceTokenRepository.call();
  }
}
