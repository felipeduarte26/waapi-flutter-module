import '../../../../core/pagination/pagination_requirements.dart';
import '../types/social_domain_types.dart';

abstract class GetProfilePostsRepository {
  GetProfilePostsUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required String permaname,
    String? lastSeenId,
  });
}
