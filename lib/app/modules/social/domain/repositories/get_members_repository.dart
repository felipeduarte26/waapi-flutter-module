import '../../../../core/pagination/pagination_requirements.dart';
import '../types/social_domain_types.dart';

abstract class GetMembersRepository {
  GetMembersUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  });
}
