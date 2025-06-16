import 'package:json_annotation/json_annotation.dart';

part '../../../../../generated/app/collector/core/domain/input_model/hlb_time_dto.g.dart';

@JsonSerializable()
class HlbTimeDto {
  final int? hlbTime;
  final String? defaultTimezone;

  HlbTimeDto({
    this.hlbTime,
    this.defaultTimezone,
  });

  factory HlbTimeDto.fromJson(Map<String, dynamic> json) =>
      _$HlbTimeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HlbTimeDtoToJson(this);

}
