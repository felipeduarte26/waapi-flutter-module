import 'package:mobile_authentication/mobile_authentication_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../ponto_mobile_collector.dart';

class PermissionService implements IPermissionService {
  final IMobileAuthenticationService _mobileAuthenticationService;

  PermissionService({
    required IMobileAuthenticationService mobileAuthenticationService,
  }) : _mobileAuthenticationService = mobileAuthenticationService;

  @override
  Future<bool> requestDevicePermission({
    required DevicePermissionEnum permission,
  }) async {
    switch (permission) {
      case DevicePermissionEnum.camera:
        await Permission.camera.request();
        final permissionStatus = await Permission.camera.status;
        return permissionStatus.isGranted;
      case DevicePermissionEnum.location:
        await Permission.location.request();
        final permissionStatus = await Permission.location.status;
        return permissionStatus.isGranted;
      case DevicePermissionEnum.manageExternalStorage:
        await Permission.storage.request();
        final permissionStatus = await Permission.storage.status;
        return (permissionStatus.isGranted);
      case DevicePermissionEnum.photos:
        await Permission.photos.request();
        final permissionStatus = await Permission.photos.status;
        return (permissionStatus.isGranted);
      default:
        return Future<bool>.value(false);
    }
  }

  @override
  Future<bool> requestDevicePermissionIfNotAllowed({
    required DevicePermissionEnum permission,
  }) async {
    bool isAllowed = await checkPermissionIsAuthorized(permission: permission);
    if (!isAllowed) {
      isAllowed = await requestDevicePermission(permission: permission);
    }
    return Future.value(isAllowed);
  }

  @override
  Future<void> requestAllPermission() async {
    await [
      Permission.camera,
      Permission.location,
      Permission.notification,
    ].request();
  }

  @override
  Future<void> requestDefaultPermission() async {
    await [
      Permission.location,
    ].request();
  }

  @override
  Future<AuthorizationResponse> checkPlatformPermission({
    required String resource,
    required String action,
  }) async {
    AuthorizationParameter authorizationParameterDto = AuthorizationParameter(
      resource: resource,
      action: action,
    );
    AuthorizationPermissions authorizationPermissions =
        AuthorizationPermissions(permissions: const []);
    authorizationPermissions.permissions.add(authorizationParameterDto);
    return _mobileAuthenticationService.getAuthorization(
      authorizationPermissions,
      Environment.dev,
    );
  }

  @override
  Future<bool> checkPermissionIsAuthorized({
    required DevicePermissionEnum permission,
  }) async {
    switch (permission) {
      case DevicePermissionEnum.camera:
        return await Permission.camera.isGranted;
      case DevicePermissionEnum.location:
        return await Permission.location.isGranted;
      case DevicePermissionEnum.manageExternalStorage:
        return await Permission.storage.isGranted;
      case DevicePermissionEnum.photos:
        return await Permission.photos.isGranted;
      default:
        return Future.value(false);
    }
  }

  @override
  Future<bool> checkPermissionIsDenied({
    required DevicePermissionEnum permission,
  }) async {
    switch (permission) {
      case DevicePermissionEnum.camera:
        return await Permission.camera.isDenied;
      case DevicePermissionEnum.location:
        await Permission.location.request();
        return await Permission.location.isDenied;
      case DevicePermissionEnum.manageExternalStorage:
        await Permission.storage.request();
        return await Permission.storage.isDenied;
      case DevicePermissionEnum.photos:
        await Permission.photos.request();
        return await Permission.photos.isDenied;
      default:
        return Future.value(false);
    }
  }

  @override
  Future<bool> checkPermissionIsPermanentlyDenied({
    required DevicePermissionEnum permission,
  }) async {
    switch (permission) {
      case DevicePermissionEnum.camera:
        return await Permission.camera.isPermanentlyDenied;
      case DevicePermissionEnum.location:
        return await Permission.location.isPermanentlyDenied;
      case DevicePermissionEnum.manageExternalStorage:
        return await Permission.storage.isPermanentlyDenied;
      case DevicePermissionEnum.photos:
        return await Permission.photos.isPermanentlyDenied;
      default:
        return Future.value(false);
    }
  }

  @override
  Future<bool> openSystemAppSettings() async {
    return await openAppSettings();
  }

  @override
  Future<PermissionStatus> check({
    required DevicePermissionEnum permission,
  }) async {
    switch (permission) {
      case DevicePermissionEnum.camera:
        return await Permission.camera.status;
      case DevicePermissionEnum.location:
        return await Permission.location.status;
      case DevicePermissionEnum.manageExternalStorage:
        return await Permission.manageExternalStorage.status;
      case DevicePermissionEnum.photos:
        return await Permission.photos.status;
      case DevicePermissionEnum.notification:
        return await Permission.notification.status;
    }
  }

  @override
  Future<PermissionStatus> request({
    required DevicePermissionEnum permission,
  }) async {
    switch (permission) {
      case DevicePermissionEnum.camera:
        return await Permission.camera.request();
      case DevicePermissionEnum.location:
        return await Permission.location.request();
      case DevicePermissionEnum.manageExternalStorage:
        return await Permission.storage.request();
      case DevicePermissionEnum.photos:
        return await Permission.photos.request();
      case DevicePermissionEnum.notification:
        return await Permission.notification.request();
    }
  }
}
