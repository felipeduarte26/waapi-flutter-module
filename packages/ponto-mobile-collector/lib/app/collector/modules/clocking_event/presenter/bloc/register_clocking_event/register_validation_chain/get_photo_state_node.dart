import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../../core/domain/usecases/check_need_facial_recognition_by_clocking_event_use_usecase.dart';
import '../../../../domain/usecase/take_photo_config_usecase.dart';
import 'register_validation_node.dart';

class GetPhotoStateNode extends RegisterValidationNode {
  final ITakePhotoConfigUsecase _takePhotoConfigUsecase;
  final ICheckNeedFacialRecognitionByClockingEventTypeUsecase
      _checkNeedFacialRecognitionByClockingEventTypeUsecase;
  final IPermissionService _permissionService;
  final NavigatorService _navigatorService;
  final CollectorCameraCubit _collectorCameraCubit;
  final Widget _cameraWidget;
  final LogService _logService;

  late RegisterClockingEventBloc _registerClockingEventBloc;

  @visibleForTesting
  bool get isUnitTesting => Platform.environment.containsKey('FLUTTER_TEST');

  GetPhotoStateNode({
    required ITakePhotoConfigUsecase takePhotoConfigUsecase,
    required ICheckNeedFacialRecognitionByClockingEventTypeUsecase
        checkNeedFacialRecognitionByClockingEventTypeUsecase,
    required IPermissionService permissionService,
    required NavigatorService navigatorService,
    required CollectorCameraCubit collectorCameraCubit,
    required Widget cameraWidget,
    required LogService logService,
  })  : _takePhotoConfigUsecase = takePhotoConfigUsecase,
        _checkNeedFacialRecognitionByClockingEventTypeUsecase =
            checkNeedFacialRecognitionByClockingEventTypeUsecase,
        _permissionService = permissionService,
        _navigatorService = navigatorService,
        _collectorCameraCubit = collectorCameraCubit,
        _cameraWidget = cameraWidget,
        _logService = logService;

  void setContext(
    RegisterClockingEventBloc registerClockingEventBloc,
  ) {
    _registerClockingEventBloc = registerClockingEventBloc;
  }

  @override
  Future<dynamic> handler() async {
    DateTime initDateTime = DateTime.now();
    log('##INFO## Stating GetPhotoStateNode ${DateTime.now()}');

    final ClockingEventRegisterEntity(
      :clockingEventRegisterType,
      successFacialRecognition:sucessFacialRecognition,
    ) = _registerClockingEventBloc.clockingEventRegisterEntity;

    final takePhoto = await _takePhotoConfigUsecase.call(
      clockingEventRegisterType: clockingEventRegisterType,
    );
    final needFacialRecognition =
        _checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
      clockingEventRegisterType: clockingEventRegisterType,
    );

    if (takePhoto && needFacialRecognition && !sucessFacialRecognition) {
      PermissionStatus permissionStatus = await _permissionService.check(
        permission: DevicePermissionEnum.camera,
      );

      if (permissionStatus.isGranted) {
        await getPhoto();
      }
    }

    _logService.saveLocalLog(
      exception: 'GetPhotoStateNode',
      stackTrace:
          'takePhoto: $takePhoto, hasPermission ${_registerClockingEventBloc.clockingEventRegisterEntity.photo?.hasPermission}, name ${_registerClockingEventBloc.clockingEventRegisterEntity.photo?.name}, success ${_registerClockingEventBloc.clockingEventRegisterEntity.photo?.success} at ${DateTime.now()}',
    );

    log('##INFO## Finish GetPhotoStateNode ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetPhotoStateNode: #ProcessingTime: ${totalDuration.toString()}');
    return super.handler();
  }

  Future<void> getPhoto() async {
    _collectorCameraCubit.employeeId =
        _registerClockingEventBloc.clockingEventRegisterEntity.employeeDto!.id;

    String? photoName = await _navigatorService.push(
      pageRoute: MaterialPageRoute(
        builder: (context) => _cameraWidget,
      ),
    );

    // When camera is closed by the user
    if (photoName == null || photoName.isEmpty) {
      _registerClockingEventBloc.clockingEventRegisterEntity.photo =
          StatePhotoEntity(
        hasPermission: false,
        success: false,
        name: null,
      );
    } else {
      _registerClockingEventBloc.clockingEventRegisterEntity.photo =
          StatePhotoEntity(
        hasPermission: true,
        success: true,
        name: photoName,
      );
    }
  }
}
