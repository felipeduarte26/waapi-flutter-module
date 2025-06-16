import '../../../internal_storage/internal_storage_service.dart';
import '../../infra/drivers/get_has_clocking_driver.dart';

class GetHasClockingDriverImpl implements GetHasClockingDriver {
  final InternalStorageService _internalStorageService;

  const GetHasClockingDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  bool? call() {
    return _internalStorageService.getBool('hasClocking');
  }
}
