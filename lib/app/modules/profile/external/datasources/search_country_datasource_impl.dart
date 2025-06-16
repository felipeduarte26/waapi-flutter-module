import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/search_country_datasource.dart';
import '../../infra/models/country_model.dart';
import '../mappers/country_model_mapper.dart';

class SearchCountryDatasourceImpl implements SearchCountryDatasource {
  final RestService _restService;
  final CountryModelMapper _countrySearchModelMapper;

  const SearchCountryDatasourceImpl({
    required RestService restService,
    required CountryModelMapper countrySearchModelMapper,
  })  : _restService = restService,
        _countrySearchModelMapper = countrySearchModelMapper;

  @override
  Future<List<CountryModel>> call({
    required String country,
  }) async {
    final searchCountryResult = await _restService.legacyManagementPanelService().get(
      '/geography/country/search',
      queryParameters: {
        'q': country,
      },
    );

    return _countrySearchModelMapper.fromJsonList(
      countryJson: searchCountryResult.data ?? '{}',
    );
  }
}
