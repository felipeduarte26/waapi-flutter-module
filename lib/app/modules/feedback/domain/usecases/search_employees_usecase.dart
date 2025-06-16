import '../repositories/search_employees_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class SearchEmployeesUsecase {
  SearchEmployeesUsecaseCallback call({
    required String search,
  });
}

class SearchEmployeesUsecaseImpl implements SearchEmployeesUsecase {
  final SearchEmployeesRepository _searchEmployeesRepository;

  const SearchEmployeesUsecaseImpl({
    required SearchEmployeesRepository searchEmployeesRepository,
  }) : _searchEmployeesRepository = searchEmployeesRepository;

  @override
  SearchEmployeesUsecaseCallback call({
    required String search,
  }) {
    return _searchEmployeesRepository.call(
      search: search,
    );
  }
}
