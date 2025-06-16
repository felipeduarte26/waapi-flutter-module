import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/drivers/get_waapi_lite_driver.dart';

class GetWaapiLiteDriverImpl implements GetWaapiLiteDriver {
  final InternalStorageService _internalStorageService;

  const GetWaapiLiteDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  bool? call() {
    return (_internalStorageService.getBool('isWaapiLite') ?? false);
  }
}
