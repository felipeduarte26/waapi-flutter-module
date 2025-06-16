import '../repositories/search_country_repository.dart';
import '../types/profile_domain_types.dart';

abstract class SearchCountryUsecase {
  SearchCountryUsecaseCallback call({
    required String country,
  });
}

class SearchCountryUsecaseImpl implements SearchCountryUsecase {
  final SearchCountryRepository _searchCountryRepository;

  const SearchCountryUsecaseImpl({
    required SearchCountryRepository searchCountryRepository,
  }) : _searchCountryRepository = searchCountryRepository;

  @override
  SearchCountryUsecaseCallback call({
    required String country,
  }) {
    return _searchCountryRepository.call(
      country: country,
    );
  }
}
