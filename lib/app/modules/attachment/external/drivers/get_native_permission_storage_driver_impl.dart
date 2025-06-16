import 'package:permission_handler/permission_handler.dart';
import 'package:platform/platform.dart';

import '../../infra/drivers/get_native_permission_storage_driver.dart';

class GetNativePermissionStorageDriverImpl implements GetNativePermissionStorageDriver {
  final LocalPlatform _localPlatform;

  GetNativePermissionStorageDriverImpl({
    required LocalPlatform localPlatform,
  }) : _localPlatform = localPlatform;

  @override
  Future<bool> call() async {
    bool isGranted = false;
    if (_localPlatform.isAndroid) {
      final permissionStatusStorage = await Permission.storage.request();
      final permissionStatusPhotos = await Permission.photos.request();
      final permissionStatusAudio = await Permission.audio.request();
      final permissionStatusVideo = await Permission.videos.request();
      isGranted =
          (permissionStatusPhotos.isGranted && permissionStatusAudio.isGranted && permissionStatusVideo.isGranted) ||
              permissionStatusStorage.isGranted;
    } else {
      final permissionStatusPhotos = await Permission.photos.request();
      isGranted = permissionStatusPhotos.isGranted;
    }

    return isGranted;
  }
}
