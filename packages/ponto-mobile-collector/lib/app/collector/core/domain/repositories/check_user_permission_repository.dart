import '../../domain/entities/user_permission_check_entity.dart';
import '../../domain/entities/user_permissions_entity.dart';
import '../enums/token_type.dart';

abstract class CheckUserPermissionRepository {
  Future<UserPermissionsEntity> call({
    required List<UserPermissionCheckEntity> userPermissionCheckEntity,
    TokenType? tokenType,
  });
}
