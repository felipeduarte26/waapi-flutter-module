import '../repositories/search_ethnicity_repository.dart';
import '../types/profile_domain_types.dart';

abstract class SearchEthnicityUsecase {
  SearchEthnicityUsecaseCallback call({
    required String ethnicity,
  });
}

class SearchEthnicityUsecaseImpl implements SearchEthnicityUsecase {
  final SearchEthnicityRepository _searchEthnicityRepository;

  const SearchEthnicityUsecaseImpl({
    required SearchEthnicityRepository searchEthnicityRepository,
  }) : _searchEthnicityRepository = searchEthnicityRepository;

  @override
  SearchEthnicityUsecaseCallback call({
    required String ethnicity,
  }) {
    return _searchEthnicityRepository.call(
      ethnicity: ethnicity,
    );
  }
}
