import '../repositories/search_competences_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class SearchCompetencesUsecase {
  SearchCompetencesUsecaseCallback call({
    required String competency,
  });
}

class SearchCompetencesUsecaseImpl implements SearchCompetencesUsecase {
  final SearchCompetencesRepository _searchCompetencesRepository;

  const SearchCompetencesUsecaseImpl({
    required SearchCompetencesRepository searchCompetencesRepository,
  }) : _searchCompetencesRepository = searchCompetencesRepository;

  @override
  SearchCompetencesUsecaseCallback call({
    required String competency,
  }) {
    return _searchCompetencesRepository.call(
      competency: competency,
    );
  }
}
