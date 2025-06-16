import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_sexual_orientation_datasource.dart';
import '../../infra/models/sexual_orientation_model.dart';
import '../mappers/sexual_orientation_mapper.dart';

class GetSexualOrientationDatasourceImpl implements GetSexualOrientationDatasource {
  final RestService _restService;
  final SexualOrientationModelMapper _sexualOrientationModelMapper;

  const GetSexualOrientationDatasourceImpl({
    required RestService restService,
    required SexualOrientationModelMapper sexualOrientationModelMapper,
  })  : _restService = restService,
        _sexualOrientationModelMapper = sexualOrientationModelMapper;

  @override
  Future<List<SexualOrientationModel>> call() async {
    final getSexualOrientationResult = await _restService.diversityService().get(
          '/entities/sexualOrientation',
        );

    return _sexualOrientationModelMapper.fromJsonList(
      sexualOrientationJson: getSexualOrientationResult.data ?? '{}',
    );
  }
}
