import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/search_competences_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../adapters/skill_feedback_entity_adapter.dart';
import '../datasources/search_competences_datasource.dart';

class SearchCompetencesRepositoryImpl implements SearchCompetencesRepository {
  final SearchCompetencesDatasource _searchCompetencesDatasource;
  final SkillFeedbackEntityAdapter _skillFeedbackEntityAdapter;

  const SearchCompetencesRepositoryImpl({
    required SearchCompetencesDatasource searchCompetencesDatasource,
    required SkillFeedbackEntityAdapter skillFeedbackEntityAdapter,
  })  : _searchCompetencesDatasource = searchCompetencesDatasource,
        _skillFeedbackEntityAdapter = skillFeedbackEntityAdapter;

  @override
  SearchCompetencesUsecaseCallback call({
    required String competency,
  }) async {
    try {
      final searchCompetencesModelList = await _searchCompetencesDatasource.call(
        competency: competency,
      );

      final searchCompetencesEntityList = searchCompetencesModelList.map(
        (competencyModel) {
          return _skillFeedbackEntityAdapter.fromModel(
            skillFeedbackModel: competencyModel,
          );
        },
      ).toList();

      return right(searchCompetencesEntityList);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
