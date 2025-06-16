// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/device_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      id: json['id'] as String?,
      status: $enumDecodeNullable(_$StatusDeviceEnumMap, json['status']),
      identifier: json['identifier'] as String,
      name: json['name'] as String,
      model: json['model'] as String,
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identifier': instance.identifier,
      'name': instance.name,
      'model': instance.model,
      'status': _$StatusDeviceEnumMap[instance.status],
    };

const _$StatusDeviceEnumMap = {
  StatusDevice.pending: 'PENDING',
  StatusDevice.rejected: 'REJECTED',
  StatusDevice.authorized: 'AUTHORIZED',
  StatusDevice.authorizedByEmployee: 'AUTHORIZED_BY_EMPLOYEE',
};
