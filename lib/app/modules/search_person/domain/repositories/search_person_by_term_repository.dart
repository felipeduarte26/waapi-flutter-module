import '../../../../core/pagination/pagination_requirements.dart';
import '../types/search_person_domain_types.dart';

abstract class SearchPersonByTermRepository {
  SearchPersonByTermUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  });
}
