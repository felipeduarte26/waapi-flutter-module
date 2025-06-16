import '../repositories/open_native_app_settings_repository.dart';
import '../types/notification_domain_types.dart';

abstract class OpenNativeAppSettingsUsecase {
  OpenNativeAppSettingsCallback call();
}

class OpenNativeAppSettingsUsecaseImpl implements OpenNativeAppSettingsUsecase {
  final OpenNativeAppSettingsRepository _openNativeAppSettingsRepository;

  const OpenNativeAppSettingsUsecaseImpl({
    required OpenNativeAppSettingsRepository openNativeAppSettingsRepository,
  }) : _openNativeAppSettingsRepository = openNativeAppSettingsRepository;

  @override
  OpenNativeAppSettingsCallback call() {
    return _openNativeAppSettingsRepository.call();
  }
}
