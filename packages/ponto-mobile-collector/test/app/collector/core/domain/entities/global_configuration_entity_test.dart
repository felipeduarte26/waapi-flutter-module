import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_configuration_entity.dart';


void main() {
  test('GlobalConfigurationEntity can be correctly converted to and from a map', () {
    var entity = const GlobalConfigurationEntity(
      id: 'testId',
      gps: true,
      online: false,
      timeout: 'testTimeout',
      operationMode: 'testOperationMode',
      nfcMode: true,
      allowChangeTime: false,
      timezone: 'testTimezone',
      deviceAuthModeSingleMode: 'testDeviceAuthModeSingleMode',
      deviceAuthModeMultiMode: 'testDeviceAuthModeMultiMode',
      deviceAuthModeDriverMode: 'testDeviceAuthModeDriverMode',
      allowDrivingTime: true,
      overnight: false,
      controlOvernight: true,
      allowGpoOnApp: false,
      exportNotChecked: true,
      insightOutOfBound: 'testInsightOutOfBound',
      takePhotoSingle: true,
      takePhotoMulti: false,
      takePhotoDriver: true,
      takePhotoQrcode: false,
      openExternalBrowser: true,
      clockingEventUses: ['testClockingEventUse1', 'testClockingEventUse2'],
      allowUse: true,
      externalControlTimezone: false,
      faceRecognition: true,
    );

    final map = entity.toMap();

    final entityFromMap = GlobalConfigurationEntity.fromMap(map);

    expect(entityFromMap.id, equals(entity.id));
    expect(entityFromMap.gps, equals(entity.gps));
    expect(entityFromMap.online, equals(entity.online));
    expect(entityFromMap.timeout, equals(entity.timeout));
    expect(entityFromMap.operationMode, equals(entity.operationMode));
    expect(entityFromMap.nfcMode, equals(entity.nfcMode));
    expect(entityFromMap.allowChangeTime, equals(entity.allowChangeTime));
    expect(entityFromMap.timezone, equals(entity.timezone));
    expect(entityFromMap.deviceAuthModeSingleMode, equals(entity.deviceAuthModeSingleMode));
    expect(entityFromMap.deviceAuthModeMultiMode, equals(entity.deviceAuthModeMultiMode));
    expect(entityFromMap.deviceAuthModeDriverMode, equals(entity.deviceAuthModeDriverMode));
    expect(entityFromMap.allowDrivingTime, equals(entity.allowDrivingTime));
    expect(entityFromMap.overnight, equals(entity.overnight));
    expect(entityFromMap.controlOvernight, equals(entity.controlOvernight));
    expect(entityFromMap.allowGpoOnApp, equals(entity.allowGpoOnApp));
    expect(entityFromMap.exportNotChecked, equals(entity.exportNotChecked));
    expect(entityFromMap.insightOutOfBound, equals(entity.insightOutOfBound));
    expect(entityFromMap.takePhotoSingle, equals(entity.takePhotoSingle));
    expect(entityFromMap.takePhotoMulti, equals(entity.takePhotoMulti));
    expect(entityFromMap.takePhotoDriver, equals(entity.takePhotoDriver));
    expect(entityFromMap.takePhotoQrcode, equals(entity.takePhotoQrcode));
    expect(entityFromMap.openExternalBrowser, equals(entity.openExternalBrowser));
    expect(entityFromMap.clockingEventUses, equals(entity.clockingEventUses));
    expect(entityFromMap.allowUse, equals(entity.allowUse));
    expect(entityFromMap.externalControlTimezone, equals(entity.externalControlTimezone));
    expect(entityFromMap.faceRecognition, equals(entity.faceRecognition));

  });
}
