import 'dart:convert';

import '../../domain/entities/global_configuration_entity.dart';
import '../drift/collector_database.dart';

class GlobalConfigurationEntityMapper {
  GlobalConfigurationEntity fromMap({required Map<String, dynamic> map}) {
    if (map.isEmpty) {
      return const GlobalConfigurationEntity(id: '');
    }
    return GlobalConfigurationEntity(
      id: map['id'],
      gps: map['gps'],
      online: map['online'],
      timeout: map['timeout'],
      operationMode: map['operationMode'],
      nfcMode: map['nfcMode'],
      allowChangeTime: map['allowChangeTime'],
      timezone: map['timezone'],
      deviceAuthModeSingleMode: map['deviceAuthModeSingleMode'],
      deviceAuthModeMultiMode: map['deviceAuthModeMultiMode'],
      deviceAuthModeDriverMode: map['deviceAuthModeDriverMode'],
      allowDrivingTime: map['allowDrivingTime'],
      overnight: map['overnight'],
      controlOvernight: map['controlOvernight'],
      allowGpoOnApp: map['allowGpoOnApp'],
      exportNotChecked: map['exportNotChecked'],
      insightOutOfBound: map['insightOutOfBound'],
      takePhotoSingle: map['takePhotoSingle'],
      takePhotoMulti: map['takePhotoMulti'],
      takePhotoDriver: map['takePhotoDriver'],
      takePhotoQrcode: map['takePhotoQrcode'],
      takePhotoNfc: map['takePhotoNfc'],
      openExternalBrowser: map['openExternalBrowser'],
      clockingEventUses: map['clockingEventUses'] != null ? [jsonEncode(map['clockingEventUses'])] : [],
      allowUse: map['allowUse'],
      externalControlTimezone: map['externalControlTimezone'],
      faceRecognition: map['faceRecognition'],
    );
  }

  List<GlobalConfigurationEntity> fromList({required List<dynamic> list}) {
    var map = list.map((e) => fromMap(map: e));
    return map.toList();
  }

  GlobalConfigurationTableData toTableData({required GlobalConfigurationEntity globalConfigurationEntity}) {
    return GlobalConfigurationTableData(
      id: globalConfigurationEntity.id,
      gps: globalConfigurationEntity.gps,
      online: globalConfigurationEntity.online,
      timeout: globalConfigurationEntity.timeout,
      operationMode: globalConfigurationEntity.operationMode,
      nfcMode: globalConfigurationEntity.nfcMode,
      allowChangeTime: globalConfigurationEntity.allowChangeTime,
      timezone: globalConfigurationEntity.timezone,
      deviceAuthModeSingleMode: globalConfigurationEntity.deviceAuthModeSingleMode,
      deviceAuthModeMultiMode: globalConfigurationEntity.deviceAuthModeMultiMode,
      deviceAuthModeDriverMode: globalConfigurationEntity.deviceAuthModeDriverMode,
      allowDrivingTime: globalConfigurationEntity.allowDrivingTime,
      overnight: globalConfigurationEntity.overnight,
      controlOvernight: globalConfigurationEntity.controlOvernight,
      allowGpoOnApp: globalConfigurationEntity.allowGpoOnApp,
      exportNotChecked: globalConfigurationEntity.exportNotChecked,
      insightOutOfBound: globalConfigurationEntity.insightOutOfBound,
      takePhotoSingle: globalConfigurationEntity.takePhotoSingle,
      takePhotoMulti: globalConfigurationEntity.takePhotoMulti,
      takePhotoDriver: globalConfigurationEntity.takePhotoDriver,
      takePhotoQrcode: globalConfigurationEntity.takePhotoQrcode,
      takePhotoNfc: globalConfigurationEntity.takePhotoNfc,
      openExternalBrowser: globalConfigurationEntity.openExternalBrowser,
      clockingEventUses: globalConfigurationEntity.clockingEventUses?.join(','),
      allowUse: globalConfigurationEntity.allowUse,
      externalControlTimezone: defaultBool(value: globalConfigurationEntity.externalControlTimezone),
      faceRecognition: defaultBool(value: globalConfigurationEntity.faceRecognition),
    );
  }

  bool defaultBool({bool? value}) {
    return value ?? false;
  }

  GlobalConfigurationEntity fromTableData(GlobalConfigurationTableData data) {
    return GlobalConfigurationEntity(
      id: data.id,
      gps: data.gps,
      online: data.online,
      timeout: data.timeout,
      operationMode: data.operationMode,
      nfcMode: data.nfcMode,
      allowChangeTime: data.allowChangeTime,
      timezone: data.timezone,
      deviceAuthModeSingleMode: data.deviceAuthModeSingleMode,
      deviceAuthModeMultiMode: data.deviceAuthModeMultiMode,
      deviceAuthModeDriverMode: data.deviceAuthModeDriverMode,
      allowDrivingTime: data.allowDrivingTime,
      overnight: data.overnight,
      controlOvernight: data.controlOvernight,
      allowGpoOnApp: data.allowGpoOnApp,
      exportNotChecked: data.exportNotChecked,
      insightOutOfBound: data.insightOutOfBound,
      takePhotoSingle: data.takePhotoSingle,
      takePhotoMulti: data.takePhotoMulti,
      takePhotoDriver: data.takePhotoDriver,
      takePhotoQrcode: data.takePhotoQrcode,
      takePhotoNfc: data.takePhotoNfc,
      openExternalBrowser: data.openExternalBrowser,
      clockingEventUses: data.clockingEventUses?.split(','),
      allowUse: data.allowUse,
      externalControlTimezone: data.externalControlTimezone,
      faceRecognition: data.faceRecognition,
    );
  }
}
