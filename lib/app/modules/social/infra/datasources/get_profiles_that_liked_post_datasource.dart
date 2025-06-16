import '../../../../core/pagination/pagination_requirements.dart';
import '../models/social_profile_model.dart';

abstract class GetProfilesThatLikedPostDatasource {
  Future<List<SocialProfileModel>> call({
    required String postId,
    required PaginationRequirements paginationRequirements,
  });
}
