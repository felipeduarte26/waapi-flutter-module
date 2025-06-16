import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/retrieve_all_reasons_happiness_index_datasource.dart';
import '../../infra/models/happiness_index_group_model.dart';
import '../mappers/happiness_index_group_model_mapper.dart';

class RetrieveAllReasonsHappinessIndexDatasourceImpl implements RetrieveAllReasonsHappinessIndexDatasource {
  final RestService _restService;
  final HappinessIndexGroupModelMapper _groupModelMapper;

  const RetrieveAllReasonsHappinessIndexDatasourceImpl({
    required RestService restService,
    required HappinessIndexGroupModelMapper groupModelMapper,
  })  : _restService = restService,
        _groupModelMapper = groupModelMapper;

  @override
  Future<List<HappinessIndexGroupModel>> call({
    required String language,
  }) async {
    final allReasons = await _restService.happinessIndexService().get(
      '/queries/retrieveAllReasons',
      queryParameters: {
        'language': language,
      },
    );

    return _groupModelMapper.fromJsonList(
      groupJson: allReasons.data!,
    );
  }
}
