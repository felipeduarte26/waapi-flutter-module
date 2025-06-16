import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_proficiency_list_datasource.dart';
import '../../infra/models/proficiency_feedback_model.dart';
import '../mappers/proficiency_feedback_model_mapper.dart';

class GetProficiencyListDatasourceImpl implements GetProficiencyListDatasource {
  final RestService _restService;
  final ProficiencyFeedbackModelMapper _proficiencyModelMapper;

  const GetProficiencyListDatasourceImpl({
    required RestService restService,
    required ProficiencyFeedbackModelMapper proficiencyModelMapper,
  })  : _restService = restService,
        _proficiencyModelMapper = proficiencyModelMapper;

  @override
  Future<List<ProficiencyFeedbackModel>> call() async {
    final proficiencyResult = await _restService.legacyManagementPanelService().get(
          '/tenantsetting/feedbackproficiencytable/default',
        );

    return _proficiencyModelMapper.fromJsonList(
      proficienciesJson: proficiencyResult.data ?? '{}',
    );
  }
}
