import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/driver/save_personalization_mobile_driver.dart';
import '../../infra/models/personalization_mobile_model.dart';

class SavePersonalizationMobileDriverImpl implements SavePersonalizationMobileDriver {
  final InternalStorageService _internalStorageService;

  const SavePersonalizationMobileDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<void> call({
    required PersonalizationMobileModel? personalizationMobileModel,
  }) async {
    if (personalizationMobileModel == null) return;

    await _internalStorageService.setBool(
      'usePersonalizationMobile',
      value: personalizationMobileModel.usePersonalizationMobile ?? false,
    );
    await _internalStorageService.setString(
      'primaryColor',
      personalizationMobileModel.primaryColor ?? '',
    );
    await _internalStorageService.setString(
      'secondaryColor',
      personalizationMobileModel.secondaryColor ?? '',
    );
    await _internalStorageService.setBool(
      'useGradientColor',
      value: personalizationMobileModel.useGradientColor ?? false,
    );
    await _internalStorageService.setBool(
      'usePrimaryColorForPlatform',
      value: personalizationMobileModel.usePrimaryColorForPlatform ?? false,
    );
  }
}
