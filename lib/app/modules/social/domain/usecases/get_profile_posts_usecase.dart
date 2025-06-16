import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_profile_posts_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetProfilePostsUsecase {
  GetProfilePostsUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required String permaname,
    String? lastSeenId,
  });
}

class GetProfilePostsUsecaseImpl implements GetProfilePostsUsecase {
  final GetProfilePostsRepository _getProfilePostsRepository;

  const GetProfilePostsUsecaseImpl({
    required GetProfilePostsRepository getProfilePostsRepository,
  }) : _getProfilePostsRepository = getProfilePostsRepository;

  @override
  GetProfilePostsUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required String permaname,
    String? lastSeenId,
  }) async {
    return _getProfilePostsRepository.call(
      paginationRequirements: paginationRequirements,
      permaname: permaname,
      lastSeenId: lastSeenId,
    );
  }
}
