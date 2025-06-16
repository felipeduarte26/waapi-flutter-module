import '../../../../core/types/either.dart';
import '../../domain/enums/onboarding_view_key_enum.dart';
import '../../domain/failures/onboarding_failure.dart';
import '../../domain/repositories/save_already_viewed_onboarding_repository.dart';
import '../../domain/types/onboarding_domain_types.dart';
import '../drivers/save_already_viewed_onboarding_driver.dart';

class SaveAlreadyViewedOnboardingRepositoryImpl implements SaveAlreadyViewedOnboardingRepository {
  final SaveAlreadyViewedOnboardingDriver _saveAlreadyViewedOnboardingDriver;

  const SaveAlreadyViewedOnboardingRepositoryImpl({
    required SaveAlreadyViewedOnboardingDriver saveAlreadyViewedOnboardingDriver,
  }) : _saveAlreadyViewedOnboardingDriver = saveAlreadyViewedOnboardingDriver;

  @override
  SaveAlreadyViewedOnboardingUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required bool visualized,
  }) async {
    try {
      final isSaved = await _saveAlreadyViewedOnboardingDriver.call(
        onboardingViewKeyEnum: onboardingViewKeyEnum,
        visualized: visualized,
      );

      if (!isSaved) {
        return left(const OnboardingDriverFailure());
      }

      return right(unit);
    } catch (error) {
      return left(const OnboardingDriverFailure());
    }
  }
}
