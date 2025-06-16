import '../../../../core/pagination/pagination_requirements.dart';
import '../types/social_domain_types.dart';

abstract class GetFeedRepository {
  GetFeedUsecaseCallback call({
    required String nextCursor,
    required PaginationRequirements paginationRequirements,
    required DateTime since,
    String? space,
    String? tag,
  });
}
