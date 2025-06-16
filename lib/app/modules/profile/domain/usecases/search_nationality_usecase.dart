import '../repositories/search_nationality_repository.dart';
import '../types/profile_domain_types.dart';

abstract class SearchNationalityUsecase {
  SearchNationalityUsecaseCallback call({
    required String nationality,
  });
}

class SearchNationalityUsecaseImpl implements SearchNationalityUsecase {
  final SearchNationalityRepository _searchNationalityRepository;

  const SearchNationalityUsecaseImpl({
    required SearchNationalityRepository searchNationalityRepository,
  }) : _searchNationalityRepository = searchNationalityRepository;

  @override
  SearchNationalityUsecaseCallback call({
    required String nationality,
  }) {
    return _searchNationalityRepository.call(
      nationality: nationality,
    );
  }
}
