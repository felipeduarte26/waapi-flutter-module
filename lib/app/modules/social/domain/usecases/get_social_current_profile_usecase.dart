import '../repositories/get_social_current_profile_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetSocialCurrentProfileUsecase {
  GetSocialCurrentProfileUsecaseCallback call();
}

class GetSocialCurrentProfileUseCaseImpl implements GetSocialCurrentProfileUsecase {
  final GetSocialCurrentProfileRepository _getSocialCurrentProfileRepository;

  const GetSocialCurrentProfileUseCaseImpl({
    required GetSocialCurrentProfileRepository getSocialCurrentProfileRepository,
  }) : _getSocialCurrentProfileRepository = getSocialCurrentProfileRepository;

  @override
  GetSocialCurrentProfileUsecaseCallback call() async {
    return _getSocialCurrentProfileRepository.call();
  }
}
