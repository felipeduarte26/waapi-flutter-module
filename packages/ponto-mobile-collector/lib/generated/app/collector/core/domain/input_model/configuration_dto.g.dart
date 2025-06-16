// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/configuration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationDto _$ConfigurationDtoFromJson(Map<String, dynamic> json) =>
    ConfigurationDto(
      id: json['id'] as String?,
      onlyOnline: json['onlyOnline'] as bool,
      operationMode:
          $enumDecode(_$OperationModeTypeEnumMap, json['operationMode']),
      timezone: json['timezone'] as String,
      takePhoto: json['takePhoto'] as bool,
      allowChangeTime: json['allowChangeTime'] as bool?,
      faceRecognition: json['faceRecognition'] as bool?,
      faceRecognitionSingle: json['faceRecognitionSingle'] as bool?,
      faceRecognitionMulti: json['faceRecognitionMulti'] as bool?,
      username: json['username'] as String?,
      isManager: json['isManager'] as bool?,
      managerId: json['managerId'] as String?,
      overnight: json['overnight'] as bool?,
      controlOvernight: json['controlOvernight'] as bool?,
      clockingEventUses: (json['clockingEventUses'] as List<dynamic>?)
          ?.map((e) => ClockingEventUseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      gps: json['gps'] as bool?,
      deviceAuthorizationType: json['deviceAuthorizationType'] as bool?,
      allowDrivingTime: json['allowDrivingTime'] as bool?,
      allowGpoOnApp: json['allowGpoOnApp'] as bool?,
      exportNotChecked: json['exportNotChecked'] as bool?,
      insightOutOfBound: $enumDecodeNullable(
          _$InsightOutOfBoundTypeEnumMap, json['insightOutOfBound']),
      openExternalBrowser: json['openExternalBrowser'] as bool?,
      allowUse: json['allowUse'] as bool?,
      externalControlTimezone: json['externalControlTimezone'] as bool?,
      nfcMode: json['nfcMode'] as bool?,
      takePhotoNfc: json['takePhotoNfc'] as bool?,
      takePhotoSingle: json['takePhotoSingle'] as bool?,
      takePhotoDriver: json['takePhotoDriver'] as bool?,
      takePhotoQrcode: json['takePhotoQrcode'] as bool?,
    );

Map<String, dynamic> _$ConfigurationDtoToJson(ConfigurationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'onlyOnline': instance.onlyOnline,
      'operationMode': _$OperationModeTypeEnumMap[instance.operationMode]!,
      'timezone': instance.timezone,
      'takePhoto': instance.takePhoto,
      'allowChangeTime': instance.allowChangeTime,
      'faceRecognition': instance.faceRecognition,
      'faceRecognitionSingle': instance.faceRecognitionSingle,
      'faceRecognitionMulti': instance.faceRecognitionMulti,
      'username': instance.username,
      'isManager': instance.isManager,
      'managerId': instance.managerId,
      'overnight': instance.overnight,
      'controlOvernight': instance.controlOvernight,
      'clockingEventUses': instance.clockingEventUses,
      'gps': instance.gps,
      'deviceAuthorizationType': instance.deviceAuthorizationType,
      'allowDrivingTime': instance.allowDrivingTime,
      'allowGpoOnApp': instance.allowGpoOnApp,
      'exportNotChecked': instance.exportNotChecked,
      'insightOutOfBound':
          _$InsightOutOfBoundTypeEnumMap[instance.insightOutOfBound],
      'openExternalBrowser': instance.openExternalBrowser,
      'allowUse': instance.allowUse,
      'externalControlTimezone': instance.externalControlTimezone,
      'nfcMode': instance.nfcMode,
      'takePhotoNfc': instance.takePhotoNfc,
      'takePhotoSingle': instance.takePhotoSingle,
      'takePhotoDriver': instance.takePhotoDriver,
      'takePhotoQrcode': instance.takePhotoQrcode,
    };

const _$OperationModeTypeEnumMap = {
  OperationModeType.multi: 'MULTI',
  OperationModeType.single: 'SINGLE',
  OperationModeType.driver: 'DRIVER',
  OperationModeType.nfc: 'NFC',
  OperationModeType.biometric: 'BIOMETRIC',
  OperationModeType.qrCode: 'QRCODE',
  OperationModeType.faceRecognition: 'FACE_RECOGNITION',
};

const _$InsightOutOfBoundTypeEnumMap = {
  InsightOutOfBoundType.allClockingEvents: 'ALL_CLOCKING_EVENTS',
  InsightOutOfBoundType.mobileOnly: 'MOBILE_ONLY',
  InsightOutOfBoundType.doNotSend: 'DO_NOT_SEND',
};
