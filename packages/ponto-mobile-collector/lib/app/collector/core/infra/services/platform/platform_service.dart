import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:datetime_setting/datetime_setting.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/enums/network_status.dart';
import '../../../domain/input_model/device_info_dto.dart';

class PlatformService extends IPlatformService {
  PontoMobileCollectorException exception =
      PontoMobileCollectorException('Platform not supported');

  /// Broadcast for subscription of the users of the connectivity change event
  final _connectivityStreamController = StreamController<bool>.broadcast();

  PlatformService() {
    /// Function called whenever connection status changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityStreamController.sink.add(result != ConnectivityResult.none);
    });
  }

  @override
  Future<String> getOperatingSystem() async {
    return Future.value(Platform.operatingSystem);
  }

  @override
  bool isAndroid() {
    return Platform.isAndroid;
  }

  @override
  bool isIOS() {
    return Platform.isIOS;
  }

  @override
  Future<DeviceInfo> getDeviceInfoDto() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    final mobileDeviceIdentifierPlugin = MobileDeviceIdentifier();
    String? deviceId = await mobileDeviceIdentifierPlugin.getDeviceId();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return Future<DeviceInfo>.value(
        DeviceInfo(
          identifier: deviceId ?? androidInfo.id,
          name: androidInfo.device,
          model: androidInfo.model,
        ),
      );
    }

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return Future<DeviceInfo>.value(
        DeviceInfo(
          identifier: deviceId ?? iosInfo.identifierForVendor!,
          name: iosInfo.name,
          model: iosInfo.model,
        ),
      );
    }

    throw exception;
  }

  @override
  clock.PlatformDeviceEnum getPlatformDevice() {
    if (Platform.isAndroid) {
      return clock.PlatformDeviceEnum.android;
    }

    if (Platform.isIOS) {
      return clock.PlatformDeviceEnum.ios;
    }

    if (Platform.isWindows) {
      return clock.PlatformDeviceEnum.windows;
    }

    return clock.PlatformDeviceEnum.undefined;
  }

  @override
  Future<NetworkStatusEnum> connectivityStatus() async {
    try {
      ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.vpn) {
        return Future.value(NetworkStatusEnum.active);
      }

      return Future.value(NetworkStatusEnum.inactive);
    } catch (e) {
      return Future.value(NetworkStatusEnum.undefined);
    }
  }

  @override
  Future<bool> hasConnectivity() async {
    if (await connectivityStatus() != NetworkStatusEnum.active) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  /// Strem when connectivity changes
  @override
  Stream<bool> connectivityStream() {
    return _connectivityStreamController.stream;
  }

  @override
  Future<PackageInfo> getPackageinfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Future<StateLocationEntity> getLocation({bool requestLocation = true}) async {
    LocationPermission permission;
    Location location = Location();

    bool serviceEnabled;
    bool isMock = false;

    /// Verifica se o SERVIÇO de localização esta ativo.
    /// Caso esteja inativo retorna um erro, lembrando que é a
    /// verifição do SERVIÇO e não da PERMISSÃO.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && requestLocation) {
      await location.requestService();
      log('Location services are disabled.');
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    /// Verifica se a PERMISSÃO está ativa.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied && requestLocation) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
      }
    }

    /// Verifica se a PERMISSÃO foi negada para sempre.
    if (permission == LocationPermission.deniedForever) {
      log(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    bool hasPermission = permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse
        ? true
        : false;

    if (serviceEnabled && hasPermission) {
      Position? locationData;

      try {
        locationData = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(seconds: 5),
        );

        return StateLocationEntity(
          hasPermission: hasPermission,
          isServiceEnabled: serviceEnabled,
          success: true,
          latitude: locationData.latitude,
          longitude: locationData.longitude,
          isMock: isMock,
        );
      } catch (e) {
        log('Error getting location: ${e.toString()}');
      }
    }

    StateLocationEntity stateLocation = StateLocationEntity(
      hasPermission: hasPermission,
      isServiceEnabled: serviceEnabled,
      success: false,
      latitude: null,
      longitude: null,
      isMock: isMock,
    );

    return stateLocation;
  }

  @override
  Future<bool> isDevelopmentDevice() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return false;
      // return !androidInfo.isPhysicalDevice ||
      //     (await FlutterJailbreakDetection.developerMode);
    }

    if (Platform.isIOS) {
      // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return false;
      // return !iosInfo.isPhysicalDevice ||
      //     (await FlutterJailbreakDetection.jailbroken);
    }

    throw exception;
  }

  @override
  void dispose() {
    _connectivityStreamController.close();
  }

  @override
  Future<bool> isTimeAuto() {
    if (Platform.isAndroid) {
      return DatetimeSetting.timeIsAuto();
    }

    if (Platform.isIOS) {
      return Future.value(true);
    }

    throw exception;
  }

  @override
  Future<bool> isTimeZoneAuto() {
    if (Platform.isAndroid) {
      return DatetimeSetting.timeZoneIsAuto();
    }

    if (Platform.isIOS) {
      return Future.value(true);
    }

    throw exception;
  }

  @override
  Future<void> openTimeSetting() {
    if (Platform.isAndroid) {
      return DatetimeSetting.openSetting();
    }

    return Future.value();
  }
}
