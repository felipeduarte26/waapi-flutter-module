import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_profiles_that_liked_post_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetProfilesThatLikedPostUsecase {
  GetProfilesThatLikedPostUsecaseCallback call({
    required String postId,
    required PaginationRequirements paginationRequirements,
  });
}


class GetProfilesThatLikedPostUsecaseImpl implements GetProfilesThatLikedPostUsecase {
  final GetProfilesThatLikedPostRepository _getProfilesThatLikedPostRepository;

  const GetProfilesThatLikedPostUsecaseImpl({
    required GetProfilesThatLikedPostRepository getProfilesThatLikedPostRepository,
  }) : _getProfilesThatLikedPostRepository = getProfilesThatLikedPostRepository;

  @override
  GetProfilesThatLikedPostUsecaseCallback call({
    required String postId,
    required PaginationRequirements paginationRequirements,
  }) async {
    return _getProfilesThatLikedPostRepository.call(
      postId: postId,
      paginationRequirements: paginationRequirements,
    );
  }
}
