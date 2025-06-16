import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/drivers/save_waapi_lite_driver.dart';

class SaveWaapiLiteDriverImpl implements SaveWaapiLiteDriver {
  final InternalStorageService _internalStorageService;

  const SaveWaapiLiteDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<void> call({
    required bool isWaapiLite,
  }) async {
    await _internalStorageService.setBool(
      'isWaapiLite',
      value: isWaapiLite,
    );
  }
}
