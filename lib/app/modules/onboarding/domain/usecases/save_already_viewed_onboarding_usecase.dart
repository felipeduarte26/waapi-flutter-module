import '../enums/onboarding_view_key_enum.dart';
import '../repositories/save_already_viewed_onboarding_repository.dart';
import '../types/onboarding_domain_types.dart';

abstract class SaveAlreadyViewedOnboardingUsecase {
  SaveAlreadyViewedOnboardingUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required bool visualized,
  });
}

class SaveAlreadyViewedOnboardingUsecaseImpl implements SaveAlreadyViewedOnboardingUsecase {
  final SaveAlreadyViewedOnboardingRepository _saveAlreadyViewedOnboardingRepository;

  const SaveAlreadyViewedOnboardingUsecaseImpl({
    required SaveAlreadyViewedOnboardingRepository saveAlreadyViewedOnboardingRepository,
  }) : _saveAlreadyViewedOnboardingRepository = saveAlreadyViewedOnboardingRepository;

  @override
  SaveAlreadyViewedOnboardingUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required bool visualized,
  }) {
    return _saveAlreadyViewedOnboardingRepository.call(
      onboardingViewKeyEnum: onboardingViewKeyEnum,
      visualized: visualized,
    );
  }
}
