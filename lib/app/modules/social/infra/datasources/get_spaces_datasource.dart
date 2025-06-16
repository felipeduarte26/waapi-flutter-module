import '../../../../core/pagination/pagination_requirements.dart';
import '../models/social_space_model.dart';

abstract class GetSpacesDatasource {
  Future<List<SocialSpaceModel>> call({
    required PaginationRequirements paginationRequirements,
  });
}
