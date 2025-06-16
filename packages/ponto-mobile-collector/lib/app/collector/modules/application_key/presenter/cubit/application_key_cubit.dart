import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/entities/user_permission_check_entity.dart';
import '../../../../core/domain/usecases/check_conection_usecase.dart';
import '../../../../core/domain/usecases/check_user_permission_usecase.dart';
import '../../../../core/domain/usecases/deauthenticate_user_usecase.dart';
import '../../../../core/domain/usecases/get_access_token_usecase.dart';
import '../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../core/domain/usecases/remove_application_key_usecase.dart';
import '../../../../core/infra/utils/enum/execution_mode_enum.dart';
import '../../../../core/infra/utils/enum/user_action_enum.dart';
import '../../../../core/infra/utils/enum/user_resource_enum.dart';
import 'application_key_state.dart';

class ApplicationKeyCubit extends Cubit<ApplicationKeyBaseState> {
  final GetTokenUsecase _getTokenUsecase;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final CheckUserPermissionUsecase _checkUserPermissionUsecase;
  final IUtils _utils;
  final ISharedPreferencesService _sharedPreferencesService;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final IClockingEventRepository _clockingEventRepository;
  final IHasConnectivityUsecase _hasConnectivityUsecase;
  final RemoveApplicationKeyUsecase _removeApplicationKeyUsecase;
  final DeauthenticateUserUsecase _deauthenticateUserUsecase;

  bool hasLogin = false;

  //bool isDevMode = false;

  bool keyAlreadyRegistered = true;

  bool registeringNewKey = false;

  ExecutionModeEnum? initialExecutionMode;

  ApplicationKeyCubit({
    required GetTokenUsecase getTokenUsecase,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required CheckUserPermissionUsecase checkUserPermissionUsecase,
    required IUtils utils,
    required ISharedPreferencesService sharedPreferencesService,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required IClockingEventRepository clockingEventRepository,
    required IHasConnectivityUsecase hasConnectivityUsecase,
    required RemoveApplicationKeyUsecase removeApplicationKeyUsecase,
    required DeauthenticateUserUsecase deauthenticateUserUsecase,
  })  : _getTokenUsecase = getTokenUsecase,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _checkUserPermissionUsecase = checkUserPermissionUsecase,
        _utils = utils,
        _sharedPreferencesService = sharedPreferencesService,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _clockingEventRepository = clockingEventRepository,
        _hasConnectivityUsecase = hasConnectivityUsecase,
        _removeApplicationKeyUsecase = removeApplicationKeyUsecase,
        _deauthenticateUserUsecase = deauthenticateUserUsecase,
        super(LoadingUserIsAuthenticatedState());

  Future<void> loadContent() async {
    final hasConnectivity = await _hasConnectivityUsecase.call();

    if (!hasConnectivity) {
      emit(HasNoConnectivityState());
      return;
    }

    SeniorAuthentication.enableLoginWithKey = false;
    emit(LoadingUserIsAuthenticatedState());
    initialExecutionMode ??= await _getExecutionModeUsecase.call();
    Token? token = (await _getTokenUsecase.call(tokenType: TokenType.user));
    hasLogin = token != null;

    if (hasLogin) {
      bool userPermission = await validateApplicationKeyConfigurationPermission(
        tokenType: TokenType.user,
      );

      if (!userPermission) {
        emit(UserWithoutPermissionState());
        return;
      }

      final tokenKeyApplication =
          await _getAccessTokenUsecase.call(tokenType: TokenType.key);

      if (tokenKeyApplication == null) {
        SeniorAuthentication.enableLoginWithKey = true;
        emit(KeyNotRegisteredState());
      } else {
        SeniorAuthentication.enableLoginWithKey = false;
        if (!registeringNewKey) {
          emit(KeyAlreadyRegisteredState());
        }
        return;
      }
    }
  }

  Future<void> successfullyRegisteredKey() async {
    Token? token = (await _getTokenUsecase.call(tokenType: TokenType.user));

    if (token!.username != null && token.username!.isNotEmpty) {
      String tenantName =
          _utils.getTenantFromUsername(username: token.username!);
      await _sharedPreferencesService.setTenant(value: tenantName);
    }
    _sharedPreferencesService.setExecuteSyncAllInfoOnStartup(value: true);
    emit(KeyRegisteredSuccessfullyState());
  }
  
  void registerNewKey() async {
    keyAlreadyRegistered = false;
    registeringNewKey = true;
    SeniorAuthentication.enableLoginWithKey = true;
    // await _removeApplicationKeyUsecase.call();
    emit(RegisterNewKeyState());
  }

  void removeKeys() async {
    registeringNewKey = false;
    if (state is KeyAlreadyRegisteredState) {
      return emit(ConfirmRemoveKeysState());
    }

    if (state is ConfirmRemoveKeysState) {
      emit(VerifyingUnsycedClockingEventsState());

      final allUnsynced =
          await _clockingEventRepository.findAllUnsynced(limit: null);

      if (allUnsynced.isNotEmpty) {
        return emit(HasUnsyncedClockingEventsState());
      }

      emit(RemovingKeysState());

      try {
        await _removeApplicationKeyUsecase.call();

        emit(KeysRemovedState());
      } catch (_) {
        emit(RemoveKeyErrorState());

        cancelRemoveKeys();
      }
    }
  }

  void cancelRemoveKeys() {
    emit(KeyAlreadyRegisteredState());
  }

  Future<bool> validateApplicationKeyConfigurationPermission({
    TokenType? tokenType,
  }) async {
    if (tokenType == null) {
      return false;
    }

    var userPermissionEntity = UserPermissionCheckEntity(
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.applicationKeyConfig.resource,
    );

    var legacyQrCodePermissionEntity = UserPermissionCheckEntity(
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.qrcodeconfig.resource,
    );

    List<UserPermissionCheckEntity> userPermissionCheckEntity =
        List.empty(growable: true);
    userPermissionCheckEntity.add(userPermissionEntity);
    userPermissionCheckEntity.add(legacyQrCodePermissionEntity);

    var userPermissionsEntity = await _checkUserPermissionUsecase.call(
      userPermissionCheckEntity: userPermissionCheckEntity,
      tokenType: tokenType,
    );
    return userPermissionsEntity.anyPermissionAuthorized();
  }

  Future<void> logoffUser() async {
    await _deauthenticateUserUsecase.call();
  }
}
