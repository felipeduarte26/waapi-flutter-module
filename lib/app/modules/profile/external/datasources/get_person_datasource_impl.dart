import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_person_datasource.dart';
import '../../infra/models/profile_person_model.dart';
import '../mappers/profile_person_model_mapper.dart';

class GetPersonDatasourceImpl implements GetPersonDatasource {
  final RestService _restService;
  final ProfilePersonModelMapper _personModelMapper;

  GetPersonDatasourceImpl({
    required RestService restService,
    required ProfilePersonModelMapper personModelMapper,
  })  : _restService = restService,
        _personModelMapper = personModelMapper;

  @override
  Future<ProfilePersonModel> call({
    required String personId,
  }) async {
    final personResult = await _restService.legacyManagementPanelService().get('/person/$personId');

    return _personModelMapper.fromJson(
      personJson: personResult.data!,
    );
  }
}
