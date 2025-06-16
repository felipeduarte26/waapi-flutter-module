import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/legacy_authorizations_datasource.dart';
import '../mappers/legacy_authorization_model_mapper.dart';
import '../types/authorization_external_types.dart';

class LegacyAuthorizationsDatasourceImpl implements LegacyAuthorizationsDatasource {
  final RestService _restService;
  final LegacyAuthorizationModelMapper _legacyAuthorizationModelMapper;

  const LegacyAuthorizationsDatasourceImpl({
    required RestService restService,
    required LegacyAuthorizationModelMapper legacyAuthorizationModelMapper,
  })  : _restService = restService,
        _legacyAuthorizationModelMapper = legacyAuthorizationModelMapper;

  @override
  GetUserLegacyAuthorizationsDatasourceCallback call() async {
    final userLegacyAuthorizations = await _restService.legacyManagementPanelService().get('/tenantsetting');

    return _legacyAuthorizationModelMapper.fromJson(
      json: userLegacyAuthorizations.data!,
    );
  }
}
