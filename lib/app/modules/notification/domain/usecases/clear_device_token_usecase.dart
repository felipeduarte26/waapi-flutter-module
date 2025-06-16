import '../repositories/clear_device_token_repository.dart';
import '../types/notification_domain_types.dart';

abstract class ClearDeviceTokenUsecase {
  ClearDeviceTokenCallback call();
}

class ClearDeviceTokenUsecaseImpl implements ClearDeviceTokenUsecase {
  final ClearDeviceTokenRepository _clearDeviceTokenRepository;

  const ClearDeviceTokenUsecaseImpl({
    required ClearDeviceTokenRepository clearDeviceTokenRepository,
  }) : _clearDeviceTokenRepository = clearDeviceTokenRepository;

  @override
  ClearDeviceTokenCallback call() {
    return _clearDeviceTokenRepository.call();
  }
}
