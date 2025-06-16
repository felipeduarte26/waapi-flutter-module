import '../../../../core/helper/enum_helper.dart';
import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../domain/enums/onboarding_view_key_enum.dart';
import '../../infra/drivers/save_already_viewed_onboarding_driver.dart';

class SaveAlreadyViewedOnboardingDriverImpl implements SaveAlreadyViewedOnboardingDriver {
  final InternalStorageService _internalStorageService;

  const SaveAlreadyViewedOnboardingDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<bool> call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required bool visualized,
  }) {
    return _internalStorageService.setBool(
      EnumHelper<OnboardingViewKeyEnum>().enumToString(
        enumToParse: onboardingViewKeyEnum,
      ),
      value: visualized,
    );
  }
}
