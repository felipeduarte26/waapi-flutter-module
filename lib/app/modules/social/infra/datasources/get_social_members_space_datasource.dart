import '../../../../core/pagination/pagination_requirements.dart';
import '../models/social_space_model.dart';

abstract class GetSocialMembersSpaceDatasource {
  Future<List<SocialSpaceModel>> call({
    required PaginationRequirements paginationRequirements,
  });
}
