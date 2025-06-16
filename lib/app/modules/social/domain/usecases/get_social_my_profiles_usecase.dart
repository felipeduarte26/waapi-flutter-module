import '../repositories/get_social_my_profiles_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetSocialMyProfilesUsecase {
  GetSocialMyProfilesUsecaseCallback call();
}

class GetSocialMyProfilesUsecaseImpl implements GetSocialMyProfilesUsecase {
  final GetSocialMyProfilesRepository _getSocialMyProfilesRepository;

  const GetSocialMyProfilesUsecaseImpl({
    required GetSocialMyProfilesRepository getSocialMyProfilesRepository,
  }) : _getSocialMyProfilesRepository = getSocialMyProfilesRepository;

  @override
  GetSocialMyProfilesUsecaseCallback call() {
    return _getSocialMyProfilesRepository.call();
  }
}
