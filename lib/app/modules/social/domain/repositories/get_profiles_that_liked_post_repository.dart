import '../../../../core/pagination/pagination_requirements.dart';
import '../types/social_domain_types.dart';

abstract class GetProfilesThatLikedPostRepository {
  GetProfilesThatLikedPostUsecaseCallback call({
    required String postId,
    required PaginationRequirements paginationRequirements,
  });
}
