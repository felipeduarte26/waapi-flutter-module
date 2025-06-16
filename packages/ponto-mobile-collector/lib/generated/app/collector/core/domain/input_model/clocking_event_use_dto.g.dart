// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/clocking_event_use_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockingEventUseDto _$ClockingEventUseDtoFromJson(Map<String, dynamic> json) =>
    ClockingEventUseDto(
      description: json['description'] as String,
      code: json['code'] as String,
      clockingEventUseType: $enumDecode(
          _$ClockingEventUseTypeEnumMap, json['clockingEventUseType']),
      employeeId: json['employeeId'] as String?,
    );

Map<String, dynamic> _$ClockingEventUseDtoToJson(
        ClockingEventUseDto instance) =>
    <String, dynamic>{
      'description': instance.description,
      'code': instance.code,
      'clockingEventUseType':
          _$ClockingEventUseTypeEnumMap[instance.clockingEventUseType]!,
      'employeeId': instance.employeeId,
    };

const _$ClockingEventUseTypeEnumMap = {
  ClockingEventUseType.clockingEvent: 'clockingEvent',
  ClockingEventUseType.paidBreak: 'paidBreak',
  ClockingEventUseType.mandatoryBreak: 'mandatoryBreak',
  ClockingEventUseType.driving: 'driving',
  ClockingEventUseType.waiting: 'waiting',
};
