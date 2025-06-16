import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/search_nationality_datasource.dart';
import '../../infra/models/nationality_model.dart';
import '../mappers/nationality_search_model_mapper.dart';

class SearchNationalityDatasourceImpl implements SearchNationalityDatasource {
  final RestService _restService;
  final NationalitySearchModelMapper _nationalitySearchModelMapper;

  const SearchNationalityDatasourceImpl({
    required RestService restService,
    required NationalitySearchModelMapper nationalitySearchModelMapper,
  })  : _restService = restService,
        _nationalitySearchModelMapper = nationalitySearchModelMapper;

  @override
  Future<List<NationalityModel>> call({
    required String nationality,
  }) async {
    final searchNationalityResult = await _restService.legacyManagementPanelService().get(
      '/nationality/search',
      queryParameters: {
        'q': nationality,
      },
    );

    return _nationalitySearchModelMapper.fromJsonList(
      nationalityJson: searchNationalityResult.data ?? '{}',
    );
  }
}
