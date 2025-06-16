import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../enums/network_status.dart';
import '../../input_model/device_info_dto.dart';


abstract class IPlatformService {
  Future<String> getOperatingSystem();
  Future<DeviceInfo> getDeviceInfoDto();
  clock.PlatformDeviceEnum getPlatformDevice();
  Future<NetworkStatusEnum> connectivityStatus();
  Future<bool> hasConnectivity();
  Stream<bool> connectivityStream();
  Future<PackageInfo> getPackageinfo();
  Future<StateLocationEntity> getLocation({bool requestLocation = true});

  /// Indicates that the current device is an emulator or has developer mode enabled.
  Future<bool> isDevelopmentDevice();
  void dispose();
  Future<bool> isTimeAuto();
  Future<bool> isTimeZoneAuto();
  Future<void> openTimeSetting();
  bool isAndroid();
  bool isIOS();
}
