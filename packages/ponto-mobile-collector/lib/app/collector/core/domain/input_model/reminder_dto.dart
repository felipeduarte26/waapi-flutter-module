import 'package:json_annotation/json_annotation.dart';

import '../enums/reminder_type.dart';
part '../../../../../generated/app/collector/core/domain/input_model/reminder_dto.g.dart';

class ReminderDto {
  late String id;
  final DateTime period;
  final bool enabled;
  final ReminderType type;

  ReminderDto({
    required this.id,
    required this.period,
    required this.enabled,
    required this.type,
  });

  factory ReminderDto.fromJson(Map<String, dynamic> json) => ReminderDto(
        id: json['id'] as String,
        period: DateTime.parse(json['period'] as String),
        enabled: json['enabled'] as bool,
        type: $enumDecode(_$ReminderTypeEnumMap, json['type']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'period': period.toIso8601String(),
        'enabled': enabled,
        'type': _reminderTypeEnumMap[type]!,
      };
}

const _reminderTypeEnumMap = {
  ReminderType.intrajourney: 'INTRAJOURNEY',
  ReminderType.interjourney: 'INTERJOURNEY',
};
