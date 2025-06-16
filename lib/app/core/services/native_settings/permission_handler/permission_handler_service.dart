import 'package:permission_handler/permission_handler.dart';

import '../native_settings_service.dart';

class PermissionHandlerService implements NativeSettingsService {
  @override
  Future<bool> openNativeSettings() async {
    return openAppSettings();
  }
}
