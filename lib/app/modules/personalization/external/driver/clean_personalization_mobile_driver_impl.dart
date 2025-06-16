import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/driver/clean_personalization_mobile_driver.dart';

class CleanPersonalizationMobileDriverImpl extends CleanPersonalizationMobileDriver {
  final InternalStorageService _internalStorageService;

   CleanPersonalizationMobileDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
   Future<void> call() async {
    _internalStorageService.remove('usePersonalizationMobile');
    _internalStorageService.remove('primaryColor');
    _internalStorageService.remove('secondaryColor');
    _internalStorageService.remove('useGradientColor');
    _internalStorageService.remove('usePrimaryColorForPlatform');
  }
  
}
