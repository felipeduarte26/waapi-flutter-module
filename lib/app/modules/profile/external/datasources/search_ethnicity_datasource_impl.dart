import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/search_ethnicity_datasource.dart';
import '../../infra/models/ethnicity_model.dart';
import '../mappers/ethnicity_model_mapper.dart';

class SearchEthnicityDatasourceImpl implements SearchEthnicityDatasource {
  final RestService _restService;
  final EthnicityModelMapper _ethnicityModelMapper;

  const SearchEthnicityDatasourceImpl({
    required RestService restService,
    required EthnicityModelMapper ethnicityModelMapper,
  })  : _restService = restService,
        _ethnicityModelMapper = ethnicityModelMapper;

  @override
  Future<List<EthnicityModel>> call({
    required String ethnicity,
  }) async {
    final searchEthnicityResult = await _restService.legacyManagementPanelService().get(
      '/ethnicity/search',
      queryParameters: {
        'q': ethnicity,
      },
    );

    return _ethnicityModelMapper.fromJsonList(
      ethnicityJson: searchEthnicityResult.data ?? '{}',
    );
  }
}
