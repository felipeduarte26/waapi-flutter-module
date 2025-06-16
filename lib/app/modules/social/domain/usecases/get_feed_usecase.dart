import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_feed_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetFeedUsecase {
  GetFeedUsecaseCallback call({
    required String nextCursor,
    required PaginationRequirements paginationRequirements,
    required DateTime since,
    String? space,
    String? tag,
  });
}

class GetFeedUsecaseImpl implements GetFeedUsecase {
  final GetFeedRepository _getFeedRepository;

  const GetFeedUsecaseImpl({
    required GetFeedRepository getFeedRepository,
  }) : _getFeedRepository = getFeedRepository;

  @override
  GetFeedUsecaseCallback call({
    required String nextCursor,
    required PaginationRequirements paginationRequirements,
    required DateTime since,
    String? space,
    String? tag,
  }) async {
    return _getFeedRepository.call(
      nextCursor: nextCursor,
      paginationRequirements: paginationRequirements,
      since: since,
      space: space,
      tag: tag,
    );
  }
}
