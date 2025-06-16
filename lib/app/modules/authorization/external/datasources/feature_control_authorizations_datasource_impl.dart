import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/feature_control_authorizations_datasource.dart';
import '../../infra/models/feature_control_authorization_model.dart';
import '../mappers/feature_control_authorizations_model_mapper.dart';

class FeatureControlAuthorizationsDatasourceImpl implements FeatureControlAuthorizationsDatasource {
  final RestService _restService;
  final FeatureControlAuthorizationsModelMapper _featureControlAuthorizationsModelMapper;

  const FeatureControlAuthorizationsDatasourceImpl({
    required RestService restService,
    required FeatureControlAuthorizationsModelMapper featureControlAuthorizationsModelMapper,
  })  : _restService = restService,
        _featureControlAuthorizationsModelMapper = featureControlAuthorizationsModelMapper;

  @override
  Future<FeatureControlAuthorizationModel> call() async {
    final userFeatureControlAuthorizations = await _restService.legacyManagementPanelService().get('/featurecontrol');

    return _featureControlAuthorizationsModelMapper.fromJson(
      json: userFeatureControlAuthorizations.data!,
    );
  }
}
