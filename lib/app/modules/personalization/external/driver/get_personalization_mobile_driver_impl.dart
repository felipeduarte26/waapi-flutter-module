import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/driver/get_personalization_mobile_driver.dart';
import '../../infra/models/personalization_mobile_model.dart';

class GetPersonalizationMobileDriverImpl implements GetPersonalizationMobileDriver {
  final InternalStorageService _internalStorageService;

  const GetPersonalizationMobileDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  PersonalizationMobileModel? call() {
    final usePersonalizationMobile = _internalStorageService.getBool(
      'usePersonalizationMobile',
    );
    final primaryColor = _internalStorageService.getString(
      'primaryColor',
    );
    final secondaryColor = _internalStorageService.getString(
      'secondaryColor',
    );
    final useGradientColor = _internalStorageService.getBool(
      'useGradientColor',
    );
    final usePrimaryColorForPlatform = _internalStorageService.getBool(
      'usePrimaryColorForPlatform',
    );

    return PersonalizationMobileModel(
      usePersonalizationMobile: usePersonalizationMobile,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      useGradientColor: useGradientColor,
      usePrimaryColorForPlatform: usePrimaryColorForPlatform,
    );
  }
}
