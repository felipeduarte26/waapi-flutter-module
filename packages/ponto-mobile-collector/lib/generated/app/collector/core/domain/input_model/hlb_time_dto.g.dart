// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/hlb_time_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HlbTimeDto _$HlbTimeDtoFromJson(Map<String, dynamic> json) => HlbTimeDto(
      hlbTime: (json['hlbTime'] as num?)?.toInt(),
      defaultTimezone: json['defaultTimezone'] as String?,
    );

Map<String, dynamic> _$HlbTimeDtoToJson(HlbTimeDto instance) =>
    <String, dynamic>{
      'hlbTime': instance.hlbTime,
      'defaultTimezone': instance.defaultTimezone,
    };
