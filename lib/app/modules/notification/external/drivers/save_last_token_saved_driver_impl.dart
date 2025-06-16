import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/drivers/save_last_token_saved_driver.dart';

class SaveLastTokenSavedDriverImpl implements SaveLastTokenSavedDriver {
  final InternalStorageService _internalStorageService;

  const SaveLastTokenSavedDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<void> call({
    required String? lastTokenSaved,
  }) async {
    if (lastTokenSaved == null) {
      await _internalStorageService.remove('lastTokenSaved');
      return;
    }
    
    await _internalStorageService.setString(
      'lastTokenSaved',
      lastTokenSaved,
    );
  }
}
