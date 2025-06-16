import '../../../../core/types/either.dart';
import '../../domain/enums/onboarding_view_key_enum.dart';
import '../../domain/failures/onboarding_failure.dart';
import '../../domain/repositories/get_already_viewed_onboarding_repository.dart';
import '../../domain/types/onboarding_domain_types.dart';
import '../drivers/get_already_viewed_onboarding_driver.dart';

class GetAlreadyViewedOnboardingRepositoryImpl implements GetAlreadyViewedOnboardingRepository {
  final GetAlreadyViewedOnboardingDriver _getAlreadyViewedOnboardingDriver;

  const GetAlreadyViewedOnboardingRepositoryImpl({
    required GetAlreadyViewedOnboardingDriver getAlreadyViewedOnboardingDriver,
  }) : _getAlreadyViewedOnboardingDriver = getAlreadyViewedOnboardingDriver;

  @override
  GetAlreadyViewedOnboardingUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
  }) async {
    try {
      final isSaved = _getAlreadyViewedOnboardingDriver.call(
        onboardingViewKeyEnum: onboardingViewKeyEnum,
      );

      return right(isSaved);
    } catch (error) {
      return left(const OnboardingDriverFailure());
    }
  }
}
