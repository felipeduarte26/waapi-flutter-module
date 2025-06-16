import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_diversity_datasource.dart';
import '../../infra/models/diversity_model.dart';
import '../mappers/diversity_model_mapper.dart';

class GetDiversityDatasourceImpl implements GetDiversityDatasource {
  final RestService _restService;
  final DiversityModelMapper _diversityModelMapper;

  const GetDiversityDatasourceImpl({
    required RestService restService,
    required DiversityModelMapper diversityModelMapper,
  })  : _restService = restService,
        _diversityModelMapper = diversityModelMapper;

  @override
  Future<DiversityModel?> call({
    required String personId,
  }) async {
    final diversityResult = await _restService.diversityService().get(
          "/entities/person?filter=domainEntityId='$personId'",
        );

    return _diversityModelMapper.fromJsonList(
      diversityJson: diversityResult.data!,
    );
  }
}
