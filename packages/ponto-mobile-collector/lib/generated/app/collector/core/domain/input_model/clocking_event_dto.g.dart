// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/clocking_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockingEventDto _$ClockingEventDtoFromJson(Map<String, dynamic> json) =>
    ClockingEventDto(
      id: json['id'] as String?,
      dateEvent: json['dateEvent'] as String,
      timeEvent: json['timeEvent'] as String,
      timeZone: json['timeZone'] as String,
      companyIdentifier: json['companyIdentifier'] as String,
      pis: json['pis'] as String?,
      cpf: json['cpf'] as String,
      appVersion: json['appVersion'] as String,
      platform: json['platform'] as String,
      device: json['device'] == null
          ? null
          : DeviceDto.fromJson(json['device'] as Map<String, dynamic>),
      geolocation: json['geolocation'] == null
          ? null
          : LocationDto.fromJson(json['geolocation'] as Map<String, dynamic>),
      fenceState: json['fenceState'] as String?,
      use: json['use'] as String,
      clockingEventId: json['clockingEventId'] as String,
      mode: $enumDecodeNullable(_$OperationModeTypeEnumMap, json['mode']),
      online: json['online'] as bool?,
      signature: json['signature'] as String,
      signatureVersion: (json['signatureVersion'] as num).toInt(),
      origin:
          $enumDecodeNullable(_$ClockingEventOriginEnumEnumMap, json['origin']),
      clientOriginInfo: json['clientOriginInfo'] as String?,
      appointmentImage: json['appointmentImage'] as String?,
      photoNotCaptured: json['photoNotCaptured'] as String?,
      locationStatus: $enumDecodeNullable(
          _$LocationStatusEnumEnumMap, json['locationStatus']),
      isSynchronized: json['isSynchronized'] as bool? ?? false,
      geolocationIsMock: json['geolocationIsMock'] as bool? ?? false,
      employeeDto: json['employeeDto'] == null
          ? null
          : EmployeeDto.fromJson(json['employeeDto'] as Map<String, dynamic>),
      companyDto: json['companyDto'] == null
          ? null
          : CompanyDto.fromJson(json['companyDto'] as Map<String, dynamic>),
      journeyId: json['journeyId'] as String?,
      isMealBreak: json['isMealBreak'] as bool?,
      facialRecognitionStatus: json['facialRecognitionStatus'] as String?,
      journeyEventName: json['journeyEventName'] as String?,
    );

Map<String, dynamic> _$ClockingEventDtoToJson(ClockingEventDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateEvent': instance.dateEvent,
      'timeEvent': instance.timeEvent,
      'timeZone': instance.timeZone,
      'companyIdentifier': instance.companyIdentifier,
      'pis': instance.pis,
      'cpf': instance.cpf,
      'appVersion': instance.appVersion,
      'platform': instance.platform,
      'device': instance.device,
      'geolocation': instance.geolocation,
      'geolocationIsMock': instance.geolocationIsMock,
      'fenceState': instance.fenceState,
      'use': instance.use,
      'clockingEventId': instance.clockingEventId,
      'mode': _$OperationModeTypeEnumMap[instance.mode],
      'online': instance.online,
      'signature': instance.signature,
      'signatureVersion': instance.signatureVersion,
      'origin': _$ClockingEventOriginEnumEnumMap[instance.origin],
      'clientOriginInfo': instance.clientOriginInfo,
      'appointmentImage': instance.appointmentImage,
      'photoNotCaptured': instance.photoNotCaptured,
      'locationStatus': _$LocationStatusEnumEnumMap[instance.locationStatus],
      'isSynchronized': instance.isSynchronized,
      'employeeDto': instance.employeeDto,
      'companyDto': instance.companyDto,
      'journeyId': instance.journeyId,
      'isMealBreak': instance.isMealBreak,
      'facialRecognitionStatus': instance.facialRecognitionStatus,
      'journeyEventName': instance.journeyEventName,
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

const _$LocationStatusEnumEnumMap = {
  LocationStatusEnum.noLocation: 'NO_LOCATION',
  LocationStatusEnum.noLocationPermission: 'NO_LOCATION_PERMISSION',
  LocationStatusEnum.location: 'LOCATION',
};
