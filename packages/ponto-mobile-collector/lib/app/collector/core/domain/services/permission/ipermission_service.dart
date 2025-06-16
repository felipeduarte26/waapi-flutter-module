import 'package:mobile_authentication/mobile_authentication_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../ponto_mobile_collector.dart';


abstract class IPermissionService {
  Future<bool> checkPermissionIsAuthorized({
    required DevicePermissionEnum permission,
  });

  Future<bool> checkPermissionIsDenied({
    required DevicePermissionEnum permission,
  });

  Future<bool> checkPermissionIsPermanentlyDenied({
    required DevicePermissionEnum permission,
  });

  Future<bool> requestDevicePermission({
    required DevicePermissionEnum permission,
  });

  Future<bool> requestDevicePermissionIfNotAllowed({
    required DevicePermissionEnum permission,
  });

  Future<void> requestAllPermission();

  Future<void> requestDefaultPermission();

  Future<AuthorizationResponse> checkPlatformPermission({
    required String resource,
    required String action,
  });

  Future<bool> openSystemAppSettings();

  Future<PermissionStatus> check({required DevicePermissionEnum permission});

  Future<PermissionStatus> request({required DevicePermissionEnum permission});
}
