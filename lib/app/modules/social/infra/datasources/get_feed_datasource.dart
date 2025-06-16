import '../../../../core/pagination/pagination_requirements.dart';
import '../models/social_feed_model.dart';

abstract class GetFeedDatasource {
  Future<SocialFeedModel> call({
    required String nextCursor,
    required PaginationRequirements paginationRequirements,
    required DateTime since,
    String? space,
    String? tag,
  });
}
