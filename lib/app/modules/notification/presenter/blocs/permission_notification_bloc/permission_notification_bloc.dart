import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/failures/notification_failure.dart';
import '../../../domain/usecases/clear_device_token_usecase.dart';
import '../../../domain/usecases/get_device_token_usecase.dart';
import '../../../domain/usecases/get_native_permission_notification_usecase.dart';
import '../../../domain/usecases/open_native_app_settings_usecase.dart';
import '../../../domain/usecases/register_device_token_usecase.dart';
import '../../../domain/usecases/save_native_permission_notification_usecase.dart';
import '../../../enums/notification_permission_status_enum.dart';
import 'permission_notification_event.dart';
import 'permission_notification_state.dart';

class PermissionNotificationBloc extends Bloc<PermissionNotificationEvent, PermissionNotificationState> {
  final GetNativePermissionNotificationUsecase _getNativePermissionNotificationUsecase;
  final SaveNativePermissionNotificationUsecase _saveNativePermissionNotificationUsecase;
  final ClearDeviceTokenUsecase _clearDeviceTokenUsecase;
  final RegisterDeviceTokenUsecase _registerDeviceTokenUsecase;
  final GetDeviceTokenUsecase _getDeviceTokenUsecase;
  final OpenNativeAppSettingsUsecase _openNativeAppSettingsUsecase;

  PermissionNotificationBloc({
    required GetNativePermissionNotificationUsecase getNativePermissionNotificationUsecase,
    required SaveNativePermissionNotificationUsecase saveNativePermissionNotificationUsecase,
    required ClearDeviceTokenUsecase clearDeviceTokenUsecase,
    required RegisterDeviceTokenUsecase registerDeviceTokenUsecase,
    required GetDeviceTokenUsecase getDeviceTokenUsecase,
    required OpenNativeAppSettingsUsecase openNativeAppSettingsUsecase,
  })  : _getNativePermissionNotificationUsecase = getNativePermissionNotificationUsecase,
        _saveNativePermissionNotificationUsecase = saveNativePermissionNotificationUsecase,
        _clearDeviceTokenUsecase = clearDeviceTokenUsecase,
        _registerDeviceTokenUsecase = registerDeviceTokenUsecase,
        _getDeviceTokenUsecase = getDeviceTokenUsecase,
        _openNativeAppSettingsUsecase = openNativeAppSettingsUsecase,
        super(InitialPermissionNotificationState()) {
    on<RequestPermissionNotificationEvent>(_requestPermissionNotificationEvent);
    on<SaveNativePermissionNotificationEvent>(_saveNativePermissionNotificationEvent);
    on<ClearTokenPermissionNotificationEvent>(_clearTokenPermissionNotificationEvent);
    on<RegisterTokenPermissionNotificationEvent>(_registerTokenPermissionNotificationEvent);
    on<OpenNativeSettingsPermissionNotificationEvent>(_openNativeSettingsPermissionNotificationEvent);
    on<ClearAndSaveAndSignOutPermissionNotificationEvent>(_clearAndSaveAndSignOutPermissionNotificationEvent);
  }

  Future<void> _openNativeSettingsPermissionNotificationEvent(
    OpenNativeSettingsPermissionNotificationEvent _,
    Emitter<PermissionNotificationState> emit,
  ) async {
    final hasOpen = await _openNativeAppSettingsUsecase.call();

    if (hasOpen.isLeft) {
      emit(ErrorOpenSettingsPermissionNotificationState());
    }
  }

  Future<void> _requestPermissionNotificationEvent(
    RequestPermissionNotificationEvent _,
    Emitter<PermissionNotificationState> emit,
  ) async {
    emit(LoadingPermissionNotificationState());

    final permissionStatus = await _getNativePermissionNotificationUsecase.call();

    permissionStatus.fold(
      (left) {
        emit(ErrorPermissionNotificationState());
      },
      (right) {
        if (right == NotificationPermissionStatusEnum.notDetermined) {
          emit(NotDeterminedPermissionNotificationState());
        } else if (right == NotificationPermissionStatusEnum.authorized) {
          emit(AuthorizedPermissionNotificationState());
        } else if (right == NotificationPermissionStatusEnum.forceRequest) {
          emit(ForceRequestPermissionNotificationState());
        } else {
          emit(DeniedPermissionNotificationState());
        }
      },
    );
  }

  Future<void> _saveNativePermissionNotificationEvent(
    SaveNativePermissionNotificationEvent event,
    Emitter<PermissionNotificationState> emit,
  ) async {
    emit(LoadingPermissionNotificationState());

    final isSaved = await _saveNativePermissionNotificationUsecase.call(
      notificationPermissionStatus: event.notificationPermissionStatus,
    );

    isSaved.fold(
      (left) {
        emit(ErrorPermissionNotificationState());
      },
      (right) {
        emit(SavedNativePermissionNotificationState());
      },
    );
  }

  Future<void> _clearTokenPermissionNotificationEvent(
    ClearTokenPermissionNotificationEvent _,
    Emitter<PermissionNotificationState> emit,
  ) async {
    emit(LoadingPermissionNotificationState());

    final isCleared = await _clearDeviceTokenUsecase.call();

    isCleared.fold(
      (left) {
        emit(ErrorOnClearTokenNotificationState());
      },
      (right) {
        emit(ClearedTokenPermissionNotificationState());
      },
    );
  }

  Future<void> _registerTokenPermissionNotificationEvent(
    RegisterTokenPermissionNotificationEvent _,
    Emitter<PermissionNotificationState> emit,
  ) async {
    emit(LoadingPermissionNotificationState());

    final requestToken = await _getDeviceTokenUsecase.call();

    String? token;

    requestToken.fold(
      (left) {
        if (left is NotificationFirebaseFailure) {
          emit(ErrorFirebaseGetTokenNotificationState());
          return;
        }

        emit(ErrorPermissionNotificationState());
      },
      (right) {
        token = right;
      },
    );

    if (requestToken.isLeft) {
      return;
    }

    final isRegistered = await _registerDeviceTokenUsecase.call(
      token: token!,
    );

    isRegistered.fold(
      (left) {
        emit(ErrorPermissionNotificationState());
      },
      (right) {
        emit(SucceedPermissionNotificationState());
      },
    );
  }

  Future<void> _clearAndSaveAndSignOutPermissionNotificationEvent(
    ClearAndSaveAndSignOutPermissionNotificationEvent _,
    Emitter<PermissionNotificationState> emit,
  ) async {
    emit(LoadingPermissionNotificationState());

    final isCleared = await _clearDeviceTokenUsecase.call();

    final isSaved = await _saveNativePermissionNotificationUsecase.call(
      notificationPermissionStatus: NotificationPermissionStatusEnum.notDetermined,
    );

    isCleared.fold(
      (left) {
        emit(ErrorOnClearTokenNotificationState());
      },
      (right) {
        isSaved.fold(
          (left) {
            emit(ErrorOnClearTokenNotificationState());
          },
          (right) {
            emit(ClearedAndSavedAndSignOutNotificationState());
          },
        );
      },
    );
  }
}
