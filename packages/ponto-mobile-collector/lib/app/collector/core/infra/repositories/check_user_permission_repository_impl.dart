import 'package:mobile_authentication/mobile_authentication_service.dart';

import '../../domain/entities/user_permission_check_entity.dart';
import '../../domain/entities/user_permissions_entity.dart';
import '../../domain/enums/token_type.dart';
import '../../domain/repositories/check_user_permission_repository.dart';
import '../../domain/usecases/get_access_token_usecase.dart';
import '../adapters/user_permissions_entity_adapter.dart';
import '../datasources/check_user_permission_datasource.dart';

class CheckUserPermissionRepositoryImpl
    implements CheckUserPermissionRepository {
  final CheckUserPermissionDatasource _checkUserPermissionDatasource;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final UserPermissionsEntityAdapter _userPermissionsEntityAdapter;

  const CheckUserPermissionRepositoryImpl({
    required CheckUserPermissionDatasource checkUserPermissionDatasource,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required UserPermissionsEntityAdapter userPermissionsEntityAdapter,
  })  : _checkUserPermissionDatasource = checkUserPermissionDatasource,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _userPermissionsEntityAdapter = userPermissionsEntityAdapter;

  @override
  Future<UserPermissionsEntity> call({
    required List<UserPermissionCheckEntity> userPermissionCheckEntity,
    TokenType? tokenType,
  }) async {
    String? token;

    tokenType ??= TokenType.first;

    token = await _getAccessTokenUsecase.call(tokenType: tokenType);
    if (token == null) {
      return const UserPermissionsEntity(
        authorized: false,
        permissions: [],
      );
    }

    AuthorizationResponse authorizationResponse;
    try {
      authorizationResponse =
          await _checkUserPermissionDatasource.call(
        tokenType: tokenType,
        userPermissionCheckEntity: userPermissionCheckEntity,
      );
    } catch (e) {
      return const UserPermissionsEntity(
        authorized: false,
        permissions: [],
      );
    }

    UserPermissionsEntity userPermissionsEntityResponse =
        _userPermissionsEntityAdapter.fromModel(
      authorizationResponse: authorizationResponse,
    );

    return userPermissionsEntityResponse;
  }
}
