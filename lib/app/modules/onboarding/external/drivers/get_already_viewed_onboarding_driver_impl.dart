import '../../../../core/helper/enum_helper.dart';
import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../domain/enums/onboarding_view_key_enum.dart';
import '../../infra/drivers/get_already_viewed_onboarding_driver.dart';

class GetAlreadyViewedOnboardingDriverImpl implements GetAlreadyViewedOnboardingDriver {
  final InternalStorageService _internalStorageService;

  const GetAlreadyViewedOnboardingDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  bool call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
  }) {
    return _internalStorageService.getBool(
          EnumHelper<OnboardingViewKeyEnum>().enumToString(
            enumToParse: onboardingViewKeyEnum,
          ),
        ) ??
        false;
  }
}
