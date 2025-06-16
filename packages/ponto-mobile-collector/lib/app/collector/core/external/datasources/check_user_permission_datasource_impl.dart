import 'package:mobile_authentication/mobile_authentication_service.dart';

import '../../domain/entities/user_permission_check_entity.dart';
import '../../domain/enums/token_type.dart';
import '../../domain/services/environment/ienvironment_service.dart';
import '../../infra/datasources/check_user_permission_datasource.dart';
import '../../infra/utils/enum/environment_enum.dart';

class CheckUserPermissionDatasourceImpl
    implements CheckUserPermissionDatasource {
  final IEnvironmentService _environmentService;
  final IMobileAuthenticationService _mobileAuthenticationService;

  const CheckUserPermissionDatasourceImpl({
    required IEnvironmentService environmentService,
    required IMobileAuthenticationService mobileAuthenticationService,
  })  : _environmentService = environmentService,
        _mobileAuthenticationService = mobileAuthenticationService;

  @override
  Future<AuthorizationResponse> call({
    required List<UserPermissionCheckEntity> userPermissionCheckEntity,
    TokenType? tokenType,
  }) async {
    List<AuthorizationParameter> permissions = [];
    for (UserPermissionCheckEntity element in userPermissionCheckEntity) {
      permissions.add(
        AuthorizationParameter(
          resource: element.resource,
          action: element.action,
        ),
      );
    }

    return await _mobileAuthenticationService.getAuthorization(
      AuthorizationPermissions(permissions: permissions),
      EnvironmentEnum.mapToAuth(_environmentService.environment()),
      tokenType: tokenType?.value,
    );
  }
}
