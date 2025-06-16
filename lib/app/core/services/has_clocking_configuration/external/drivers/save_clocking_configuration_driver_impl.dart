import '../../../internal_storage/internal_storage_service.dart';
import '../../infra/drivers/save_clocking_configuration_driver.dart';

class SaveClockingConfigurationDriverImpl implements SaveClockingConfigurationDriver {
  final InternalStorageService _internalStorageService;

  const SaveClockingConfigurationDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<void> call({
    required bool? allowGpoOnApp,
    required String key,
  }) async {
    if (allowGpoOnApp == null) {
      await _internalStorageService.remove(key);
      return;
    }

    await _internalStorageService.setBool(
      key,
      value: allowGpoOnApp,
    );
  }
}
