import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_disability_datasource.dart';
import '../../infra/models/disability_model.dart';
import '../mappers/disability_model_mapper.dart';

class GetDisabilityDatasourceImpl implements GetDisabilityDatasource {
  final RestService _restService;
  final DisabilityModelMapper _disabilityModelMapper;

  const GetDisabilityDatasourceImpl({
    required RestService restService,
    required DisabilityModelMapper disabilityModelMapper,
  })  : _restService = restService,
        _disabilityModelMapper = disabilityModelMapper;

  @override
  Future<List<DisabilityModel>> call() async {
    final getDisabilityResult = await _restService.legacyManagementPanelService().get(
          '/disability',
        );

    return _disabilityModelMapper.fromJsonList(
      disabilityJson: getDisabilityResult.data ?? '{}',
    );
  }
}
