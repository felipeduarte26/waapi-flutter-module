// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/activation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivationDto _$ActivationDtoFromJson(Map<String, dynamic> json) =>
    ActivationDto(
      deviceSituation:
          $enumDecode(_$StatusDeviceEnumMap, json['deviceSituation']),
      employeeSituation: $enumDecode(
          _$ActivationSituationTypeEnumMap, json['employeeSituation']),
      requestDate: json['requestDate'] as String,
      requestTime: json['requestTime'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ActivationDtoToJson(ActivationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceSituation': _$StatusDeviceEnumMap[instance.deviceSituation]!,
      'employeeSituation':
          _$ActivationSituationTypeEnumMap[instance.employeeSituation]!,
      'requestDate': instance.requestDate,
      'requestTime': instance.requestTime,
    };

const _$StatusDeviceEnumMap = {
  StatusDevice.pending: 'PENDING',
  StatusDevice.rejected: 'REJECTED',
  StatusDevice.authorized: 'AUTHORIZED',
  StatusDevice.authorizedByEmployee: 'AUTHORIZED_BY_EMPLOYEE',
};

const _$ActivationSituationTypeEnumMap = {
  ActivationSituationType.pending: 'pending',
  ActivationSituationType.authorized: 'authorized',
  ActivationSituationType.rejected: 'rejected',
};
