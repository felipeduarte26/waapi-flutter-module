import '../repositories/search_naturality_repository.dart';
import '../types/profile_domain_types.dart';

abstract class SearchNaturalityUsecase {
  SearchNaturalityUsecaseCallback call({
    required String naturality,
  });
}

class SearchNaturalityUsecaseImpl implements SearchNaturalityUsecase {
  final SearchNaturalityRepository _searchNaturalityRepository;

  const SearchNaturalityUsecaseImpl({
    required SearchNaturalityRepository searchNaturalityRepository,
  }) : _searchNaturalityRepository = searchNaturalityRepository;

  @override
  SearchNaturalityUsecaseCallback call({
    required String naturality,
  }) {
    return _searchNaturalityRepository.call(
      naturality: naturality,
    );
  }
}
