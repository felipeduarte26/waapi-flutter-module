import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/search_person_by_term_repository.dart';
import '../types/search_person_domain_types.dart';

abstract class SearchPersonByTermUsecase {
  SearchPersonByTermUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  });
}

class SearchPersonByTermUsecaseImpl implements SearchPersonByTermUsecase {
  final SearchPersonByTermRepository _searchPersonByTermRepository;

  const SearchPersonByTermUsecaseImpl({
    required SearchPersonByTermRepository searchPersonByTermRepository,
  }) : _searchPersonByTermRepository = searchPersonByTermRepository;

  @override
  SearchPersonByTermUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    return _searchPersonByTermRepository.call(
      paginationRequirements: paginationRequirements,
    );
  }
}
