import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_gender_identity_datasource.dart';
import '../../infra/models/gender_identity_model.dart';
import '../mappers/gender_identity_mapper.dart';

class GetGenderIdentityDatasourceImpl implements GetGenderIdentityDatasource {
  final RestService _restService;
  final GenderIdentityModelMapper _genderIdentityModelMapper;

  const GetGenderIdentityDatasourceImpl({
    required RestService restService,
    required GenderIdentityModelMapper genderIdentityModelMapper,
  })  : _restService = restService,
        _genderIdentityModelMapper = genderIdentityModelMapper;

  @override
  Future<List<GenderIdentityModel>> call() async {
    final getGenderIdentityResult = await _restService.diversityService().get(
          '/entities/genderIdentity',
        );

    return _genderIdentityModelMapper.fromJsonList(
      genderIdentityJson: getGenderIdentityResult.data ?? '{}',
    );
  }
}
