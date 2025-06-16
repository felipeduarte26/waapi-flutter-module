import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/drivers/get_last_token_saved_driver.dart';

class GetLastTokenSavedDriverImpl implements GetLastTokenSavedDriver {
  final InternalStorageService _internalStorageService;

  const GetLastTokenSavedDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  String? call() {
    return _internalStorageService.getString('lastTokenSaved');
  }
}
