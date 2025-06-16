import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_feed_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_feed_entity_adapter.dart';
import '../datasources/get_feed_datasource.dart';

class GetFeedRepositoryImpl implements GetFeedRepository {
  final GetFeedDatasource _getFeedDatasource;
 
  final SocialFeedEntityAdapter _feedEntityAdapter;

  const GetFeedRepositoryImpl({
    required GetFeedDatasource getFeedDatasource,
    
    required SocialFeedEntityAdapter feedEntityAdapter,
  })  : _getFeedDatasource = getFeedDatasource,
        
        _feedEntityAdapter = feedEntityAdapter;

  @override
  GetFeedUsecaseCallback call({
    required String nextCursor,
    required PaginationRequirements paginationRequirements,
    required DateTime since,
    String? space,
    String? tag,
  }) async {
    try {
      final feedModel = await _getFeedDatasource.call(
        nextCursor: nextCursor,
        paginationRequirements: paginationRequirements,
        since: since,
        space: space,
        tag: tag,
      );

      final feedEntity = _feedEntityAdapter.fromModel(
        feedModel: feedModel,
      );

      return right(feedEntity);
    } catch (error) {


      return left(SocialDatasourceFailure());
    }
  }
}
