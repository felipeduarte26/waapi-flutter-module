import '../../../../core/types/either.dart';
import '../../domain/failures/onboarding_failure.dart';
import '../../domain/repositories/open_external_url_repository.dart';
import '../../domain/types/onboarding_domain_types.dart';
import '../drivers/open_external_url_driver.dart';

class OpenExternalUrlRepositoryImpl implements OpenExternalUrlRepository {
  final OpenExternalUrlDriver _openExternalUrlDriver;

  const OpenExternalUrlRepositoryImpl({
    required OpenExternalUrlDriver openExternalUrlDriver,
  }) : _openExternalUrlDriver = openExternalUrlDriver;

  @override
  OpenExternalUrlUsecaseCallback call({
    required String externalUrl,
  }) async {
    try {
      final isOpen = await _openExternalUrlDriver.call(
        externalUrl: externalUrl,
      );

      if (!isOpen) {
        return left(const OnboardingDriverFailure());
      }

      return right(unit);
    } catch (error) {
      return left(const OnboardingDriverFailure());
    }
  }
}
