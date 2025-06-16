import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/active_tenant_modules_datasource.dart';
import '../mappers/active_tenant_modules_model_mapper.dart';

class ActiveTenantModulesDatasourceImpl implements ActiveTenantModulesDatasource {
  final RestService _restService;
  final ActiveTenantModulesModelMapper _activeTenantModulesModelMapper;

  const ActiveTenantModulesDatasourceImpl({
    required RestService restService,
    required ActiveTenantModulesModelMapper activeTenantModulesModelMapper,
  })  : _restService = restService,
        _activeTenantModulesModelMapper = activeTenantModulesModelMapper;

  @override
  Future<bool> call() async {
    final userActiveTenantModules = await _restService.legacyManagementPanelService().get('/tenantmodule');

    return _activeTenantModulesModelMapper.fromJson(
      json: userActiveTenantModules.data!,
    );
  }
}
