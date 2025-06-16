import '../../../internal_storage/internal_storage_service.dart';
import '../../infra/drivers/get_clocking_configuration_driver.dart';

class GetClockingConfigurationDriverImpl implements GetClockingConfigurationDriver {
  final InternalStorageService _internalStorageService;

  const GetClockingConfigurationDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  bool? call({
    required String key,
  }) {
    return _internalStorageService.getBool(key);
  }
}
