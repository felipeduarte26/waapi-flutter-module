import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:senior_design_system/components/senior_modal/model/senior_modal_action.dart';
import 'package:senior_design_system/components/senior_modal/senior_modal_widget.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import '../../../domain/services/navigator/navigator_service.dart';
import '../../../domain/services/permission/ipermission_service.dart';
import '../../../infra/utils/enum/device_permission_enum.dart';

class RequestCameraPermissionsModalWidget {
  final IPermissionService _permissionService;
  final NavigatorService _navigatorService;
  final IFaceRecognitionSdkAuthenticationService
      _faceRecognitionSdkAuthenticationService;
  late BuildContext _context;

  RequestCameraPermissionsModalWidget({
    required IPermissionService permissionService,
    required NavigatorService navigatorService,
    required IFaceRecognitionSdkAuthenticationService
        faceRecognitionSdkAuthenticationService,
  })  : _permissionService = permissionService,
        _navigatorService = navigatorService,
        _faceRecognitionSdkAuthenticationService =
            faceRecognitionSdkAuthenticationService;

  void setContext(
    BuildContext context,
  ) {
    _context = context;
  }

  Future<bool> checkPermission({
    String? content,
  }) async {
    DevicePermissionEnum permissionType = DevicePermissionEnum.camera;
    PermissionStatus permissionStatus =
        await _permissionService.check(permission: permissionType);

    if (permissionStatus.isGranted) {
      return true;
    }

    if (permissionStatus.isDenied) {
      permissionStatus =
          await _permissionService.request(permission: permissionType);
      return permissionStatus.isGranted;
    }

    if (permissionStatus.isPermanentlyDenied) {
      await _showPermissionIsDeniedMessage(content: content);
    }

    return await _permissionService.check(permission: permissionType).isGranted;
  }

  Future<void> _showPermissionIsDeniedMessage({
    String? content,
  }) async {
    await showDialog(
      context: _context,
      builder: (BuildContext context) {
        return SeniorModal(
          title: CollectorLocalizations.of(_context).alert,
          content: content ??= CollectorLocalizations.of(_context)
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
              initilizeSdkGryfo();
              _navigatorService.pop();
            },
          ),
        );
      },
    );
  }

  void initilizeSdkGryfo() async {
    DevicePermissionEnum permissionType = DevicePermissionEnum.camera;
    PermissionStatus permissionStatus =
        await _permissionService.check(permission: permissionType);

    if (permissionStatus.isGranted) {
      await _faceRecognitionSdkAuthenticationService.initialize();
    }
  }
}
