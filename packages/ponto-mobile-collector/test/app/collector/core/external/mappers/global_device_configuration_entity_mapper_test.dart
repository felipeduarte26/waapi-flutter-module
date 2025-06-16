import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_device_configuration_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/global_device_configuration_entity_mapper.dart';

void main() {
  late GlobalDeviceConfigurationEntityMapper
      globalDeviceConfigurationEntityMapper;
  Map<String, dynamic> map = {
    'deviceConfiguration': {
      'id': '123',
      'enable_nfc': true,
      'enable_qrcode': true,
      'enable_facial': true,
      'enable_user_and_password': true,
      'allow_change_time': true,
      'time_zone': '-03:00',
      'last_update': '2024-06-21',
      'last_sync': '2024-06-21',
    },
    'configuration': {
      'id': '321',
      'gps': true,
      'online': true,
      'timeout': 'timeout',
      'operationMode': 'operationMode',
      'nfcMode': true,
      'allowChangeTime': true,
      'timezone': 'timezone',
      'deviceAuthModeSingleMode': 'deviceAuthModeSingleMode',
      'deviceAuthModeMultiMode': 'deviceAuthModeMultiMode',
      'deviceAuthModeDriverMode': 'deviceAuthModeDriverMode',
      'allowDrivingTime': true,
      'overnight': true,
      'controlOvernight': true,
      'allowGpoOnApp': true,
      'exportNotChecked': true,
      'insightOutOfBound': 'insightOutOfBound',
      'takePhotoSingle': true,
      'takePhotoMulti': true,
      'takePhotoDriver': true,
      'takePhotoQrcode': true,
      'openExternalBrowser': true,
      'clockingEventUses': [],
      'allowUse': true,
      'externalControlTimezone': true,
      'faceRecognition': true,
    },
    'instanceDateAndTime': '2024-06-21',
  };

  setUp(() {
    globalDeviceConfigurationEntityMapper =
        GlobalDeviceConfigurationEntityMapper();
  });

  test('fromMap null test', () {
    GlobalDeviceConfigurationEntity globalDeviceConfigurationEntity =
        globalDeviceConfigurationEntityMapper.fromMap({});

    expect(globalDeviceConfigurationEntity.deviceConfiguration, null);
    expect(globalDeviceConfigurationEntity.globalConfigurationEntity, null);
    expect(globalDeviceConfigurationEntity.hlbDateTime, null);
  });

  test('fromMap success test', () {
    GlobalDeviceConfigurationEntity globalDeviceConfigurationEntity =
        globalDeviceConfigurationEntityMapper.fromMap(map);

    expect(globalDeviceConfigurationEntity.deviceConfiguration != null, true);
    expect(
      globalDeviceConfigurationEntity.globalConfigurationEntity != null,
      true,
    );
    expect(globalDeviceConfigurationEntity.deviceConfiguration!.id, '123');
    expect(
      globalDeviceConfigurationEntity.globalConfigurationEntity!.id,
      '321',
    );
    expect(globalDeviceConfigurationEntity.hlbDateTime, '2024-06-21');
  });
}
