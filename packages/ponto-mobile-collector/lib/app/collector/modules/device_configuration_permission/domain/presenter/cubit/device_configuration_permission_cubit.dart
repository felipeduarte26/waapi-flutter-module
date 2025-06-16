import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../../../../core/domain/services/permission/ipermission_service.dart';
import '../../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../../core/infra/utils/enum/device_permission_enum.dart';
import 'device_configuration_permission_state.dart';

class DeviceConfigurationPermissionCubit
    extends Cubit<DeviceConfigurationPermissionBaseState> {
  final IPermissionService _permissionService;
  final NfcManager _nfcManager;
  final GetExecutionModeUsecase _getExecutionModeUsecase;

  bool hasCameraPermission = false;
  bool hasStoragePermission = false;
  bool hasPhotosPermission = false;
  bool hasGPSPermission = false;
  bool hasNFCPermission = false;

  bool isMulti = false;

  DeviceConfigurationPermissionCubit({
    required IPermissionService permissionService,
    required NfcManager nfcManager,
    required GetExecutionModeUsecase getExecutionModeUsecase,
  })  : _permissionService = permissionService,
        _nfcManager = nfcManager,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        super(LoadingContentState());

  Future<void> initialize() async {
    isMulti = (await _getExecutionModeUsecase.call()).isMultiple();

    hasCameraPermission = await _permissionService.checkPermissionIsAuthorized(
      permission: DevicePermissionEnum.camera,
    );

    hasGPSPermission = await _permissionService.checkPermissionIsAuthorized(
      permission: DevicePermissionEnum.location,
    );

    hasNFCPermission = await _nfcManager.isAvailable();

    hasStoragePermission = await _permissionService.checkPermissionIsAuthorized(
      permission: DevicePermissionEnum.manageExternalStorage,
    );

    hasPhotosPermission = await _permissionService.checkPermissionIsAuthorized(
      permission: DevicePermissionEnum.photos,
    );

    emit(ReadContentState());
  }

  Future<void> openSystemAppSettings() async {
    await _permissionService.openSystemAppSettings();
  }
}
