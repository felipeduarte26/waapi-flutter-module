import 'package:mobile_authentication/mobile_authentication_service.dart';

import '../../domain/entities/user_permission_check_entity.dart';
import '../../domain/enums/token_type.dart';

abstract class CheckUserPermissionDatasource {
  Future<AuthorizationResponse> call({
    required List<UserPermissionCheckEntity> userPermissionCheckEntity,
    TokenType? tokenType,
  });
}
