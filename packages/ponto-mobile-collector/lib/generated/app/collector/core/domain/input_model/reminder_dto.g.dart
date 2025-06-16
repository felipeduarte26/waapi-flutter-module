// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/reminder_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderDto _$ReminderDtoFromJson(Map<String, dynamic> json) => ReminderDto(
      id: json['id'] as String,
      period: DateTime.parse(json['period'] as String),
      enabled: json['enabled'] as bool,
      type: $enumDecode(_$ReminderTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ReminderDtoToJson(ReminderDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'period': instance.period.toIso8601String(),
      'enabled': instance.enabled,
      'type': _$ReminderTypeEnumMap[instance.type]!,
    };

const _$ReminderTypeEnumMap = {
  ReminderType.intrajourney: 'INTRAJOURNEY',
  ReminderType.interjourney: 'INTERJOURNEY',
};
