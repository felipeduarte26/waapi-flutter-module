import '../repositories/get_social_profile_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetSocialProfileUsecase {
  GetSocialProfileUsecaseCallback call({
    required String permaname,
  });
}

class GetSocialProfileUsecaseImpl implements GetSocialProfileUsecase {
  final GetSocialProfileRepository _getSocialProfileRepository;

  const GetSocialProfileUsecaseImpl({
    required GetSocialProfileRepository getSocialProfileRepository,
  }) : _getSocialProfileRepository = getSocialProfileRepository;

  @override
  GetSocialProfileUsecaseCallback call({
    required String permaname,
  }) {
    return _getSocialProfileRepository.call(
      permaname: permaname,
    );
  }
}
