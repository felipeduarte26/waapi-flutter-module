import '../../../../core/pagination/pagination_requirements.dart';
import '../models/social_post_model.dart';

abstract class GetProfilePostsDatasource {
  Future<List<SocialPostModel>> call({
    required PaginationRequirements paginationRequirements,
    required String permaname,
    String? lastSeenId,
  });
}
