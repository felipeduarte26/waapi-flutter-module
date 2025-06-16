import '../../../../core/pagination/pagination_requirements.dart';
import '../types/social_domain_types.dart';

abstract class GetSpacesRepository {
  GetSpacesUsecaseCallback call({required PaginationRequirements paginationRequirements});
}
