import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_profile_datasource.dart';
import '../../infra/models/profile_model.dart';
import '../mappers/profile_model_mapper.dart';

class GetProfileDatasourceImpl implements GetProfileDatasource {
  final RestService _restService;
  final ProfileModelMapper _profileModelMapper;

  const GetProfileDatasourceImpl({
    required RestService restService,
    required ProfileModelMapper profileModelMapper,
  })  : _restService = restService,
        _profileModelMapper = profileModelMapper;

  @override
  Future<ProfileModel> call({
    required String employeeId,
  }) async {
    final profileJsonResult = await _restService.legacyManagementPanelService().get('/profile');

    return _profileModelMapper.fromJson(
      profileJson: profileJsonResult.data!,
      employeeId: employeeId,
    );
  }
}
