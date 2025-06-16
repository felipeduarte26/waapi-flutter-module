import '../../../../core/pagination/pagination_requirements.dart';
import '../models/social_profile_model.dart';

abstract class GetMembersDatasource {
  Future<List<SocialProfileModel>> call({
    required PaginationRequirements paginationRequirements,
  });
}
