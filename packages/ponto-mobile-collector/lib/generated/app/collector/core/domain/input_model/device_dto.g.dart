// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/device_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDto _$DeviceDtoFromJson(Map<String, dynamic> json) => DeviceDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imei: json['imei'] as String?,
      developerMode: $enumDecodeNullable(
          _$DeveloperModeEnumEnumMap, json['developerMode']),
      gpsOperationMode: $enumDecodeNullable(
          _$GPSoperationModeEnumEnumMap, json['gpsOperationMode']),
      dateTimeAutomatic: json['dateTimeAutomatic'] as bool?,
      timeZoneAutomatic: json['timeZoneAutomatic'] as bool?,
    )..model = json['model'] as String?;

Map<String, dynamic> _$DeviceDtoToJson(DeviceDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'imei': instance.imei,
      'developerMode': _$DeveloperModeEnumEnumMap[instance.developerMode],
      'gpsOperationMode':
          _$GPSoperationModeEnumEnumMap[instance.gpsOperationMode],
      'dateTimeAutomatic': instance.dateTimeAutomatic,
      'timeZoneAutomatic': instance.timeZoneAutomatic,
    };

const _$DeveloperModeEnumEnumMap = {
  DeveloperModeEnum.active: 'ACTIVE',
  DeveloperModeEnum.inactive: 'INACTIVE',
  DeveloperModeEnum.undefined: 'UNDEFINED',
};

const _$GPSoperationModeEnumEnumMap = {
  GPSoperationModeEnum.active: 'ACTIVE',
  GPSoperationModeEnum.inactive: 'INACTIVE',
  GPSoperationModeEnum.precision: 'PRECISION',
};
