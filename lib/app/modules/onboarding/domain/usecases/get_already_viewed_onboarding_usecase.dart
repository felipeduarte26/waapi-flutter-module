import '../enums/onboarding_view_key_enum.dart';
import '../repositories/get_already_viewed_onboarding_repository.dart';
import '../types/onboarding_domain_types.dart';

abstract class GetAlreadyViewedOnboardingUsecase {
  GetAlreadyViewedOnboardingUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
  });
}

class GetAlreadyViewedOnboardingUsecaseImpl implements GetAlreadyViewedOnboardingUsecase {
  final GetAlreadyViewedOnboardingRepository _getAlreadyViewedOnboardingRepository;

  const GetAlreadyViewedOnboardingUsecaseImpl({
    required GetAlreadyViewedOnboardingRepository getAlreadyViewedOnboardingRepository,
  }) : _getAlreadyViewedOnboardingRepository = getAlreadyViewedOnboardingRepository;

  @override
  GetAlreadyViewedOnboardingUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
  }) {
    return _getAlreadyViewedOnboardingRepository.call(
      onboardingViewKeyEnum: onboardingViewKeyEnum,
    );
  }
}
