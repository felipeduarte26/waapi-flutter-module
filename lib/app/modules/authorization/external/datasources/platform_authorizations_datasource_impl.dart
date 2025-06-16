import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/platform_authorizations_datasource.dart';
import '../mappers/platform_authorizations_aggregator_model_mapper.dart';
import '../types/authorization_external_types.dart';

class PlatformAuthorizationsDatasourceImpl implements PlatformAuthorizationsDatasource {
  final RestService _restService;
  final PlatformAuthorizationsAggregatorModelMapper _platformAuthorizationsAggregatorModelMapper;
  final Map<String, dynamic> _platformPermissions;

  const PlatformAuthorizationsDatasourceImpl({
    required RestService restService,
    required PlatformAuthorizationsAggregatorModelMapper platformAuthorizationsAggregatorModelMapper,
    required Map<String, dynamic> platformPermissions,
  })  : _restService = restService,
        _platformAuthorizationsAggregatorModelMapper = platformAuthorizationsAggregatorModelMapper,
        _platformPermissions = platformPermissions;

  @override
  GetUserPlatformAuthorizationsDatasourceCallback call() async {
    final userPlatformAuthorizations = await _restService.authorizationService().post(
          '/queries/checkAccess',
          body: _platformPermissions,
        );

    return _platformAuthorizationsAggregatorModelMapper.fromJson(
      json: userPlatformAuthorizations.data!,
    );
  }
}
