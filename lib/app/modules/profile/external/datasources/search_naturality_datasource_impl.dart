import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/search_naturality_datasource.dart';
import '../../infra/models/city_model.dart';
import '../mappers/naturality_search_model_mapper.dart';

class SearchNaturalityDatasourceImpl implements SearchNaturalityDatasource {
  final RestService _restService;
  final NaturalitySearchModelMapper _naturalitySearchModelMapper;

  const SearchNaturalityDatasourceImpl({
    required RestService restService,
    required NaturalitySearchModelMapper naturalitySearchModelMapper,
  })  : _restService = restService,
        _naturalitySearchModelMapper = naturalitySearchModelMapper;

  @override
  Future<List<CityModel>> call({
    required String naturality,
  }) async {
    final searchNaturalityResult = await _restService.legacyManagementPanelService().get(
      '/geography/city/search',
      queryParameters: {
        'q': naturality,
      },
    );

    return _naturalitySearchModelMapper.fromJsonList(
      naturalityJson: searchNaturalityResult.data ?? '{}',
    );
  }
}
