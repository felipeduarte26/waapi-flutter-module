// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/clocking_event_rest_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockingEventRestDto _$ClockingEventRestDtoFromJson(
        Map<String, dynamic> json) =>
    ClockingEventRestDto(
      appointmentId: json['appointmentId'] as String,
      dateEvent: json['dateEvent'] as String,
      timeEvent: json['timeEvent'] as String,
      timeZone: json['timeZone'] as String,
      appVersion: json['appVersion'] as String,
      platform: json['platform'] as String,
      device: json['device'] == null
          ? null
          : DeviceDto.fromJson(json['device'] as Map<String, dynamic>),
      geolocation: json['geolocation'] == null
          ? null
          : LocationImportDto.fromJson(
              json['geolocation'] as Map<String, dynamic>),
      company: CompanyIdDto.fromJson(json['company'] as Map<String, dynamic>),
      employee:
          EmployeeIdDto.fromJson(json['employee'] as Map<String, dynamic>),
      fenceState:
          $enumDecodeNullable(_$FenceStatusEnumEnumMap, json['fenceState']),
      use: json['use'] as int,
      mode: $enumDecodeNullable(_$OperationModeTypeEnumMap, json['mode']),
      online: json['online'] as bool?,
      signature:
          SignatureInfoDto.fromJson(json['signature'] as Map<String, dynamic>),
      origin:
          $enumDecodeNullable(_$ClockingEventOriginEnumEnumMap, json['origin']),
      clientOriginInfo: json['clientOriginInfo'] as String?,
      appointmentImage: json['appointmentImage'] as String?,
      photoNotCaptured: json['photoNotCaptured'] as String?,
      isSynchronized: json['isSynchronized'] as bool? ?? false,
      geolocationIsMock: json['geolocationIsMock'] as bool? ?? false,
      facialRecognitionStatus: json['facialRecognitionStatus'] as String?,
    );

Map<String, dynamic> _$ClockingEventRestDtoToJson(
        ClockingEventRestDto instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'dateEvent': instance.dateEvent,
      'timeEvent': instance.timeEvent,
      'timeZone': instance.timeZone,
      'appVersion': instance.appVersion,
      'platform': instance.platform,
      'device': instance.device,
      'geolocation': instance.geolocation,
      'geolocationIsMock': instance.geolocationIsMock,
      'company': instance.company,
      'employee': instance.employee,
      'fenceState': _$FenceStatusEnumEnumMap[instance.fenceState],
      'use': instance.use,
      'mode': _$OperationModeTypeEnumMap[instance.mode],
      'online': instance.online,
      'signature': instance.signature,
      'origin': _$ClockingEventOriginEnumEnumMap[instance.origin],
      'clientOriginInfo': instance.clientOriginInfo,
      'appointmentImage': instance.appointmentImage,
      'photoNotCaptured': instance.photoNotCaptured,
      'isSynchronized': instance.isSynchronized,
      'facialRecognitionStatus': instance.facialRecognitionStatus,
    };

const _$FenceStatusEnumEnumMap = {
  FenceStatusEnum.into: 'IN',
  FenceStatusEnum.out: 'OUT',
  FenceStatusEnum.noFence: 'NO_FENCE',
  FenceStatusEnum.noLocation: 'NO_LOCATION',
  FenceStatusEnum.noLocationPermission: 'NO_LOCATION_PERMISSION',
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

const _$ClockingEventOriginEnumEnumMap = {
  ClockingEventOriginEnum.mobile: 'MOBILE',
  ClockingEventOriginEnum.web: 'WEB',
  ClockingEventOriginEnum.client: 'CLIENT',
};
