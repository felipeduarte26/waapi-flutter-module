import '../../../internal_storage/internal_storage_service.dart';
import '../../infra/drivers/save_has_clocking_driver.dart';

class SaveHasClockingDriverImpl implements SaveHasClockingDriver {
  final InternalStorageService _internalStorageService;

  const SaveHasClockingDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<void> call({
    required bool? hasClocking,
  }) async {
    if (hasClocking == null) {
      await _internalStorageService.remove('hasClocking');
      return;
    }

    await _internalStorageService.setBool(
      'hasClocking',
      value: hasClocking,
    );
  }
}
