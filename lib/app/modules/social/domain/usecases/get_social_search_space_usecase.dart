import '../repositories/get_social_search_space_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetSocialSearchSpaceUsecase {
 GetSocialSearchSpaceUsecaseCallback call({
   required String query,
 });
}

class GetSocialSearchSpaceUsecaseImpl implements GetSocialSearchSpaceUsecase {
  final GetSocialSearchSpaceRepository _getSocialSearchSpaceRepository;

  const GetSocialSearchSpaceUsecaseImpl({
    required GetSocialSearchSpaceRepository socialSearchSpaceRepository,
  }) : _getSocialSearchSpaceRepository = socialSearchSpaceRepository;

  @override
  GetSocialSearchSpaceUsecaseCallback call({
    required String query,
  }) async {
    return _getSocialSearchSpaceRepository.call(
      query: query,
    );
  }
}
