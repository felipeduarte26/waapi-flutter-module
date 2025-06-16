import '../../../../core/pagination/pagination_requirements.dart';
import '../types/social_domain_types.dart';

abstract class GetSocialMemberSpacesRepository {
  GetSocialMemberSpacesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  });
}
