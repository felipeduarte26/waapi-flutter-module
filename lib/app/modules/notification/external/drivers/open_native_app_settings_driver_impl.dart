import '../../../../core/services/native_settings/native_settings_service.dart';
import '../../infra/drivers/open_native_app_settings_driver.dart';

class OpenNativeAppSettingsDriverImpl implements OpenNativeAppSettingsDriver {
  final NativeSettingsService _nativeSettingsService;

  const OpenNativeAppSettingsDriverImpl({
    required NativeSettingsService nativeSettingsService,
  }) : _nativeSettingsService = nativeSettingsService;

  @override
  Future<bool> call() {
    return _nativeSettingsService.openNativeSettings();
  }
}
