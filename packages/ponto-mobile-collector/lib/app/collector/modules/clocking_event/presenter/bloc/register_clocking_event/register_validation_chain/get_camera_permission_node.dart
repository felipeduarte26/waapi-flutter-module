import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../../../core/infra/utils/enum/execution_mode_enum.dart';
import '../../../../domain/usecase/call_facial_recognition_config_usecase.dart';
import '../../../../domain/usecase/take_photo_config_usecase.dart';
import 'register_validation_node.dart';

class GetCameraPermissionNode extends RegisterValidationNode {
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final ICallFacialRecognitionConfigUsecase _callFacialRecognitionConfigUsecase;
  final IPermissionService _permissionService;
  final NavigatorService _navigatorService;
  final ITakePhotoConfigUsecase _takePhotoConfigUsecase;
  final LogService _logService;
  late BuildContext _context;

  GetCameraPermissionNode({
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required ICallFacialRecognitionConfigUsecase
        callFacialRecognitionConfigUsecase,
    required IPermissionService permissionService,
    required NavigatorService navigatorService,
    required ITakePhotoConfigUsecase takePhotoConfigUsecase,
    required LogService logService,
  })  : _getExecutionModeUsecase = getExecutionModeUsecase,
        _callFacialRecognitionConfigUsecase =
            callFacialRecognitionConfigUsecase,
        _permissionService = permissionService,
        _navigatorService = navigatorService,
        _takePhotoConfigUsecase = takePhotoConfigUsecase,
        _logService = logService;

  void setContext(
    BuildContext context,
  ) {
    _context = context;
  }

  @override
  Future<dynamic> handler() async {
    DateTime initDateTime = DateTime.now();
    log('##INFO## GetCameraPermissionStateNode started: ${DateTime.now()}');
    _logService.saveLocalLog(
      exception: 'GetCameraPermissionNode',
      stackTrace:
          'Validating camera permission at ${DateTime.now()} at ${DateTime.now()}',
    );
    final ExecutionModeEnum executionModeEnum =
        await _getExecutionModeUsecase.call();

    if (executionModeEnum.isIndividualOrDriver()) {
      bool takePhoto = await _takePhotoConfigUsecase.call();

      bool callFacialRecognitionConfigUsecase =
          await _callFacialRecognitionConfigUsecase.call(
        checkCameraPermission: false,
      );

      _logService.saveLocalLog(
        exception: 'GetCameraPermissionNode',
        stackTrace:
            'takePhoto: $takePhoto, callFacialRecognitionConfigUsecase: $callFacialRecognitionConfigUsecase at ${DateTime.now()}',
      );

      if (takePhoto || callFacialRecognitionConfigUsecase) {
        DevicePermissionEnum permissionType = DevicePermissionEnum.camera;
        PermissionStatus permissionStatus =
            await _permissionService.check(permission: permissionType);

        if (permissionStatus.isDenied) {
          permissionStatus = await _permissionService.request(
            permission: permissionType,
          );
        } else if (permissionStatus.isPermanentlyDenied) {
          _logService.saveLocalLog(
            exception: 'GetCameraPermissionNode',
            stackTrace:
                'Request camera permission at ${DateTime.now()} at ${DateTime.now()}',
          );
          await showPermissionIsDeniedMessage();
        }
      }
    }

    log('##INFO## GetCameraPermissionStateNode finished ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetCameraPermissionNode: #ProcessingTime: ${totalDuration.toString()}');
    return super.handler();
  }

  Future<void> showPermissionIsDeniedMessage() async {
    await showDialog(
      context: _context,
      builder: (BuildContext context) {
        return SeniorModal(
          title: CollectorLocalizations.of(_context).alert,
          content: CollectorLocalizations.of(_context)
              .permissionCameraNotAllowedMessage,
          otherAction: SeniorModalAction(
            label: CollectorLocalizations.of(_context).goToConfiguration,
            danger: false,
            action: () async {
              await _permissionService.openSystemAppSettings();
            },
          ),
          defaultAction: SeniorModalAction(
            label: CollectorLocalizations.of(_context).continueAction,
            action: () async {
              _navigatorService.pop();
            },
          ),
        );
      },
    );
  }
}
