import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_administrative_region_datasource.dart';
import '../../infra/models/administrative_region_model.dart';
import '../mappers/administrative_region_model_mapper.dart';

class GetAdministrativeRegionDatasourceImpl implements GetAdministrativeRegionDatasource {
  final RestService _restService;
  final AdministrativeRegionModelMapper _administrativeRegionModelMapper;

  const GetAdministrativeRegionDatasourceImpl({
    required RestService restService,
    required AdministrativeRegionModelMapper administrativeRegionModelMapper,
  })  : _restService = restService,
        _administrativeRegionModelMapper = administrativeRegionModelMapper;

  @override
  Future<List<AdministrativeRegionModel>> call({
    required String cityId,
  }) async {
    final administrativeRegionResponse =
        await _restService.legacyManagementPanelService().get('/administrativeregion?city=$cityId');

    return _administrativeRegionModelMapper.fromJson(
      administrativeRegionJson: administrativeRegionResponse.data!,
    );
  }
}
