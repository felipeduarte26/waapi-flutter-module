import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_public_profile_datasource.dart';
import '../../infra/models/public_profile_model.dart';
import '../mappers/public_profile_model_mapper.dart';

class GetPublicProfileDatasourceImpl implements GetPublicProfileDatasource {
  final RestService _restService;
  final PublicProfileModelMapper _publicProfileModelMapper;

  const GetPublicProfileDatasourceImpl({
    required RestService restService,
    required PublicProfileModelMapper publicProfileModelMapper,
  })  : _restService = restService,
        _publicProfileModelMapper = publicProfileModelMapper;

  @override
  Future<PublicProfileModel> call({
    required String userName,
  }) async {
    final getProfilePicturePath = '/profile/$userName/public';
    final publicProfileResponse = await _restService.legacyManagementPanelService().get(getProfilePicturePath);

    return _publicProfileModelMapper.fromJson(
      publicProfileJson: publicProfileResponse.data!,
    );
  }
}
