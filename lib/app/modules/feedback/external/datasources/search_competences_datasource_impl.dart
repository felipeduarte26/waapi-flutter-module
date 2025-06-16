import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/search_competences_datasource.dart';
import '../../infra/models/skill_feedback_model.dart';
import '../mappers/skill_feedback_model_mapper.dart';

class SearchCompetencesDatasourceImpl implements SearchCompetencesDatasource {
  final RestService _restService;
  final SkillFeedbackModelMapper _skillFeedbackModelMapper;

  const SearchCompetencesDatasourceImpl({
    required RestService restService,
    required SkillFeedbackModelMapper skillFeedbackModelMapper,
  })  : _restService = restService,
        _skillFeedbackModelMapper = skillFeedbackModelMapper;

  @override
  Future<List<SkillFeedbackModel>> call({
    required String competency,
  }) async {
    final searchCompetencesResult = await _restService.legacyManagementPanelService().get(
      '/competency/search/company',
      queryParameters: {
        'q': competency,
      },
    );

    return _skillFeedbackModelMapper.fromJsonList(
      skillsJson: searchCompetencesResult.data ?? '{}',
    );
  }
}
